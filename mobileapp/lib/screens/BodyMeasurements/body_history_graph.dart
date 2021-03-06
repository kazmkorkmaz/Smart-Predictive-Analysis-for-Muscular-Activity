import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/models/body_measurements.dart';
import 'package:mobileapp/services/user_firebase.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BodyGraph extends StatefulWidget {
  static const routeName = '/bodyGraph';

  @override
  State<BodyGraph> createState() => _BodyGraphState();
}

class _BodyGraphState extends State<BodyGraph> {
  @override
  Widget build(BuildContext context) {
    UserService userService = UserService();
    return Scaffold(
      appBar: AppBar(
        title: Text('History Chart'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: userService.getBodyHistory(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<BodyMeasurementsInfo> dataList = snapshot.data!.docs
                .map((documentSnapshot) => BodyMeasurementsInfo.fromMap(
                    documentSnapshot.data() as Map<String, dynamic>))
                .toList();

            return Column(children: [
              SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(text: 'Body Measurements History'),
                  legend:
                      Legend(isVisible: true, position: LegendPosition.bottom),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <LineSeries<BodyMeasurementsInfo, String>>[
                    LineSeries<BodyMeasurementsInfo, String>(
                        dataSource: dataList,
                        xValueMapper: (BodyMeasurementsInfo data, _) =>
                            '${data.createdAt!.day}-${data.createdAt!.month}-${data.createdAt!.year}',
                        yValueMapper: (BodyMeasurementsInfo data, _) =>
                            data.arm,
                        name: 'Arm',
                        markerSettings: const MarkerSettings(isVisible: true)),
                    LineSeries<BodyMeasurementsInfo, String>(
                        dataSource: dataList,
                        xValueMapper: (BodyMeasurementsInfo data, _) =>
                            '${data.createdAt!.day}-${data.createdAt!.month}-${data.createdAt!.year}',
                        yValueMapper: (BodyMeasurementsInfo data, _) =>
                            data.chest,
                        name: 'Chest',
                        markerSettings: const MarkerSettings(isVisible: true)),
                    LineSeries<BodyMeasurementsInfo, String>(
                        dataSource: dataList,
                        xValueMapper: (BodyMeasurementsInfo data, _) =>
                            '${data.createdAt!.day}-${data.createdAt!.month}-${data.createdAt!.year}',
                        yValueMapper: (BodyMeasurementsInfo data, _) =>
                            data.height,
                        name: 'height',
                        markerSettings: const MarkerSettings(isVisible: true)),
                    LineSeries<BodyMeasurementsInfo, String>(
                        dataSource: dataList,
                        xValueMapper: (BodyMeasurementsInfo data, _) =>
                            '${data.createdAt!.day}-${data.createdAt!.month}-${data.createdAt!.year}',
                        yValueMapper: (BodyMeasurementsInfo data, _) =>
                            data.hipst,
                        name: 'hipst',
                        markerSettings: const MarkerSettings(isVisible: true)),
                    LineSeries<BodyMeasurementsInfo, String>(
                        dataSource: dataList,
                        xValueMapper: (BodyMeasurementsInfo data, _) =>
                            '${data.createdAt!.day}-${data.createdAt!.month}-${data.createdAt!.year}',
                        yValueMapper: (BodyMeasurementsInfo data, _) =>
                            data.shoulder,
                        name: 'shoulder',
                        markerSettings: const MarkerSettings(isVisible: true)),
                    LineSeries<BodyMeasurementsInfo, String>(
                        dataSource: dataList,
                        xValueMapper: (BodyMeasurementsInfo data, _) =>
                            '${data.createdAt!.day}-${data.createdAt!.month}-${data.createdAt!.year}',
                        yValueMapper: (BodyMeasurementsInfo data, _) =>
                            data.thigh,
                        name: 'thigh',
                        markerSettings: const MarkerSettings(isVisible: true)),
                    LineSeries<BodyMeasurementsInfo, String>(
                        dataSource: dataList,
                        xValueMapper: (BodyMeasurementsInfo data, _) =>
                            '${data.createdAt!.day}-${data.createdAt!.month}-${data.createdAt!.year}',
                        yValueMapper: (BodyMeasurementsInfo data, _) =>
                            data.waist,
                        name: 'waist',
                        markerSettings: const MarkerSettings(isVisible: true)),
                    LineSeries<BodyMeasurementsInfo, String>(
                        dataSource: dataList,
                        xValueMapper: (BodyMeasurementsInfo data, _) =>
                            '${data.createdAt!.day}-${data.createdAt!.month}-${data.createdAt!.year}',
                        yValueMapper: (BodyMeasurementsInfo data, _) =>
                            data.weight,
                        name: 'weight',
                        markerSettings: const MarkerSettings(isVisible: true)),
                  ]),
            ]);
          }

          return Text("loading");
        },
      ),
    );
  }
}
