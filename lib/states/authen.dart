import 'package:firstapp/utility/my_style.dart';
import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  bool statusRedEye = true;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildLogo(),
            buildAppName(),
            buildUser(),
            buildPassword(),
            Container(margin: EdgeInsets.only(top: 16),
              width: 250,
              //Container(width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
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
              borderSide: BorderSide(color: MyStyle().lightcolor),
            )),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
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

  Text buildAppName() => Text(
        'Flutter Learning',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          // fontStyle: FontStyle.italic, (กด ctrl+/)
          color: MyStyle().darkColor,
        ),
      );

  Container buildLogo() {
    return Container(
      width: 120.0,
      child: Image.asset('images/logo1.png'),
    );
  }
}
