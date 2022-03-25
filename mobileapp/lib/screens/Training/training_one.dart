import 'package:flutter/material.dart';
import 'package:mobileapp/widgets/muscle_cart.dart';

class Muscle {
  final String name;
  final String image;
  Muscle({required this.name, required this.image});
}

class TrainingOne extends StatelessWidget {
  static const routeName = '/TrainingOne';

  List muscles = [
    Muscle(name: 'Biceps', image: 'lib/assets/images/arm.png'),
    Muscle(name: 'Back', image: 'lib/assets/images/back.png'),
    Muscle(name: 'Chest', image: 'lib/assets/images/chest.png'),
    Muscle(name: 'Leg', image: 'lib/assets/images/leg.png'),
    Muscle(name: 'Shoulder', image: 'lib/assets/images/shoulder.png'),
    Muscle(name: 'Triceps', image: 'lib/assets/images/triceps.png'),
  ];

  @override
  Widget build(BuildContext context) {
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
                    child: MuscleCart(muscle: muscles[index]),
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
