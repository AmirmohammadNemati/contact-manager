import 'package:contact/src/data/strings.dart';
import 'package:contact/src/data/colors.dart';
import 'package:contact/src/presentation/select_contact_page/select_contacts_list.dart';
import 'package:contact/src/presentation/widgets/search_field.dart';
import 'select_contact_page_state_management.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectContactPage extends StatelessWidget {
  SelectContactPage({required this.categoryKey});
  final int categoryKey;
  final SelectContactPageStateManagement controller = Get.put(SelectContactPageStateManagement());
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.selectContact, style: TextStyle(color: AppColors.mainColor)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SearchField(search: controller.search)
          ),
          Expanded(
            child: GetBuilder<SelectContactPageStateManagement>(
              id: 'list',
              builder: (_)=> SelectContactsList(
                contacts: controller.getContacts(categoryKey),
                onSelected: (selectedContacts){
                  controller.addToCategory(selectedContacts, categoryKey);
                }
              )
            )
          )
        ]
      )
    );
  }
}