import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/screens/BodyMeasurements/body_measurements-history.dart';
import 'package:mobileapp/screens/BodyMeasurements/body_measurements.dart';
import 'package:mobileapp/screens/home_page.dart';
import 'package:mobileapp/screens/Auth/login.dart';
import 'package:mobileapp/screens/Profile/profile.dart';
import 'package:mobileapp/screens/Auth/register.dart';
import 'package:mobileapp/screens/Auth/reset_password.dart';
import 'package:mobileapp/screens/splash_screen.dart';
import 'package:mobileapp/screens/BodyMeasurements/update_body_measurements.dart';
import 'package:mobileapp/screens/Profile/user_info.dart';

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
        primarySwatch: Colors.orange,
      ),
      home: SplashScreen(),
      routes: {
        HomePage.routeName: (ctx) => HomePage(),
        SignInScreen.routeName: (ctx) => SignInScreen(),
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
        ResetPassword.routeName: (ctx) => ResetPassword(),
        UserInfoScreen.routeName: (ctx) => UserInfoScreen(),
        SplashScreen.routeName: (ctx) => SplashScreen(),
        ProfilePage.routeName: (ctx) => ProfilePage(),
        BodyMeasurements.routeName: (ctx) => BodyMeasurements(),
        UpdateBodyMeasurements.routeName: (ctx) => UpdateBodyMeasurements(),
        BodyMeasurementsHistory.routeName: (ctx) => BodyMeasurementsHistory(),
      },
    );
  }
}
