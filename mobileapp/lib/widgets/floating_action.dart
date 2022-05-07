import 'package:flutter/material.dart';
import 'package:mobileapp/screens/BlueSerial/SettingsPage.dart';

class FloatingAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      child: new FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(MainPage.routeName);
        },
        child: new Icon(
          Icons.bluetooth,
          size: 40,
        ),
      ),
    );
  }
}
