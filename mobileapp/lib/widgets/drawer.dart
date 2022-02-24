import 'package:flutter/material.dart';
import 'package:mobileapp/screens/login.dart';
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
              color: Colors.blue,
            ),
            child: Text('App Name'),
          ),
          ListTile(
            title: const Text('Profile'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.pop(context);
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
                  .pushReplacementNamed(SignInScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
