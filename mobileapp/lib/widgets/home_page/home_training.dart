import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mobileapp/commons/dialog.dart';
import 'package:mobileapp/screens/Training/training_one.dart';

class HomeTraining extends StatelessWidget {
  final BluetoothDevice? server;

  const HomeTraining({this.server});
  @override
  Widget build(BuildContext context) {
    MyDialog dialog = MyDialog();
    return InkWell(
      onTap: () {
        if (server != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return TrainingOne(server: server as BluetoothDevice);
              },
            ),
          );
        } else {
          dialog.showErrorDialog(
              'Please connect device before training!', context);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.orangeAccent, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        color: Colors.white,
        child: Column(
          children: [
            CircleAvatar(
              radius: 64,
              backgroundColor: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Icon(
                  Icons.fitness_center,
                  size: 125,
                ),
              ),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 15, height: 15),
                Text(
                  'Training',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Divider(
              color: Colors.orangeAccent,
              height: 10,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 15, height: 15),
                Text(
                  server == null
                      ? 'Please connect device before training'
                      : 'Device is connected! Lets start smart training...',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
