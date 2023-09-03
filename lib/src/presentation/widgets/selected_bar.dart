import 'package:contact/src/data/colors.dart';
import 'package:contact/src/data/strings.dart';

import 'package:flutter/material.dart';

class SelectedBar extends StatelessWidget {
  SelectedBar({
    required this.show,
    required this.count,
    required this.icon,
    required this.onPressed
  });
  final bool show;
  final int count;
  final Function() onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: show,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$count ${AppStrings.selected}',
              style: const TextStyle(
                fontSize: 25,
                color: AppColors.mainColor,
                fontWeight: FontWeight.w600
              )
            ),
            IconButton(
              splashRadius: 30,
              onPressed: onPressed,
              icon: Icon(icon, size: 25)
            )
          ]
        )
      )
    );
  }
}
