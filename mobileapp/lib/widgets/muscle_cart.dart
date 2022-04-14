import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mobileapp/screens/Training/training_one.dart';
import 'package:mobileapp/screens/Training/training_two.dart';

class MuscleCart extends StatelessWidget {
  final BluetoothDevice server;
  const MuscleCart({Key? key, required this.muscle, required this.server})
      : super(key: key);
  final Muscle muscle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          TrainingInfo.routeName,
          arguments: Muscle(
            name: muscle.name,
            image: muscle.image,
            server: server,
          ),
        );
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 4,
          color: Colors.white,
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        muscle.image,
                      ),
                    ),
                  ),
                  Text(muscle.name),
                ]),
          )),
    );
  }
}
