import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/screens/home_page.dart';
import 'package:mobileapp/screens/login.dart';
import 'package:mobileapp/screens/user_info.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              child: Image.asset(
                'lib/assets/images/splash.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
