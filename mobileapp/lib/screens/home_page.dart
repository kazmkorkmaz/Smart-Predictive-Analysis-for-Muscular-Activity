import 'package:flutter/material.dart';
import 'package:mobileapp/widgets/drawer.dart';
import 'package:mobileapp/widgets/floating_action.dart';
import 'package:mobileapp/widgets/home_page/home_bodyMeasurements.dart';
import 'package:mobileapp/widgets/home_page/home_training.dart';
import 'package:mobileapp/widgets/home_page/home_trainingreports.dart';
import 'package:mobileapp/widgets/home_page/home_welcome.dart';
import 'package:mobileapp/widgets/home_page/home_profil.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/HomePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeWelcome(),
            HomeTraining(),
            HomeTrainingReports(),
            HomeProfilCart(),
            HomeBody(),
          ],
        ),
      ),
      floatingActionButton: FloatingAction(),
      drawer: MainDrawer(),
    );
  }
}
