import 'package:flutter/material.dart';
import 'package:mobileapp/screens/Profile/profile.dart';

class BottomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        if (value == 1) {
          Navigator.of(context).pushNamed(ProfilePage.routeName);
        }
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
