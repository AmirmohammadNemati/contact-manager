import 'package:contact/src/data/strings.dart';
import 'package:contact/src/data/colors.dart';
import 'import_contacts_list.dart';

import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ImportContactPage extends StatelessWidget {
  Future<List<Contact>> getContacts()async{
    List<Contact> allContacts = await ContactsService.getContacts(withThumbnails: false);
    List<Contact> fixedContacts = [];
    allContacts.forEach((element) {if(element.phones!.isNotEmpty){fixedContacts.add(element);}});
    return fixedContacts;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.selectContact, style: TextStyle(color: AppColors.mainColor)),
      ),
      body: FutureBuilder(
        future: getContacts(),
        builder:(BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if(snapshot.hasData){
            return SelectContactsList(
              contacts: snapshot.data!,
              onSelected: (selectedContacts) {
                //controller.addToCategory(selectedContacts, categoryKey);
              }
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      )
    );
  }
}
