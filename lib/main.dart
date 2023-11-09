import 'package:chatapp/AddRoom/AddRoom_View.dart';
import 'package:chatapp/Chat/Chat_View.dart';
import 'package:chatapp/Home/Home_View.dart';
import 'package:chatapp/ImageV/ImageView.dart';
import 'package:chatapp/Login/Login_View.dart';
import 'package:chatapp/Providers/Image_Provider.dart';
import 'package:chatapp/Providers/User_Provider.dart';
import 'package:chatapp/Register/Register_View.dart';
import 'package:chatapp/Theme/myTheme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
FirebaseMessaging messaging = FirebaseMessaging.instance;
void printtoken()async{
  String? token = await messaging.getToken();
  print("Token ${token}");
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  printtoken();
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(
      create: (context)=>userProvider(),),
      ChangeNotifierProvider(create: (context)=>ImageProv())
  ],
  child: myApp()),
  );
}
class myApp extends StatefulWidget {
  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    var provider=Provider.of<userProvider>(context);
    return WillPopScope(
      onWillPop: ()async=>false,

      child: MaterialApp(
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
          ChatView.routename:(context)=>ChatView(),
          ImageView.routename:(context)=>ImageView(),
        },
      ),
    );
  }
}
