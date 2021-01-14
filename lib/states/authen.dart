import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/utility/dialog.dart';
import 'package:firstapp/utility/my_style.dart';
import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  bool statusRedEye = true;
  String user, password;

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildTextButton(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, MyStyle().lightcolor],
            begin: Alignment(0, 0),
            end: Alignment(0, 1),
          ),
          // gradient: RadialGradient(radius: 1.0,
          //   colors: [Colors.white, MyStyle().darkColor],
          // ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildLogo(),
              buildAppName(),
              buildUser(),
              buildPassword(),
              buildLogin(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      //Container(width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ? Please Fill All Blank');
          } else {
            checkAuthen();
          }
        },
        child: Text('LOGIN'),
      ),
    );
  }

  TextButton buildTextButton() => TextButton(
        onPressed: () => Navigator.pushNamed(context, '/register'),
        child: Text("NEW REGISTER"),
      );

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: MyStyle().darkColor),
        decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().darkColor),
            prefixIcon: Icon(
              Icons.perm_identity,
              color: MyStyle().darkColor,
            ),
            labelText: 'User',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().darkColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().primaryColor),
            )),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: statusRedEye,
        style: TextStyle(color: MyStyle().darkColor),
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  statusRedEye = !statusRedEye; //ทำงานสัมพันธ์กับปุ่ม redeye
                });
                print('statusRedEye=$statusRedEye');
              },
            ),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            prefixIcon: Icon(
              Icons.lock,
              color: MyStyle().darkColor,
            ),
            //labelText: 'Password',
            hintText: 'Password',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().darkColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().primaryColor),
            )),
      ),
    );
  }

  Text buildAppName() => Text(
        'FLUTTER LEARNING',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          // fontStyle: FontStyle.italic, (กด ctrl+/)
          color: MyStyle().darkColor,
        ),
      );

  Container buildLogo() {
    return Container(
      width: 150.0,
      child: Image.asset('images/logo2.png'),
    );
  }

  Future<Null> checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: password)
          .then((value) => Navigator.pushNamedAndRemoveUntil(context, '/myService', (route) => false))
          .catchError((value) {
        normalDialog(context, value.message);
      });
    });
  }
}
