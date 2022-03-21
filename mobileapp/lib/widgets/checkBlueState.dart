import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:mobileapp/screens/Blue/FindDevicesScreen.dart';
import 'package:mobileapp/screens/Blue/bluetoothOff.dart';

class CheckBlueState extends StatelessWidget {
  static const routeName = '/CheckBlueState';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return FindDevicesScreen();
            }
            return BluetoothOffScreen(state: state);
          }),
    );
  }
}
