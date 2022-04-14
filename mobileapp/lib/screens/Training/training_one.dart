import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mobileapp/widgets/muscle_cart.dart';

class Muscle {
  final String name;
  final String image;
  final BluetoothDevice server;
  Muscle({
    required this.name,
    required this.image,
    required this.server,
  });
}

class TrainingOne extends StatefulWidget {
  static const routeName = '/TrainingOne';
  final BluetoothDevice server;

  const TrainingOne({required this.server});

  @override
  State<TrainingOne> createState() => _TrainingOneState();
}

class _TrainingOneState extends State<TrainingOne> {
  @override
  Widget build(BuildContext context) {
    List muscles = [
      Muscle(
        name: 'Biceps',
        image: 'lib/assets/images/arm.png',
        server: widget.server,
      ),
      Muscle(
        name: 'Back',
        image: 'lib/assets/images/back.png',
        server: widget.server,
      ),
      Muscle(
        name: 'Chest',
        image: 'lib/assets/images/chest.png',
        server: widget.server,
      ),
      Muscle(
        name: 'Leg',
        image: 'lib/assets/images/leg.png',
        server: widget.server,
      ),
      Muscle(
        name: 'Shoulder',
        image: 'lib/assets/images/shoulder.png',
        server: widget.server,
      ),
      Muscle(
        name: 'Triceps',
        image: 'lib/assets/images/triceps.png',
        server: widget.server,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Training Time'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Select your muscle for the training',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                muscles.length,
                (index) {
                  return Center(
                    child: MuscleCart(
                      muscle: muscles[index],
                      server: widget.server,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
