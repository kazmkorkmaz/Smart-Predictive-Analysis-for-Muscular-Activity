import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mobileapp/widgets/drawer.dart';
import 'package:mobileapp/widgets/floating_action.dart';
import 'package:mobileapp/widgets/home_page/home_training.dart';
import 'package:mobileapp/widgets/home_page/home_trainingHistory.dart';
import 'package:mobileapp/widgets/home_page/home_trainingreports.dart';
import 'package:mobileapp/widgets/home_page/home_welcome.dart';
import 'package:mobileapp/widgets/home_page/home_profil.dart';

class HomePage extends StatelessWidget {
  final BluetoothDevice? server;

  const HomePage({this.server});
  static const routeName = '/HomePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MuscleNET Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeWelcome(),
            HomeTraining(
              server: server,
            ),
            HomeTrainingHistory(),
            HomeTrainingReports(),
            HomeProfilCart(),
          ],
        ),
      ),
      floatingActionButton: FloatingAction(),
      drawer: MainDrawer(
        server: server,
      ),
    );
  }
}
