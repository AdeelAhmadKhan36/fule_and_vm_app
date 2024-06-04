import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Custom_Text_Field extends StatelessWidget {
  Custom_Text_Field({
    Key? key,
    required this.hintText,
    this.keyboard,
    this.validator,
    this.suffixicon,
    this.onEditingComplete,
    this.obsecureText, required this.controller,
    required Color cursorColor,
  }) : super(key: key);
   final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;
  final Widget? suffixicon;
  final void Function()? onEditingComplete;
  final bool? obsecureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        keyboardType: keyboard,
        obscureText: obsecureText ?? false,
        onEditingComplete: onEditingComplete,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText.toUpperCase(),
          hintStyle: TextStyle(
            color: Colors.white, // Customize the color as needed
            fontWeight: FontWeight.bold,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          suffixIcon: suffixicon,
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          // ),
          // filled: true,
          fillColor: Colors.white, // Change this color as needed
        ),
        validator: validator,
      ),
    );
  }
}
