import 'package:flutter/material.dart';
import 'package:taskmanagementapp/utils/text_styles.dart';

commonTextField(
    BuildContext context, TextEditingController controller, String lable) {
  return TextField(
    cursorColor: Colors.black,
    controller: controller,
    style: TextStyle(color: Colors.black),
    decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(),
        labelText: lable,
        labelStyle: openSansTextStyle(context)),
  );
}
