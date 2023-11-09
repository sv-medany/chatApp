import 'dart:async';

import 'package:chatapp/AddRoom/AddRoomConnect.dart';
import 'package:chatapp/AddRoom/AddRoom_ViewModel.dart';
import 'package:chatapp/Models/Category.dart';
import 'package:flutter/material.dart';
import'package:chatapp/Utils/utils.dart' as utils;

import '../Home/Home_View.dart';
class AddRoomView extends StatefulWidget {
  static String routename = 'add';
  @override
  State<AddRoomView> createState() => _AddRoomViewState();
}

class _AddRoomViewState extends State<AddRoomView> implements AddRoomConnect {
  var formkey = GlobalKey<FormState>();
  String roomname = '';
  AddRoomVm vm = AddRoomVm();
  String description = '';
  List<Category> categorylist = Category.getallcategories();
  late Category selectedcategory;
  @override
  void initState() {
    super.initState();
    selectedcategory = categorylist[0];
    vm.reg = this;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              'chatApp',
              style: Theme.of(context).primaryTextTheme.headline1,
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.08,
                horizontal: MediaQuery.of(context).size.width * 0.08),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Create New Room',textAlign: TextAlign.center,),
                  SizedBox(
                    height: 8,
                  ),
                  Image.asset('assets/images/newroom.png'),
                  TextFormField(
                    onChanged: (text) => roomname = text,
                    decoration: InputDecoration(
                      hintText: 'Enter Room Name',
                    ),
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please fill the room name field';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      DropdownButton(
                          value: selectedcategory,
                          items: categorylist
                              .map((category) => DropdownMenuItem<Category>(
                                  value: category,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(category.title),
                                      Image.asset(category.imagepath)
                                    ],
                                  )))
                              .toList(),
                          onChanged: (newcate) {
                            if (newcate == null) {
                              return;
                            }
                            selectedcategory = newcate;
                            setState(() {});
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: (text) => description = text,
                    maxLines: 4,
                    minLines: 1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Enter Room description',

                    ),
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please fill the room description';
                      }
                      return null;
                    },
                  ),
                  Spacer(),
                  ElevatedButton(onPressed: (){
                    if(formkey.currentState!.validate()){
                      vm.addRoom(roomname, description, selectedcategory.id);

                    }
                  },
                      child: Text('Create',textAlign: TextAlign.center,))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void NavigateToHome() {
    Timer(Duration(seconds: 5), (){
      Navigator.pushReplacementNamed(context, HomeScreen.routename);
    });
  }

  @override
  void hideLoading() {
   utils.hideLoading(context);
  }

  @override
  void showLoading() {
   utils.showLoading(context, 'Loading...');
  }

  @override
  void showMessage(String message) {
    utils.showMessage(context, message,'Ok' , (context){
      Navigator.pop(context);
    });
  }
}
