import 'package:contact/src/data/colors.dart';

import 'package:flutter/material.dart';

class ContactBox extends StatelessWidget {
  ContactBox({
    required this.name,
    required this.number,
    this.icon,
    this.isSelected = false,
    required this.profileColor,
    required this.onTap,
    this.onButtonPress,
    this.onLongPress
  });
  final String name;
  final String number;
  final bool isSelected;
  final Color profileColor;
  final IconData? icon;
  final Function() onTap;
  final Function()? onButtonPress;
  final Function()? onLongPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: ListTile(
        trailing: icon!=null?IconButton(
          onPressed: onButtonPress,
          icon: Icon(icon, color: AppColors.mainColor, size: 20),
        ):null,
        tileColor: isSelected?Colors.black12:null,
        dense: true,
        leading: Container(
          height: 30,
          width: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                color: Colors.white.withOpacity(0.1),
                offset: const Offset(-3, -3),
              ),
              BoxShadow(
                blurRadius: 7,
                color: Colors.black.withOpacity(0.7),
                offset: const Offset(3, 3),
              )
            ],
            borderRadius: BorderRadius.circular(6),
            color:const Color(0xff262626)
          ),
          child: isSelected?Icon(
            Icons.check,
            color: profileColor
          ):Text(
            name.isNotEmpty?name[0]:'',
            style: TextStyle(
              fontSize: 23,
              color: profileColor,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500
            )
          )
        ),
        title: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.mainColor,
            fontWeight: FontWeight.w500
          )
        ),
        subtitle: Text(
          number,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.mainColor,
            fontWeight: FontWeight.w400
          )
        ),
        horizontalTitleGap: 12
      )
    );
  }
}