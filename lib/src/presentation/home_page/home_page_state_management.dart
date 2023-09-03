import 'package:contact/src/data/boxes.dart';
import 'package:contact/contact_category/contact_category.dart';
import 'package:contact/src/presentation/import_contact_page/import_contact_page.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

enum FABStates{
  add,
  import
}
class HomePageStateManagement extends GetxController with GetSingleTickerProviderStateMixin {
  int? categoryKey;
  int categoryIndex = 0;
  List<CategoryModel> categories = AppHiveBoxes.categories.values.toList();
  String searched = '';
  FABStates fabStates = FABStates.add;

  void addCategory(String name){
    AppHiveBoxes.categories.add(
      CategoryModel(
        name: name
      )
    );
    categories = AppHiveBoxes.categories.values.toList();
    update(['tabs']);
  }

  void changeCategoryKey(int? key, int index){
    categoryKey = key;
    categoryIndex = index;
    update(['list', 'FAB', 'addContactB', 'deleteB']);
  }

  void addContact(ContactModel contact){
    AppHiveBoxes.contacts.add(contact);
    update(['list']);
  }

  void search(String value){
    searched = value;
    update(['list']);
  }

  List<ContactModel> getContacts(){
    if(categoryKey == null){
      return AppHiveBoxes.contacts.values.where(
        (element) => element.name.contains(searched)
      ).toList();
    }else{
      return AppHiveBoxes.contacts.values.where(
        (element) => element.categoryKeys.contains(categoryKey)&&element.name.contains(searched)
      ).toList();
    }
  }

  void deleteContact(int key){
    AppHiveBoxes.contacts.delete(key);
    update(['list']);
  }

  String categoryName(){
    return AppHiveBoxes.categories.get(categoryKey)!.name;
  }

  void deleteCategory(){
    int newCategoryKey = categoryKey!;
    if(categories.length == categoryIndex){
      newCategoryKey = categories[categoryIndex-2].key;
      categoryIndex--;
    }else{
      newCategoryKey = categories[categoryIndex].key;
    }
    AppHiveBoxes.categories.delete(categoryKey);
    categories = AppHiveBoxes.categories.values.toList();
    categoryKey = newCategoryKey;
    update(['tabs','list', 'FAB', 'addContactB', 'deleteB']);
  }

  void removeFromCategory(List<ContactModel> contacts){
    contacts.forEach(
      (element) {
        List<int> newCategories = element.categoryKeys;
        newCategories.remove(categoryKey!);
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
    update(['list']);
  }

  void changeFABState(){
    switch (fabStates){
      case FABStates.add:{
        fabStates = FABStates.import;
      }
      break;
      case FABStates.import:{
        fabStates = FABStates.add;
      }
      break;
    }
    update(['FAB']);
  }


  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      Get.to(ImportContactPage());
    }else{
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }
}