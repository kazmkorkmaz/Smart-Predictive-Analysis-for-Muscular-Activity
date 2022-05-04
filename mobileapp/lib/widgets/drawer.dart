import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mobileapp/commons/dialog.dart';
import 'package:mobileapp/screens/BlueSerial/MainPage.dart';
import 'package:mobileapp/screens/Profile/profile.dart';
import 'package:mobileapp/screens/home_page.dart';
import 'package:mobileapp/screens/Training/training_one.dart';
import 'package:mobileapp/screens/splash_screen.dart';
import 'package:mobileapp/services/auth_firebase.dart';

class MainDrawer extends StatelessWidget {
  AuthenticationService auth = AuthenticationService();
  MyDialog dialog = MyDialog();
  final BluetoothDevice? server;

  MainDrawer({this.server});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'MuscleNET',
                      style: TextStyle(
                          fontFamily: 'LuckiestGuy', fontSize: width * 0.1),
                    )
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
              if (server != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return TrainingOne(server: server as BluetoothDevice);
                    },
                  ),
                );
              } else {
                dialog.showErrorDialog(
                    'Please connect device before training!', context);
              }
            },
          ),
          ListTile(
            title: const Text('Bluetooth Settings'),
            leading: Icon(Icons.settings_bluetooth),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(MainPage.routeName);
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
