

import 'package:flutter/widgets.dart';

class changeprofileNotifier extends ChangeNotifier{

  bool _profileLoading= false;
  bool get isLoading => _profileLoading;


  set isLoading(bool newState){
    _profileLoading=newState;

    notifyListeners();
  }


}