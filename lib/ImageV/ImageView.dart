import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/ImageV/Image_Vm.dart';
import 'package:chatapp/Providers/Image_Provider.dart';
import 'package:chatapp/Providers/User_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/Room.dart';

class ImageView extends StatefulWidget {
  static String routename='image';

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  ImageVm vm=ImageVm();
  @override
  Widget build(BuildContext context) {
    var provi= Provider.of<ImageProv>(context);
   var room=ModalRoute.of(context)?.settings.arguments as Room;
   print("hi");
   vm.user = Provider.of<userProvider>(context).user!;
   vm.room = room;
   return MultiProvider(
     providers: [ChangeNotifierProvider(
        create: (context)=>provi),
       ChangeNotifierProvider(
           create: (context)=>vm),
    ],
        child: Scaffold(
          body: Column(
            children: [
            CachedNetworkImage(
            imageUrl: provi.imageurl,
            placeholder: (context, url) => CircularProgressIndicator(), // Your placeholder widget
            errorWidget: (context, url, error) => Icon(Icons.error), // Your error widget
          ),
              ElevatedButton(
      onPressed: provi.imageurl.isNotEmpty?(){
        vm.sendMessage(provi.imageurl, DateTime.now().millisecondsSinceEpoch);
        Navigator.pop(context);
      }:null,

            child: Text('send'))
            ],
          ),
        ),
      );

  }

}
