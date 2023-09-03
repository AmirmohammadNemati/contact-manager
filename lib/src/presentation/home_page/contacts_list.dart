import 'package:contact/contact_category/contact_category.dart';
import 'package:contact/src/presentation/widgets/contact_box.dart';
import 'package:contact/src/presentation/widgets/selected_bar.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class ContactsList extends StatelessWidget {
  ContactsList({
    required this.contacts,
    required this.onSelected
  });
  final List<ContactModel> contacts;
  final Function(List<ContactModel> selectedContacts) onSelected;

  final ContactsListStateManagement controller = Get.put(ContactsListStateManagement());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactsListStateManagement>(
      builder:(_)=> Column(
        children: [
          SelectedBar(
            show: controller.selectedIndex.isNotEmpty,
            count: controller.selectedIndex.length,
            onPressed: (){
              onSelected(controller.selectedContacts);
              controller.reset();
            },
            icon: Icons.delete
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index){
                return ContactBox(
                  name: contacts[index].name,
                  number: contacts[index].number,
                  profileColor: Color(contacts[index].color),
                  isSelected: controller.selectedIndex.contains(index),
                  onTap: controller.selectedIndex.isEmpty?(){
                    launchUrl(Uri.parse('tel://${contacts[index].number}'));
                  }:(){
                    controller.addOrRemoveContact(contacts[index],index);
                  },
                  onLongPress: controller.selectedIndex.isEmpty?(){
                    controller.addOrRemoveContact(contacts[index],index);
                  }:null
                );
              }
            )
          )
        ]
      )
    );
  }
}

class ContactsListStateManagement extends GetxController{
  List<ContactModel> selectedContacts = [];
  List<int> selectedIndex = [];
  void addOrRemoveContact(ContactModel contact, int index){
    if(selectedIndex.contains(index)){
      selectedContacts.remove(contact);
      selectedIndex.remove(index);
    }else{
      selectedContacts.add(contact);
      selectedIndex.add(index);
    }
    update();
  }

  void reset(){
    selectedContacts = [];
    selectedIndex = [];
    update();
  }
}