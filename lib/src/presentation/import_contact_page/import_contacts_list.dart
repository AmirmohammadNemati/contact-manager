import 'package:contact/src/presentation/widgets/contact_box.dart';
import 'package:contact/src/presentation/widgets/selected_bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:contacts_service/contacts_service.dart';

class SelectContactsList extends StatelessWidget {
  SelectContactsList({
    required this.contacts,
    required this.onSelected
  });
  List<Contact> contacts;
  final Function(List<Contact> selectedContacts) onSelected;

  final SelectContactsListStateManagement controller = Get.put(SelectContactsListStateManagement());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectContactsListStateManagement>(
      builder:(_)=> Column(
        children: [
          SelectedBar(
            show: true,
            count: controller.selectedIndex.length,
            onPressed: ()=>onSelected(controller.selectedContacts),
            icon: Icons.add
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index){
                return ContactBox(
                  name: contacts[index].displayName??'',
                  number: contacts[index].phones![0].value!,
                  profileColor: Color(0xFFFEFAE0),
                  isSelected: controller.selectedIndex.contains(index),
                  onTap: (){
                    controller.addOrRemoveContact(contacts[index], index);
                  }
                );
              }
            )
          )
        ]
      )
    );
  }
}

class SelectContactsListStateManagement extends GetxController{
  List<Contact> selectedContacts = [];
  List<int> selectedIndex = [];
  void addOrRemoveContact(Contact contact, int index){
    if(selectedIndex.contains(index)){
      selectedContacts.remove(contact);
      selectedIndex.remove(index);
    }else{
      selectedContacts.add(contact);
      selectedIndex.add(index);
    }
    update();
  }
}