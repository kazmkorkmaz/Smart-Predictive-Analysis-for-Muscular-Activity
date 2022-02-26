import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/screens/home_page.dart';
import 'package:mobileapp/screens/login.dart';
import 'package:mobileapp/screens/register.dart';
import 'package:mobileapp/screens/reset_password.dart';

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
      home: SignInScreen(),
      routes: {
        HomePage.routeName: (ctx) => HomePage(),
        SignInScreen.routeName: (ctx) => SignInScreen(),
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
        ResetPassword.routeName: (ctx) => ResetPassword(),
      },
    );
  }
}
