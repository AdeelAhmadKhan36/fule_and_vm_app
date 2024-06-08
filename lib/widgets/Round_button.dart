import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/const.dart';


class RoundButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool loading;

  const RoundButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Color(kPrimaryColor.value),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator(
                  strokeWidth: 6,
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}
