import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Database/Database_Utils.dart';
import '../Models/Message.dart';
import '../Models/MyUser.dart';
import '../Models/Room.dart';

class ImageVm extends ChangeNotifier {
  late MyUser user;
  late Room room;
  void sendMessage(String content, int datetime) async {
    Message message = Message(roomid: room.roomid,
        content: content,
        datetime: datetime,
        userid: user.user_id,
        sendername: user.firstname,
        isurl: 1);
    var created = await Database_utils.insertmessage(message);

  }
}