import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  bool isLoggedIn;
  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('boolValue');
    print('Is Login : ${isLoggedIn.toString()}');
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(),
                ),
                Lottie.asset('assets/animations/splash.json'),
                Expanded(
                  flex: 6,
                  child: Container(),
                ),
              ],
            )
          ],
        ));
  }

  checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('boolValue');
    isLoggedIn == false || isLoggedIn == null
        ? navigationPage('/SignIn')
        : navigationPage('/HomePage');

  }

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, () async {
      await checkLoggedIn();
    });
  }

  void navigationPage(String destination) {
    Navigator.of(context).pushReplacementNamed(destination);
  }
}
