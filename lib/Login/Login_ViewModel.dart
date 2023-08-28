import 'package:chatapp/Database/Database_Utils.dart';
import 'package:chatapp/Login/LoginConnect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogVm extends ChangeNotifier{
  late LoginConnect reg;
void signin(String email,String password )async{
  try {
    reg.showLoading();
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    var user=await Database_utils.getUser(credential.user!.uid);
    print(user?.user_id);
    if(user!=null) {
      reg.hideLoading();
      reg.showMessage('Login Successful');
      reg.NavigateToHome(user);
    }
    else{
      reg.hideLoading();
      reg.showMessage('Login failed , please try again');
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      reg.hideLoading();
      reg.showMessage('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      reg.hideLoading();
      reg.showMessage('Wrong password provided for that user.');
    }
  }
}
}