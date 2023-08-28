import 'package:chatapp/Chat/Chat_View.dart';
import 'package:flutter/material.dart';

import '../Models/Room.dart';

class RoomWidget extends StatelessWidget {

Room room;
RoomWidget({required this.room});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(ChatView.routename,
        arguments: room
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
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
        child: Column(
children: [
  Image.asset('assets/images/${room.categoryid.toLowerCase()}.png',height: 100,),
  SizedBox(height: 8,),
  Text('${room.title}')
],
        ),
      ),
    );
  }
}
