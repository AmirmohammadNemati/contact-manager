import 'package:contact/src/data/strings.dart';
import 'package:contact/src/data/colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
void addCategoryDialog(BuildContext context, Function(String name)onPressed){
  TextEditingController name = TextEditingController();
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        content: TextField(
          controller: name,
          autocorrect: false,
          enableSuggestions: false,
          decoration: InputDecoration(
            hintText: AppStrings.categoryName,
            isDense: true,
            fillColor: Colors.black12,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)
            )
          )
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor
            ),
            onPressed: ()=>onPressed(name.text),
            child: const Text(AppStrings.add, style: TextStyle(color: Colors.black))
          )
        ]
      );
    }
  );
}


void addContactDialog(BuildContext context, Function(String name, String number)onPressed){
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: name,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  hintText: AppStrings.contactName,
                  isDense: true,
                  fillColor: Colors.black12,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8)
                  )
                )
              )
            ),
            TextField(
              keyboardType: TextInputType.phone,
              controller: number,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                hintText: AppStrings.contactNumber,
                isDense: true,
                fillColor: Colors.black12,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8)
                )
              )
            )
          ]
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor
            ),
            onPressed: ()=>onPressed(name.text, number.text),
            child: const Text(AppStrings.add, style: TextStyle(color: Colors.black))
          )
        ]
      );
    }
  );
}

void deleteCategoryDialog(BuildContext context, String categoryName, Function() onPressed){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        content: Text(
          AppStrings.deleteSure(categoryName),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            height: 1.4,
            color: AppColors.mainColor
          )
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor
            ),
            onPressed: ()=>Get.back(),
            child: const Text(AppStrings.cancel, style: TextStyle(color: Colors.black))
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor
            ),
            onPressed: (){
              onPressed();
              Get.back();
            },
            child: const Text(AppStrings.delete, style: TextStyle(color: Colors.black))
          )
        ]
      );
    }
  );
}