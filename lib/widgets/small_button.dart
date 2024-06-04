import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/const.dart';
class SmallButton extends StatelessWidget {
  const SmallButton({super.key, this.bgcolr, this.cusicons, this.iconcolr, required this.height, required this.width});
 final bgcolr;
 final iconcolr;
 final cusicons;
 final double height;
 final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: bgcolr,
        borderRadius: BorderRadius.circular(14),
         boxShadow: [BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 0.5,
              color: lightblackcolr,
            )],
      ),
      child: Icon(cusicons,color: iconcolr,),
    );
  }
}