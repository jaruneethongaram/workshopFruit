import 'package:firstapp/states/authen.dart';
import 'package:firstapp/states/my_service.dart';
import 'package:firstapp/states/player_video.dart';
import 'package:firstapp/states/register.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/authen': (BuildContext context) => Authen(),
  '/register': (BuildContext context) => Register(),
  '/myService': (BuildContext context) => MyService(),
  '/playervideo': (BuildContext context) {return PlayerVideo();},
};
