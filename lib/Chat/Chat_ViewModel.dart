import 'package:chatapp/Database/Database_Utils.dart';
import 'package:chatapp/Models/Message.dart';
import 'package:chatapp/Models/MyUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/Room.dart';
import 'ChatConnect.dart';

class ChatVM extends ChangeNotifier{
  late ChatConnect reg;
  late Room room;
  late MyUser user;
  late Stream<QuerySnapshot<Message>> messageslist;
  void sendMessage(String content,int datetime)async{
    Message message =Message(roomid: room.roomid, content: content, datetime: datetime, userid: user.user_id, sendername: user.firstname);
    var created = await Database_utils.insertmessage(message);
    reg.ClearText();
  }
  void getMessages(){
    messageslist=Database_utils.getmessages(room.roomid);
  }
}
