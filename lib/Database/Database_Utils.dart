import 'package:chatapp/Models/MyUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/Message.dart';
import '../Models/Room.dart';
class Database_utils{

  static CollectionReference<MyUser> getcollection(){
    return FirebaseFirestore.instance.collection(MyUser.collection_name).
    withConverter<MyUser>(fromFirestore: (snapshot,options)=>MyUser.fromjson(snapshot.data()!) ,
        toFirestore: (user,options)=> user.toJson());
  }
  static Future<void> register_user(MyUser user) async{
    return getcollection().doc(user.user_id).set(user);
  }
  static Stream<QuerySnapshot<Room>> getrooms() {
    return getroomcollection().snapshots();
  }
  static  Future<MyUser?> getUser(String id)async{
  var snapshot=await  getcollection().doc(id).get();
  var user1=snapshot.data();
  return user1;
  }
  static CollectionReference<Message> getmessagecollection(String roomid){
    return FirebaseFirestore.instance.collection(Room.collectionname).doc(roomid).collection(Message.collectionname).withConverter<Message>
      (fromFirestore: (snapshot,options)=>Message.fromJson(snapshot.data()!),
        toFirestore: (message,options)=>message.toJson());
}
static Stream<QuerySnapshot<Message>> getmessages(String roomid){
    return getmessagecollection(roomid).orderBy('datetime').snapshots();
}
 static Future<void> insertmessage (Message message) {
    var collectionref=getmessagecollection(message.roomid);
    var doc=collectionref.doc();
    message.id=doc.id;
    return doc.set(message);
}
 static CollectionReference<Room> getroomcollection(){
    return FirebaseFirestore.instance.collection(Room.collectionname).withConverter<Room>
      (fromFirestore: (snapshot,options)=>Room.fromjson(snapshot.data()!),
        toFirestore: (room,options)=>room.toJson());
 }
 static Future<void> addroom(Room r) async{
   var collectionref=getroomcollection().doc();
   r.roomid=collectionref.id;
   return collectionref.set(r);
 }


}