import 'package:hive/hive.dart';
part 'contact_category.g.dart';

@HiveType(typeId: 0)
class CategoryModel extends HiveObject{
  CategoryModel({required this.name});

  @HiveField(0)
  late String name;
}

@HiveType(typeId: 1)
class ContactModel extends HiveObject{
  ContactModel({required this.color, required this.number, required this.name, required this.categoryKeys});

  @HiveField(0)
  late int color;

  @HiveField(1)
  late String number;

  @HiveField(2)
  late String name;

  @HiveField(3)
  late List<int> categoryKeys;
}