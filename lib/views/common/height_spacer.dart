import 'package:flutter/material.dart';

class  height_spacer extends StatelessWidget {

  const  height_spacer({super.key, required this.size});
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
    );
  }
}
