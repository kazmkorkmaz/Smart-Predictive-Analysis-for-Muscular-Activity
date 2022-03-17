import 'package:flutter/material.dart';
import 'package:mobileapp/widgets/bottom.dart';
import '../widgets/drawer.dart';
import '../widgets/floating_action.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/HomePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        child: Center(
          child: Text('Home Page1'),
        ),
      ),
      bottomNavigationBar: BottomWidget(),
      floatingActionButton: FloatingAction(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      drawer: MainDrawer(),
    );
  }
}
