import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/const.dart';

class RoundedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final BorderRadiusGeometry borderRadius;


  const RoundedAppBar({
    Key? key,
    required this.title,
    this.borderRadius = const BorderRadius.only(
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: AppBar(
        title: title,
        backgroundColor: Color(kPrimaryColor.value),
        centerTitle: true,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);

            },
            child: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
