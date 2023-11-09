import 'package:chatapp/Database/Database_Utils.dart';
import 'package:chatapp/Models/MyUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ImageProv extends ChangeNotifier{
 String imageurl='';
 void changeimageurl(String imageurll){
   imageurl=imageurll;
   notifyListeners();
 }
}