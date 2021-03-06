import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whakaaro/view/HomePage.dart';
import 'package:whakaaro/view/sign_in.dart';
import 'package:whakaaro/view/splash_screen.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'whakaaro',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    initialRoute: '/splash',
    routes: <String, WidgetBuilder>{
      '/splash': (BuildContext ctx) => SplashScreen(),
      '/SignIn': (BuildContext ctx) => SignIn(),
      '/HomePage': (BuildContext ctx) => HomePage(),
    }
    );
  }
}