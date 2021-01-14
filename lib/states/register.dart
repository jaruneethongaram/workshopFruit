import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/utility/dialog.dart';
import 'package:firstapp/utility/my_style.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name, user, password;

  @override
  bool statusRedEye = true;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BACK'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildAppName(),
              buildName(),
              buildUser(),
              buildPassword(),
              buildRegister(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildRegister() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      //Container(width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          print('name=$name,user=$user,password=$password');
          if ((name == null || name.isEmpty) ||
              (user?.isEmpty ?? true) ||
              (password?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ? Please Fill Every Blank');
          } else {
            registerThread();
          }
        },
        child: Text('REGISTER'),
      ),
    );
  }

  Text buildAppName() => Text(
        'REGISTER FORM',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          // fontStyle: FontStyle.italic, (กด ctrl+/)
          color: MyStyle().darkColor,
        ),
      );

  Container buildName() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        style: TextStyle(color: MyStyle().darkColor),
        decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().darkColor),
            prefixIcon: Icon(
              Icons.perm_identity,
              color: MyStyle().darkColor,
            ),
            labelText: 'Name',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().darkColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().primaryColor),
            )),
      ),
    );
  }

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
              Icons.email_outlined,
              color: MyStyle().darkColor,
            ),
            hintText: 'Email',
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
            labelText: 'Password',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().darkColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().primaryColor),
            )),
      ),
    );
  }

  Future<Null> registerThread() async {
    await Firebase.initializeApp().then((value) async {
      print('###### Initialize Success ######');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user, password: password)
          .then((value) async {
        print('Register Success');
        await value.user
            .updateProfile(displayName: name)
            .then((value) => Navigator.pop(context));
      }).catchError((value) {
        normalDialog(context, value.message); //value.code ก็ได้
      });
    });
  }
}
