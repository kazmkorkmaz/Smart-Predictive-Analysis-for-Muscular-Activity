import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/screens/BodyMeasurements/body_history_graph.dart';
import 'package:mobileapp/screens/BodyMeasurements/body_measurements-history.dart';
import 'package:mobileapp/services/user_firebase.dart';

class BodyMeasurementsWidget extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserService userService = UserService();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder<QuerySnapshot>(
        future: userService.getBodydata(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          final dataList = snapshot.data!.docs.toList();
          return Card(
            shape: RoundedRectangleBorder(
                side: new BorderSide(color: Colors.orange, width: 1.0),
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Body Measurements",
                      textScaleFactor: 1.4,
                      style: TextStyle(fontFamily: 'IndieFlower'),
                    ),
                  ],
                ),
                Divider(
                  height: 5,
                  thickness: 1,
                  indent: 5,
                  endIndent: 0,
                  color: Colors.orange,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: width * 0.02),
                    Icon(
                      Icons.height,
                      size: 35,
                    ),
                    SizedBox(width: width * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Height:',
                          textScaleFactor: 1.2,
                        ),
                        Text(
                          dataList[0]['height'].toString(),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: width * 0.02),
                    FaIcon(
                      FontAwesomeIcons.weightScale,
                      size: 35,
                    ),
                    SizedBox(width: width * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weight:',
                          textScaleFactor: 1.2,
                        ),
                        Text(
                          dataList[0]['weight'].toString(),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: width * 0.02),
                    FaIcon(
                      FontAwesomeIcons.dumbbell,
                      size: 30,
                    ),
                    SizedBox(width: width * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Arm:',
                          textScaleFactor: 1.2,
                        ),
                        Text(
                          dataList[0]['arm'].toString(),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: width * 0.02),
                    FaIcon(
                      FontAwesomeIcons.dumbbell,
                      size: 30,
                    ),
                    SizedBox(width: width * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chest:',
                          textScaleFactor: 1.2,
                        ),
                        Text(
                          dataList[0]['chest'].toString(),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: width * 0.02),
                    FaIcon(
                      FontAwesomeIcons.dumbbell,
                      size: 30,
                    ),
                    SizedBox(width: width * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shoulder:',
                          textScaleFactor: 1.2,
                        ),
                        Text(
                          dataList[0]['shoulder'].toString(),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: width * 0.02),
                    FaIcon(
                      FontAwesomeIcons.dumbbell,
                      size: 30,
                    ),
                    SizedBox(width: width * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Waist:',
                          textScaleFactor: 1.2,
                        ),
                        Text(
                          dataList[0]['waist'].toString(),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: width * 0.02),
                    FaIcon(
                      FontAwesomeIcons.dumbbell,
                      size: 30,
                    ),
                    SizedBox(width: width * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hipst:',
                          textScaleFactor: 1.2,
                        ),
                        Text(
                          dataList[0]['hipst'].toString(),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: width * 0.02),
                    FaIcon(
                      FontAwesomeIcons.dumbbell,
                      size: 30,
                    ),
                    SizedBox(width: width * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Thigh:'),
                        Text(
                          dataList[0]['thigh'].toString(),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                        width * 0.3,
                        height * 0.06,
                      )),
                      onPressed: () {
                        Navigator.of(context).pushNamed(BodyGraph.routeName);
                      },
                      child: Text(
                        'See on the graph',
                        style: TextStyle(
                            color: Colors.white, fontSize: width * 0.04),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                        width * 0.3,
                        height * 0.06,
                      )),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(BodyMeasurementsHistory.routeName);
                      },
                      child: Text(
                        'See all history',
                        style: TextStyle(
                            color: Colors.white, fontSize: width * 0.04),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.015,
                ),
              ],
            ),
          );
        });
  }
}
