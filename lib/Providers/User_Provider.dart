import 'package:chatapp/Database/Database_Utils.dart';
import 'package:chatapp/Models/MyUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class userProvider extends ChangeNotifier{
  MyUser? user;
  User? firebase_user;
  userProvider(){
    firebase_user=FirebaseAuth.instance.currentUser;
    inituser();
  }
inituser()async{
  if(firebase_user!=null){
    user=await Database_utils.getUser(firebase_user!.uid);
  }
  else{
    user=null;
  }
}
}