import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/const.dart';
import 'package:get/get.dart';

class customButton extends StatelessWidget {
  const customButton({super.key, this.bottontext,this.bottoncolr, this.bottontextcolr, this.onpressed});
  final bottontext;
  final bottoncolr;
  final bottontextcolr;
  final onpressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: 
     onpressed,
      
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          height: 65,
          width: Get.width,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 2,
              color: blackcolr,
            )],
              color: bottoncolr, borderRadius: BorderRadius.circular(13)),
        
        child: Center(child: Text(
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: bottontextcolr),
          bottontext.toString())),
        ),
      ),
    );
  }
}
