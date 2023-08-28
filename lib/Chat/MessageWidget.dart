import 'package:flutter/material.dart';

import '../Models/Message.dart';
import '../Models/MyUser.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  MyUser user;

  MessageWidget({required this.message , required this.user});
  @override
  Widget build(BuildContext context) {
    return  user.user_id == message.userid?
          SentWidget(message: message, datetime: DateTime.fromMillisecondsSinceEpoch(message.datetime)):
          RecievedWidget(message: message, datetime: DateTime.fromMillisecondsSinceEpoch(message.datetime));

  }
}
class SentWidget extends StatelessWidget{
  Message message;
   DateTime datetime;
  SentWidget({required this.message,required this.datetime});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight:Radius.circular(16),
              topLeft:Radius.circular(16) ,
              bottomLeft: Radius.circular(16)
            ),
            color: Colors.blue,
          ),
          child: Text(message.content,style: TextStyle(
            color: Colors.white
          ),),
        ),
        SizedBox(height: 6,),
        Text("${datetime.hour}"+':'+"${datetime.minute}" )
      ],
    );
  }


}
class RecievedWidget extends StatelessWidget {
  Message message;
  DateTime datetime;

  RecievedWidget({required this.message, required this.datetime});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16)
            ),
            color: Colors.grey,
          ),
          child: Text(message.content, style: TextStyle(
              color: Colors.black
          ),),
        ),
        SizedBox(height: 6,),
        Text("${datetime.hour}" + ':' + "${datetime.minute}")
      ],
    );
  }
}
