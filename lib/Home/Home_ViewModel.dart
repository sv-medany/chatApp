import 'package:chatapp/Database/Database_Utils.dart';
import 'package:chatapp/Home/HomeConnect.dart';
import 'package:flutter/material.dart';

class HomeVm extends ChangeNotifier {
  late HomeConnect reg;
  void showrooms(){
    Database_utils.getrooms();
  }

}