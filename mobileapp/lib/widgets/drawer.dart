import 'package:flutter/material.dart';
import 'package:mobileapp/screens/Auth/login.dart';
import 'package:mobileapp/screens/Profile/profile.dart';
import 'package:mobileapp/screens/home_page.dart';
import 'package:mobileapp/screens/Training/training_one.dart';
import 'package:mobileapp/screens/splash_screen.dart';
import 'package:mobileapp/services/auth_firebase.dart';

class MainDrawer extends StatelessWidget {
  AuthenticationService auth = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
              ),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(48),
                          child: Image.asset(
                              'lib/assets/images/bee-strong-avatar.png')),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Bee Strong!'),
                      ],
                    ),
                  ],
                ),
              )),
          ListTile(
            title: const Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomePage.routeName, (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: const Text('Profile'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(ProfilePage.routeName);
            },
          ),
          ListTile(
            title: const Text('Training'),
            leading: Icon(Icons.fitness_center),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(TrainingOne.routeName);
            },
          ),
          ListTile(
            title: const Text('Settings'),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Sign Out'),
            leading: Icon(Icons.logout),
            onTap: () {
              auth.signOut();
              Navigator.of(context)
                  .pushReplacementNamed(SplashScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
