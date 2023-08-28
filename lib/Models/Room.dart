class Room{
  static String collectionname='rooms';
  String roomid;
  String description;
  String title;
  String categoryid;
  Room({required this.roomid,required this.description,required this.title,required this.categoryid});
  Room.fromjson(Map<String,dynamic> json):
  this(
  roomid: json['roomid'] as String,
        description: json['description'] as String,
        title: json['title'] as String,
        categoryid: json['categoryid'] as String
  );
  Map<String,dynamic> toJson(){
    return {
      'description':description,
      'roomid':roomid,
      'title':title,
      'categoryid':categoryid
    };
  }
}