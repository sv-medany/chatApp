import 'package:chatapp/AddRoom/AddRoomConnect.dart';
import 'package:chatapp/Database/Database_Utils.dart';
import 'package:flutter/material.dart';

import '../Models/Room.dart';

class AddRoomVm extends ChangeNotifier{
  late AddRoomConnect reg;
  void addRoom(String roomtitle, String roomdesc , String categoryid) async{

    Room r =Room(categoryid: categoryid , title: roomtitle, description: roomdesc,roomid: '');
    try{
      reg.showLoading();
      var created= await Database_utils.addroom(r);
      reg.hideLoading();
      reg.showMessage('Sucessfully added');
    }catch(e){
      reg.hideLoading();
      reg.showMessage(e.toString());
    }



  }
}
