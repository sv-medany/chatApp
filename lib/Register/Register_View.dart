import 'dart:async';

import 'package:chatapp/Home/Home_View.dart';
import 'package:chatapp/Models/MyUser.dart';
import 'package:chatapp/Providers/User_Provider.dart';
import 'package:chatapp/Register/RegisterConnect.dart';
import 'package:chatapp/Register/Register_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/Utils/utils.dart' as utils;
class RegisterScreen extends StatefulWidget {
  static String routename = 'Register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements RegisterConnect {
  String email = '';

  String firstname = '';

  String password = '';

  bool nshowpassword = true;
  RegVM vm=RegVM();
  var formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm.reg=this;
  }
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context)=>vm,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Image.asset(
            'assets/images/main_bg.png',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                'Create Account',
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
            ),
            body: Form(
              key: formkey,
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'First Name',
                        ),
                        onChanged: (text) {
                          firstname = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter a valid first name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'E-mail Address',
                        ),
                        onChanged: (text) {
                          email = text;
                        },
                        validator: (text) {
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text!);
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter a valid Email';
                          }
                          if (!emailValid) {
                            return 'Please enter a valid Email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        obscureText: nshowpassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: nshowpassword
                              ? GestureDetector(
                              onTap: (){nshowpassword=!nshowpassword;
                                setState(() {

                                });
                                },
                              child: Icon(Icons.visibility_off))
                              : GestureDetector(
                              onTap: (){nshowpassword=!nshowpassword;
                                setState(() {

                                });
                                }
                              ,child: Icon(Icons.visibility)),
                        ),
                        onChanged: (text) {
                          password = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter a valid password';
                          }
                          if(text.trim().length<6){
                            return 'Password is too short';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.17,),
                      ElevatedButton(
                          onPressed: (){
                            validateform();
                          }, child: Text('Create Account'))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );

  }

  void validateform() {
    if(formkey.currentState!.validate()){

      vm.validateEmail(email, password,firstname);
    }
  }

  @override
  void hideLoading() {
    utils.hideLoading(context);
  }

  @override
  void showLoading() {
    utils.showLoading(context, 'Loading....');
  }

  @override
  void showMessage(String message) {
    utils.showMessage(context, message, 'ok', (context){
      Navigator.pop(context);
    });
  }

  void NavigateToHome(MyUser? user) {
    var userprovider=Provider.of<userProvider>(context);
    userprovider.user=user;
    Timer(Duration(seconds: 5),(){
      Navigator.of(context).pushReplacementNamed(HomeScreen.routename);
    });
  }

}
