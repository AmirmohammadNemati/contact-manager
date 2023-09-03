import 'package:contact/src/data/boxes.dart';
import 'package:contact/contact_category/contact_category.dart';

import 'package:get/get.dart';
class SelectContactPageStateManagement extends GetxController{
  String searched = '';
  List<ContactModel> getContacts(int categoryKey){
    return AppHiveBoxes.contacts.values.where(
      (element) => !element.categoryKeys.contains(categoryKey)&&element.name.contains(searched)
    ).toList();
  }

  void search(String value){
    searched = value;
    update(['list']);
  }

  void addToCategory(List<ContactModel> contacts, int categoryKey){
    contacts.forEach(
      (element) {
        List<int> newCategories = element.categoryKeys;
        newCategories.add(categoryKey);
        AppHiveBoxes.contacts.put(
          element.key,
          ContactModel(
            color: element.color,
            number: element.number,
            name: element.name,
            categoryKeys: newCategories
          )
        );
      }
    );
    Get.delete<SelectContactPageStateManagement>();
    Get.offNamed('/home');
  }
}