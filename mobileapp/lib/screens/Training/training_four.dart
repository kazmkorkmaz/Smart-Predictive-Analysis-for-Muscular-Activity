import 'package:flutter/material.dart';
import 'package:mobileapp/screens/Training/training_three.dart';

class TraningFinish extends StatefulWidget {
  static const routeName = '/TrainingFinish';

  @override
  State<TraningFinish> createState() => _TraningFinishState();
}

class _TraningFinishState extends State<TraningFinish> {
  String message = "Slider Scale";
  double _value = 0.0;

  void onChanged(double value) {
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('How hard did you push yourself?'),
              ],
            ),
            Text('Slider value is ${_value.toStringAsFixed(0)}'),
            Slider(
                inactiveColor: Colors.red,
                max: 10.0,
                min: 0.0,
                value: _value,
                onChanged: (double value) {
                  onChanged(value);
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(TrainingThree.routeName);
                    },
                    child: Text(
                      'Pass',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(TraningFinish.routeName);
                    },
                    child: Text(
                      'Ok',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
