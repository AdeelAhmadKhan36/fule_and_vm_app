
import 'package:flutter/cupertino.dart';

class onBoard_Notifier extends ChangeNotifier{

    bool _islistpage=false;
    bool get isLastPage=>_islistpage;

  set isLastPage(bool lastpage){

    _islistpage=lastpage;
    notifyListeners();
  }



}