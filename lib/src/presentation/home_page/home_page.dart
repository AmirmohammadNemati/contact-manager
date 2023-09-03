import 'package:contact/src/data/strings.dart';
import 'package:contact/src/data/lists.dart';
import 'package:contact/src/data/colors.dart';
import 'package:contact/contact_category/contact_category.dart';
import 'package:contact/src/presentation/home_page/contacts_list.dart';
import 'package:contact/src/presentation/home_page/all_contacts_list.dart';
import 'package:contact/src/presentation/widgets/search_field.dart';
import 'package:contact/src/presentation/select_contact_page/select_contact_page.dart';
import 'package:contact/src/presentation/widgets/dialogs.dart';
import 'home_page_state_management.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class HomePage extends StatelessWidget {
  final HomePageStateManagement controller = Get.put(HomePageStateManagement());
  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: GetBuilder<HomePageStateManagement>(
        id: 'FAB',
        builder:(_)=> Visibility(
          visible: controller.categoryKey == null,
          child: GestureDetector(
            onLongPress: controller.changeFABState,
            child: FloatingActionButton(
              backgroundColor: AppColors.mainColor,
              onPressed: controller.fabStates == FABStates.add?(){
                addContactDialog(
                  context, (name, number) {
                    controller.addContact(
                      ContactModel(
                        color: AppLists.randomColors[Random().nextInt(AppLists.randomColors.length)],
                        number: number,
                        name: name,
                        categoryKeys: []
                      )
                    );
                    Get.back();
                  }
                );
              }:(){
                controller.askPermissions();
              },
              child: controller.fabStates == FABStates.add?const Icon(Icons.add):const Icon(Icons.arrow_upward)
            )
          )
        )
      ),
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.contact, style: TextStyle(color: AppColors.mainColor)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: GetBuilder<HomePageStateManagement>(
            id: 'tabs',
            builder:(_){
              List<SizedBox> categories = controller.categories.map((e) => SizedBox(
                height: 30,
                child: Center(
                  child: Text(e.name)
                )
              )).toList();
              categories.insert(0, const SizedBox(
                height: 30,
                child: Center(
                  child: Text(AppStrings.all)
                )
              ));
              return DefaultTabController(
                length: categories.length,
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  onTap: (int index){
                    controller.changeCategoryKey(index == 0?null:controller.categories[index-1].key, index);
                  },
                  indicatorColor: AppColors.mainColor,
                  isScrollable: true,
                  tabs: categories
                )
              );
            }
          )
        ),
        actions: [
          IconButton(
            splashRadius: 25,
            onPressed: ()=>addCategoryDialog(
              context, (String name){
                controller.addCategory(name);
                Get.back();
              }
            ),
            icon: const Icon(Icons.add, color: AppColors.mainColor)
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GetBuilder<HomePageStateManagement>(
              id: 'deleteB',
              builder:(_)=> Visibility(
                visible: controller.categoryKey!=null,
                child: IconButton(
                  splashRadius: 25,
                  onPressed: ()=> deleteCategoryDialog(
                    context, controller.categoryName(),
                    controller.deleteCategory
                  ),
                  icon: const Icon(Icons.delete, color: AppColors.mainColor)
                )
              )
            )
          )
        ]
      ),
      body: Column(
        children: [
          GetBuilder<HomePageStateManagement>(
            id: 'addContactB',
            builder:(_)=> Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: SearchField(search: controller.search)),
                    Visibility(
                      visible: controller.categoryKey!=null,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SizedBox(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white10,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                            ),
                            child: const Icon(Icons.add, color: AppColors.mainColor),
                            onPressed: (){
                              Get.to(SelectContactPage(categoryKey: controller.categoryKey!));
                              Get.delete<HomePageStateManagement>();
                            }
                          )
                        )
                      )
                    )
                  ]
                )
              )
            )
          ),
          Expanded(
            child: GetBuilder<HomePageStateManagement>(
              id: 'list',
              builder: (_){
                if(controller.categoryKey == null){
                  return AllContactsList(
                    contacts: controller.getContacts(),
                    deleteContact: controller.deleteContact,
                  );
                }else{
                  return ContactsList(
                    contacts: controller.getContacts(),
                    onSelected: controller.removeFromCategory
                  );
                }
              }
            )
          )
        ]
      )
    );
  }
}