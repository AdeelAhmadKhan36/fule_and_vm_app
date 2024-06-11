import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/views/common/reuse_able_text.dart';

import '../const.dart';

class Custom_Button extends StatelessWidget {

  const Custom_Button({super.key, this.height, this.width, required this.text, this.onTap, required this.color, this.color2});

  final double? height;
  final double? width;
  final String text;
  final void Function()? onTap;
  final Color color;
  final Color? color2;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color2,
          border:Border.all(
            width: 2,
            color: color,
          )
        ),
        child: Center(
          child: ReusableText(
            text: text,
            fontWeight: FontWeight.bold,
            color: Color(kOrange.value),
          ),
        ),
      ),
    );
  }
}
