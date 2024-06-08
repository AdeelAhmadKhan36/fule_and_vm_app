import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class  Utils {
  void  toastMessage(String Message){

    Fluttertoast.showToast(
        msg: Message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}


class UtilMessage{

  void  toastMessage(String Message){

    Fluttertoast.showToast(
        msg: Message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}