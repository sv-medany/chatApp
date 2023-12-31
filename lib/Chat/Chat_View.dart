import 'dart:io';

import 'package:chatapp/Chat/ChatConnect.dart';
import 'package:chatapp/Chat/Chat_ViewModel.dart';
import 'package:chatapp/Chat/MessageWidget.dart';
import 'package:chatapp/ImageV/ImageView.dart';
import 'package:chatapp/Models/Room.dart';
import 'package:chatapp/Providers/User_Provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';

import '../Models/Message.dart';

class ChatView extends StatefulWidget {
  static String routename = 'chat';
  @override
  State<ChatView> createState() => _ChatViewState();
}
class _ChatViewState extends State<ChatView> implements ChatConnect {
  ChatVM vm = ChatVM();
  String content = '';
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    vm.reg = this;
  }


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<userProvider>(context);
    vm.user = provider.user!;
    var args = ModalRoute.of(context)?.settings.arguments as Room;
    vm.room = args;
    vm.getMessages();
    return ChangeNotifierProvider(
      create: (context) => vm,
      child: Stack(children: [
        Container(
          color: Colors.white,
        ),
        Image.asset(
          'assets/images/main_bg.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              '${args.title}',
              style: Theme.of(context).primaryTextTheme.headline1,
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.03,
                horizontal: MediaQuery.of(context).size.width * 0.03),
            width: double.infinity,
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
                Expanded(
                    child: StreamBuilder<QuerySnapshot<Message>>(
                  stream: vm.messageslist,
                  builder: (context, asyncsnapshot) {
                    if (asyncsnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (asyncsnapshot.hasError) {
                      return Text(asyncsnapshot.error.toString());
                    }
                    var list = asyncsnapshot.data?.docs
                            .map((doc) => doc.data())
                            .toList() ??
                        [];
                    return ListView.builder(
                      controller: _scrollController,
                      itemBuilder: (context, index) =>
                          MessageWidget(message: list[index], user: vm.user, ism: list[index].isurl ==1 ? true : false),
                      itemCount: list.length,
                    );
                  },
                )),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      onChanged: (text) {
                        content = text;
                      },
                      controller: controller,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () async {
                            /*  ImagePicker imagePicker = ImagePicker();
                              XFile? file = await imagePicker.pickImage(
                                  source: ImageSource.gallery);
                              print('${file?.path}');
                              if (file == null) return;
                              //Import dart:core
                              String uniqueFileName = DateTime.now()
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

                              } catch (error) {
                                //Some error occurred
                              }*/
                              await vm.prepareimage(context);
                            },
                            icon: Icon(Icons.photo),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16)),
                          ),
                          hintText: 'Enter your message here'),
                    )),
                    SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        onPressed: () {
                           if (content.isNotEmpty ) {
                            var datetime =
                                DateTime.now().millisecondsSinceEpoch;
                            vm.sendMessage(content, datetime,false);
                            content='';
                          }
                        },
                        child: Row(
                          children: [Text('Send'), Icon(Icons.send)],
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  @override
  void ClearText() {
    controller.clear();
  }

  @override
  void navigateToImageView() {

  }
}
