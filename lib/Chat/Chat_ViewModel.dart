import 'dart:io';

import 'package:chatapp/Database/Database_Utils.dart';
import 'package:chatapp/ImageV/ImageView.dart';
import 'package:chatapp/Models/Message.dart';
import 'package:chatapp/Models/MyUser.dart';
import 'package:chatapp/Providers/Image_Provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Models/Room.dart';
import 'ChatConnect.dart';

class ChatVM extends ChangeNotifier {
  late ChatConnect reg;
  late Room room;
  late MyUser user;
  late Stream<QuerySnapshot<Message>> messageslist;

  void sendMessage(String content, int datetime, bool isurl) async {
    Message message = Message(roomid: room.roomid,
        content: content,
        datetime: datetime,
        userid: user.user_id,
        sendername: user.firstname,
        isurl: isurl ? 1 : 0);
    var created = await Database_utils.insertmessage(message);
    reg.ClearText();
  }
  void getMessages() {
    messageslist = Database_utils.getmessages(room.roomid);
  }

  Future<void> prepareimage(BuildContext context) async {
    var p=Provider.of<ImageProv>(context,listen: false);

    String imageUrl='';
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(
        source: ImageSource.gallery,
    );


    print('${file?.path}');
    if (file == null) return ;
    //Import dart:core
    Navigator.of(context).pushNamed(ImageView.routename,arguments: room);
    String uniqueFileName = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    /*Step 2: Upload to Firebase storage*/
    //Install firebase_storage
    //Import the library
    //Get a reference to storage root
    Reference referenceRoot =
    FirebaseStorage.instance.ref();
    Reference referenceDirImages =
    referenceRoot.child('images');
    //Create a reference for the image to be stored
    Reference referenceImageToUpload =
    referenceDirImages.child(uniqueFileName);
    //Handle errors/success
    try {
      //Store the file
      await referenceImageToUpload
          .putFile(File(file!.path));
      //Success: get the download URL
      imageUrl = await referenceImageToUpload
          .getDownloadURL();

      p.changeimageurl(imageUrl);
    } catch (error) {
      //Some error occurred
    }
    return ;
  }
}

