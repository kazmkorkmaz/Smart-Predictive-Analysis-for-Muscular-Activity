import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/services/user_firebase.dart';

class BodyMeasurements extends StatelessWidget {
  static const routeName = '/BodyMeasurements';
  UserService userService = UserService();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController arm = TextEditingController();
  TextEditingController chest = TextEditingController();
  TextEditingController shoulder = TextEditingController();
  TextEditingController waist = TextEditingController();
  TextEditingController hipst = TextEditingController();
  TextEditingController thigh = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Body Measurements'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please enter your body measurements',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'before starting',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: height,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Height(cm)',
                      prefixIcon: Icon(Icons.height),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: weight,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Weight(kg)',
                      prefixIcon: Icon(FontAwesomeIcons.weight),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: arm,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Arm(cm)',
                      prefixIcon: Icon(FontAwesomeIcons.dumbbell),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: chest,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Chest(cm)',
                      prefixIcon: Icon(FontAwesomeIcons.dumbbell),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: shoulder,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Shoulder(cm)',
                      prefixIcon: Icon(FontAwesomeIcons.dumbbell),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: waist,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Waist(cm)',
                      prefixIcon: Icon(FontAwesomeIcons.dumbbell),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: hipst,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Hipst(cm)',
                      prefixIcon: Icon(FontAwesomeIcons.dumbbell),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: thigh,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Thigh(cm)',
                      prefixIcon: Icon(FontAwesomeIcons.dumbbell),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    userService.updateBody(
                      double.parse(height.text),
                      double.parse(weight.text),
                      double.parse(arm.text),
                      double.parse(chest.text),
                      double.parse(shoulder.text),
                      double.parse(waist.text),
                      double.parse(hipst.text),
                      double.parse(thigh.text),
                      context,
                    );
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
