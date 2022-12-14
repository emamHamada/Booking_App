import 'package:booking_app/src/app/core/utils/colors_manager.dart';
import 'package:booking_app/src/app/core/utils/text_styles_manager.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String hintText;
  TextEditingController? controller;
  String Function(String?)? onFieldSubmitted;
  bool? isDark;
  String? Function(String?)? validator;
  IconData? suffixIcon;
  TextInputType? keyboardType;
  VoidCallback? onTapFunction;
  bool? hasShadow;

  AppTextFormField({
    Key? key,
    required this.hintText,
    this.controller,
    this.validator,
    this.isDark = false,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.keyboardType,
    this.onTapFunction,
    this.hasShadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: hasShadow! ? Colors.grey.shade300 : Colors.transparent,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 10)),
      ]),
      child: TextFormField(
        onTap: onTapFunction,
        keyboardType: keyboardType,
        onSaved: onFieldSubmitted,
        controller: controller,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        cursorColor: isDark! ? ColorManager.lightGrey : Colors.black,
        style: TextStyle(
          color: isDark! ? Colors.white : Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          hintText: hintText,
          hintStyle: getCaptionStyle(
              color: ColorManager.lightGrey, fontSize: FontSize.s14),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(30),
          ),
          fillColor: isDark! ? ColorManager.greyFiller : Colors.white,
          filled: true,
          suffixIcon: Icon(suffixIcon),
        ),
      ),
    );
  }
}
