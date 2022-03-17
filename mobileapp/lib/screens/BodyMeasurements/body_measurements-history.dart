import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
            return Column(
              children: [
                Column(
                  children: [
                    CircularProgressIndicator(),
                    Text('Loading...'),
                  ],
                ),
              ],
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Body Measurements',
                          ),
                          Divider(
                            color: Color.fromARGB(255, 131, 25, 25),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.height,
                                size: 35,
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Height:'),
                                  Text(item['height'].toString()),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.boy_rounded,
                                size: 35,
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Weight:'),
                                  Text(item['weight'].toString()),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.straight,
                                size: 35,
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Arm:'),
                                  Text(item['arm'].toString()),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.boy_rounded,
                                size: 35,
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Chest:'),
                                  Text(item['chest'].toString()),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.boy_rounded,
                                size: 35,
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Shoulder:'),
                                  Text(item['shoulder'].toString()),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.boy_rounded,
                                size: 35,
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Waist:'),
                                  Text(item['waist'].toString()),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.boy_rounded,
                                size: 35,
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Hipst:'),
                                  Text(item['hipst'].toString()),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.boy_rounded,
                                size: 35,
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Thigh:'),
                                  Text(item['thigh'].toString()),
                                ],
                              )
                            ],
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
