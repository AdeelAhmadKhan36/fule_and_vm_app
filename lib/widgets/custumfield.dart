import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/const.dart';

class Custumfield extends StatelessWidget {
  const Custumfield({super.key, required this.TextFormFieldvalu});
  final String TextFormFieldvalu;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        
        decoration: InputDecoration(
        labelText: TextFormFieldvalu,
          fillColor: Whitecolr,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Whitecolr,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Whitecolr,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
