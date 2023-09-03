import 'package:contact/contact_category/contact_category.dart';
import 'package:contact/src/presentation/widgets/contact_box.dart';
import 'package:contact/src/presentation/widgets/selected_bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectContactsList extends StatelessWidget {
  SelectContactsList({
    required this.contacts,
    required this.onSelected
  });
  final List<ContactModel> contacts;
  final Function(List<ContactModel> selectedContacts) onSelected;

  final SelectContactsListStateManagement controller = Get.put(SelectContactsListStateManagement());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectContactsListStateManagement>(
      builder:(_)=> Column(
        children: [
          SelectedBar(
            show: true,
            count: controller.selectedKeys.length,
            onPressed: ()=>onSelected(controller.selectedContacts),
            icon: Icons.add
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index){
                return ContactBox(
                  name: contacts[index].name,
                  number: contacts[index].number,
                  profileColor: Color(contacts[index].color),
                  isSelected: controller.selectedKeys.contains(contacts[index].key),
                  onTap: (){
                    controller.addOrRemoveContact(contacts[index]);
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
  List<ContactModel> selectedContacts = [];
  List<int> selectedKeys = [];
  void addOrRemoveContact(ContactModel contact){
    if(selectedKeys.contains(contact.key)){
      selectedContacts.remove(contact);
      selectedKeys.remove(contact.key);
    }else{
      selectedContacts.add(contact);
      selectedKeys.add(contact.key);
    }
    update();
  }
}