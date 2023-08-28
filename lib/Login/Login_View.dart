import 'dart:async';

import 'package:chatapp/Home/Home_View.dart';
import 'package:chatapp/Login/LoginConnect.dart';
import 'package:chatapp/Login/Login_ViewModel.dart';
import 'package:chatapp/Models/MyUser.dart';
import 'package:chatapp/Providers/User_Provider.dart';
import 'package:chatapp/Register/RegisterConnect.dart';
import 'package:chatapp/Register/Register_View.dart';
import 'package:chatapp/Register/Register_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/Utils/utils.dart' as utils;

class LoginScreen extends StatefulWidget {
  static String routename='login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginConnect {
  String email = '';
  var formkey = GlobalKey<FormState>();
  String password = '';
  LogVm vm = LogVm();
  bool nshowpassword = false;

  @override
  void initState() {
    super.initState();
    vm.reg = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => vm,
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
                'Login',
                style: Theme
                    .of(context)
                    .primaryTextTheme
                    .headline1,
              ),
            ),
            body: Form(
              key: formkey,
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.28),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

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
                          if (text == null || text
                              .trim()
                              .isEmpty) {
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
                              onTap: () {
                                nshowpassword = !nshowpassword;
                                setState(() {

                                });
                              },
                              child: Icon(Icons.visibility_off))
                              : GestureDetector(
                              onTap: () {
                                nshowpassword = !nshowpassword;
                                setState(() {

                                });
                              }
                              , child: Icon(Icons.visibility)),
                        ),
                        onChanged: (text) {
                          password = text;
                        },
                        validator: (text) {
                          if (text == null || text
                              .trim()
                              .isEmpty) {
                            return 'Please enter a valid password';
                          }
                          if (text
                              .trim()
                              .length < 6) {
                            return 'Password is too short';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.17,),
                      ElevatedButton(
                          onPressed: () {
                            validateform();
                          }, child: Text('Login')),
                      InkWell(
                          onTap: ()=>Navigator.of(context).pushNamed(RegisterScreen.routename),
                          child: Text("Don't have an account?",style: TextStyle(color: Colors.blue,fontSize: 16),))
                      
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
    if (formkey.currentState!.validate()) {
      vm.signin(email, password);
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

  @override
  void NavigateToHome(MyUser? user) {
    var userprovider=Provider.of<userProvider>(context,listen: false);
    userprovider.user=user;
      Timer(Duration(seconds: 5), (){
        Navigator.pushReplacementNamed(context, HomeScreen.routename);
      });
    }
  }

