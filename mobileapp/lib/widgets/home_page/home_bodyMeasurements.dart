import 'package:flutter/material.dart';
import 'package:mobileapp/screens/BodyMeasurements/body_history_graph.dart';
import 'package:mobileapp/screens/BodyMeasurements/body_measurements-history.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(BodyGraph.routeName);
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
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Icon(
                      Icons.auto_graph,
                      size: 80,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '  Graph of body measurements  ',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(BodyMeasurementsHistory.routeName);
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
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Icon(
                      Icons.history,
                      size: 80,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '  History of body measurements  ',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
