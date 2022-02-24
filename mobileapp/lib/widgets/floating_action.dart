import 'package:flutter/material.dart';

class FloatingAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      child: new FloatingActionButton(
        onPressed: () {},
        child: new Icon(
          Icons.bluetooth,
          size: 40,
        ),
      ),
    );
  }
}
