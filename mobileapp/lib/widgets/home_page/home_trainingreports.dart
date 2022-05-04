import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/services/training_firebase.dart';

class HomeTrainingReports extends StatelessWidget {
  TrainingService trainingService = TrainingService();
  FirebaseModelDownloader downloader = FirebaseModelDownloader.instance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // FirebaseModelDownloader.instance
        // .getModel(
        //     "deneme",
        //     FirebaseModelDownloadType.localModel,
        //     FirebaseModelDownloadConditions(
        //       iosAllowsCellularAccess: true,
        //       iosAllowsBackgroundDownloading: false,
        //       androidChargingRequired: false,
        //       androidWifiRequired: false,
        //       androidDeviceIdleRequired: false,
        //     )
        // ).then((value){
        //   print(value.file.uri);
        // } );
        // final interpreter = await Interpreter.fromAsset('model.tflite');

        // var input = [
        //   [
        //     1.55735,
        //     0.311792,
        //     0.147286,
        //     0.158908,
        //     1.60384,
        //     68.7825,
        //     728.84,
        //     74.21,
        //     0.616702,
        //     1.19717,
        //     0.207741,
        //     0.0213675,
        //     1.17942,
        //     28.3669,
        //     0,
        //     1
        //   ]
        // ];
        // var output = [];
        // interpreter.run(input, output);
        // print(output);
        // await trainingService
        //     .getDatas('25-4-2022', 'Biceps', 'asd', 'SetNumber-2')
        //     .then((value) {
        //   trainingService.writeFeatures(value.get('datas').toList());
        // }).onError((error, stackTrace) {
        //   print(error);
        // });
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
                  FontAwesomeIcons.noteSticky,
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
                  'Training Reports',
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
                  'See the training reports...',
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

class Documentsnapshot {}
