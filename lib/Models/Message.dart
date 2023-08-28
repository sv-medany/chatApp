class Message{
  String content;
  String roomid;
  String userid;
  int datetime;
  String sendername;
  String id;
  static String collectionname='Messages';
  Message(
      {
      this.id='',
    required this.roomid,
  required this.content,
  required this.datetime,
  required this.userid,
        required this.sendername
  }
      );
  Message.fromJson(Map<String,dynamic> json):this(
    roomid: json['roomid'] as String,
    content: json['content'] as String,
    datetime: json['datetime'] as int,
    userid: json['userid'] as String,
    id: json['id'] as String,
    sendername: json['sendername'] as String
  );

  Map<String,dynamic> toJson(){
    return {
      'roomid':roomid,
      'content':content,
      'datetime':datetime,
      'userid':userid,
      'id':id,
      'sendername':sendername

    };
  }

}