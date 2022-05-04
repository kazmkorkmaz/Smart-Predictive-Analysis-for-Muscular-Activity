import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/screens/Profile/user_info.dart';
import 'package:mobileapp/screens/home_page.dart';

import 'package:mobileapp/screens/Auth/login.dart';
import 'package:mobileapp/services/user_firebase.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserService userService = UserService();
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = new Timer(Duration(seconds: 3), () {
      FirebaseAuth _auth = FirebaseAuth.instance;
      if (_auth.currentUser == null) {
        Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      }
    });
  }

  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/images/bee-strong-avatar.png',
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.8,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
