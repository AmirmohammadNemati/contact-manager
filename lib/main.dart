import 'src/data/boxes.dart';
import 'contact_category/contact_category.dart';
import 'src/presentation/home_page/home_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(ContactModelAdapter());
  AppHiveBoxes.categories = await Hive.openBox<CategoryModel>('categories');
  AppHiveBoxes.contacts = await Hive.openBox<ContactModel>('contacts');
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/home', page: ()=>HomePage())
      ],
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: HomePage()
      //home: TicketingPage(
      //  link: 'https://supporttest-25685-default-rtdb.firebaseio.com/ticketsList.json',
      //  addLink: 'https://supporttest-25685-default-rtdb.firebaseio.com/ticketsList/6.json',
      //  fullName: 'Amirmohammad Nemati',
      //  profileUrl: 'https://play-lh.googleusercontent.com/LByrur1mTmPeNr0ljI-uAUcct1rzmTve5Esau1SwoAzjBXQUby6uHIfHbF9TAT51mgHm',
      //)
    );
  }
}