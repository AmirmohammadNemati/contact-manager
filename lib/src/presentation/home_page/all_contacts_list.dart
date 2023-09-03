import 'package:contact/contact_category/contact_category.dart';
import 'package:contact/src/presentation/widgets/contact_box.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AllContactsList extends StatelessWidget {
  AllContactsList({required this.contacts, required this.deleteContact});
  final List<ContactModel> contacts;
  final Function(int key) deleteContact;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (BuildContext context, int index){
        return ContactBox(
          name: contacts[index].name,
          number: contacts[index].number,
          icon: Icons.delete,
          profileColor: Color(contacts[index].color),
          onTap: (){
            launchUrl(Uri.parse('tel://${contacts[index].number}'));
          },
          onButtonPress: ()=> deleteContact(contacts[index].key),
          onLongPress: (){}
        );
      }
    );
  }
}
