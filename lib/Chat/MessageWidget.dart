import 'package:flutter/material.dart';

import '../Models/Message.dart';
import '../Models/MyUser.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  MyUser user;
  bool ism;

  MessageWidget({required this.message , required this.user,required this.ism});
  @override
  Widget build(BuildContext context) {
    return  user.user_id == message.userid?
          SentWidget(message: message, datetime: DateTime.fromMillisecondsSinceEpoch(message.datetime),isurl: ism,):
          RecievedWidget(message: message, datetime: DateTime.fromMillisecondsSinceEpoch(message.datetime),isurl: ism,);

  }
}
class SentWidget extends StatelessWidget{
  Message message;
   DateTime datetime;
   bool isurl;
  SentWidget({required this.message,required this.datetime,required this.isurl});
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
          child:isurl?Image.network(message.content) :Text(message.content,style: TextStyle(
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
  bool isurl;
  RecievedWidget({required this.message, required this.datetime,required this.isurl});

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
          child:isurl?Image.network(message.content) : Text(message.content, style: TextStyle(
              color: Colors.black
          ),),
        ),
        SizedBox(height: 6,),
        Text("${datetime.hour}" + ':' + "${datetime.minute}")
      ],
    );
  }
}
