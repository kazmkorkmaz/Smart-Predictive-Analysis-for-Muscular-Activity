import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/commons/dialog.dart';
import 'package:mobileapp/services/user_firebase.dart';

class BodyMeasurementsHistory extends StatefulWidget {
  static const routeName = '/BodyMeasurementsHistory';

  @override
  State<BodyMeasurementsHistory> createState() =>
      _BodyMeasurementsHistoryState();
}

class _BodyMeasurementsHistoryState extends State<BodyMeasurementsHistory> {
  UserService userService = UserService();
  MyDialog dialog = MyDialog();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Body Measurements History'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: userService.getBodyHistory(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error occured! Please try later...'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('Loading...'),
                ],
              ),
            );
          }
          final dataList = snapshot.data!.docs.toList();
          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final item = dataList[index];

              return ExpansionPanelList.radio(
                animationDuration: Duration(milliseconds: 750),
                children: [
                  ExpansionPanelRadio(
                    value: item.id,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Text(
                          item.id,
                        ),
                      );
                    },
                    body: Card(
                      shape: RoundedRectangleBorder(
                          side:
                              new BorderSide(color: Colors.orange, width: 1.0),
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
                                size: 30,
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
                                    item['height'].toString(),
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
                                size: 30,
                              ),
                              SizedBox(width: width * 0.05),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Weight:'),
                                  Text(
                                    item['weight'].toString(),
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
                                    item['arm'].toString(),
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
                                    item['chest'].toString(),
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
                                    item['shoulder'].toString(),
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
                                    item['waist'].toString(),
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
                                    item['hipst'].toString(),
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
                                    'Thigh:',
                                    textScaleFactor: 1.2,
                                  ),
                                  Text(
                                    item['thigh'].toString(),
                                    textScaleFactor: 1.2,
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                        ],
                      ),
                    ),
                    canTapOnHeader: true,
                  ),
                ],
                dividerColor: Color.fromARGB(255, 211, 11, 11),
              );
            },
          );
        },
      ),
    );
  }
}
