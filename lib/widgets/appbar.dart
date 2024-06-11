// lib/widgets/padded_custom_app_bar.dart
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData leftIcon;
  final IconData rightIcon;
  final VoidCallback? onLeftIconPressed;
  final VoidCallback? onRightIconPressed;
  final bacgroundColor;

  CustomAppBar({
    required this.title,
    required this.leftIcon,
    required this.rightIcon,
    this.onLeftIconPressed,
    this.onRightIconPressed, this.bacgroundColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: bacgroundColor,
        leading: GestureDetector(
          onTap: onLeftIconPressed,
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFF8733),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: const Color(0xFFFF8733)),
            ),
            child: Center(
              child: Icon(leftIcon, color: Colors.white),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: onRightIconPressed,
            child: Container(
              width: 40,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFF8733),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: const Color(0xFFFF8733)),
              ),
              child: Center(
                child: Icon(rightIcon, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
