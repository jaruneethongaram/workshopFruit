import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/states/show_listvideo.dart';
import 'package:flutter/material.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  String nameLogin;
  Widget currentWidget = ShowListVideo();

  @override
  void initState() {
    //ทำงานก่อน Build
    // TODO: implement initState
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      //find DisplayName
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          nameLogin = event.displayName;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameLogin == null ? 'NAME LOGIN' : nameLogin),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app_rounded),
              onPressed: () async {
                await Firebase.initializeApp().then((value) async {
                  await FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/authen', (route) => false));
                });
              })
        ],
      ),
      drawer: Drawer(),
      body: currentWidget,
    );
  }
}
