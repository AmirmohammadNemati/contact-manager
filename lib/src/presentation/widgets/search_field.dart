import 'package:contact/src/data/strings.dart';

import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  SearchField({required this.search});
  final Function(String value) search;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: search,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        hintText: AppStrings.search,
        isDense: true,
        fillColor: Colors.white10,
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
    );
  }
}