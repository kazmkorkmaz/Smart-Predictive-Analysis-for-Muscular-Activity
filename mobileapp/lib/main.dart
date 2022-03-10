import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/screens/home_page.dart';
import 'package:mobileapp/screens/login.dart';
import 'package:mobileapp/screens/register.dart';
import 'package:mobileapp/screens/reset_password.dart';
import 'package:mobileapp/screens/splash_screen.dart';
import 'package:mobileapp/screens/user_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.orange,
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        HomePage.routeName: (ctx) => HomePage(),
        SignInScreen.routeName: (ctx) => SignInScreen(),
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
        ResetPassword.routeName: (ctx) => ResetPassword(),
        UserInfoScreen.routeName: (ctx) => UserInfoScreen(),
        SplashScreen.routeName: (ctx) => SplashScreen(),
      },
    );
  }
}
