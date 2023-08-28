import 'package:chatapp/AddRoom/AddRoom_View.dart';
import 'package:chatapp/Database/Database_Utils.dart';
import 'package:chatapp/Home/HomeConnect.dart';
import 'package:chatapp/Home/Home_ViewModel.dart';
import 'package:chatapp/Home/RoomWidget.dart';
import 'package:chatapp/Models/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routename = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeConnect {
  HomeVm vm = HomeVm();
  @override
  void initState() {
    super.initState();
    vm.reg = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => vm,
      child: Stack(
        children: [
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
                'Home',
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddRoomView.routename);
              },
              backgroundColor: Colors.blue,
              child: Icon(Icons.add),
            ),
            body: StreamBuilder<QuerySnapshot<Room>>(
              stream: Database_utils.getrooms(),
              builder: (context, asyncsnapshot) {
                if (asyncsnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (asyncsnapshot.hasError) {
                  return Text(asyncsnapshot.error.toString());
                } else if (asyncsnapshot.hasData) {
                  var roomslist = asyncsnapshot.data?.docs
                      .map((item) => item.data())
                      .toList();
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 18,
                          crossAxisSpacing: 18),
                      itemCount: roomslist?.length ?? 0,
                      itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.all(12),
                          child: RoomWidget(room: roomslist![index])));
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}
