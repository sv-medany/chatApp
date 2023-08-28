import 'package:chatapp/Database/Database_Utils.dart';
import 'package:chatapp/Firebase%20utils/Firebase_errors.dart';
import 'package:chatapp/Models/MyUser.dart';
import 'package:chatapp/Register/RegisterConnect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class RegVM extends ChangeNotifier{
  late RegisterConnect reg;
  bool isonscreen=false;
  void validateEmail(String emailAddress,String password,String firstname)async {
    try {
      reg.showLoading();
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      var user=MyUser(firstname: firstname, email: emailAddress, user_id: credential.user?.uid ?? '');
     var datauser=await Database_utils.register_user(user);
      reg.hideLoading();
      reg.showMessage('Registration Succesful');
      reg.NavigateToHome(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == fireBase_err.weak_password) {
        reg.hideLoading();
        reg.showMessage('The password provided is too weak.');
      } else if (e.code == fireBase_err.email_already_in_use) {
        reg.hideLoading();
        reg.showMessage('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
