import 'package:contact/contact_category/contact_category.dart';

import 'package:hive/hive.dart';
class AppHiveBoxes{
  static late Box<CategoryModel> categories;
  static late Box<ContactModel> contacts;
}