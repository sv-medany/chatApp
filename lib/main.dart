import 'package:chatapp/AddRoom/AddRoom_View.dart';
import 'package:chatapp/Chat/Chat_View.dart';
import 'package:chatapp/Home/Home_View.dart';
import 'package:chatapp/Login/Login_View.dart';
import 'package:chatapp/Providers/User_Provider.dart';
import 'package:chatapp/Register/Register_View.dart';
import 'package:chatapp/Theme/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context)=>userProvider()
      ,child: myApp()));
}
class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<userProvider>(context);
    return MaterialApp(
      theme: myTheme.theme,
      title: 'Chat App',
      initialRoute:

      provider.firebase_user==null?
      LoginScreen.routename:HomeScreen.routename,
      routes: {
        RegisterScreen.routename : (context)=>RegisterScreen(),
        LoginScreen.routename:(context)=>LoginScreen(),
        HomeScreen.routename:(context)=>HomeScreen(),
        AddRoomView.routename:(context)=>AddRoomView(),
        ChatView.routename:(context)=>ChatView()
      },
    );
  }
}
