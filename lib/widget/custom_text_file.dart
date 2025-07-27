import 'package:flutter/material.dart';
import 'package:small_business_app/configuration/colors.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled(
      {super.key,
      required this.hint,
      this.maxLine = 1,
      this.onTap,
      this.readOnly = false,
      this.icon,
      this.isIcon = false,
      this.controller,
      this.validator});
  final dynamic controller;
  final String hint;
  final IconData? icon;
  final int maxLine;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool readOnly;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      validator: validator,
      controller: controller,
      maxLines: maxLine,
      decoration: InputDecoration(
          prefixIcon: isIcon == true
              ? Icon(
                  icon,
                  color: primaryColor,
                )
              : null,
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
          hintText: hint,
          hintStyle: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: primaryColor),
          fillColor: fillColor,
          filled: true),
    );
  }
}

OutlineInputBorder buildBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: fillColor));
}
