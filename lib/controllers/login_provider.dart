import 'package:flutter/material.dart';
 class loginNotifier extends ChangeNotifier{

   bool _obsecureText=true;
   bool _isLoading= false;


   bool get obsecuretext=>_obsecureText;
   bool get isLoading => _isLoading;


   set obsecuretext(bool newState){
     _obsecureText=newState;
     notifyListeners();
   }

   set isLoading(bool newState){
     _isLoading=newState;

     notifyListeners();
   }





 }