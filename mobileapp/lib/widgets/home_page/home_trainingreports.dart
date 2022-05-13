import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/services/functions_firebase.dart';
import 'package:mobileapp/services/ml_firebase.dart';
import 'package:mobileapp/services/training_firebase.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class HomeTrainingReports extends StatelessWidget {
  TrainingService trainingService = TrainingService();
  FirebaseModelDownloader downloader = FirebaseModelDownloader.instance;
  ML_Service ml_service = ML_Service();
  CloudFunctionsService cloudFunctionsService = CloudFunctionsService();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () async {
        // var input = [
        //   [
        //     2.5692,
        //     0.898484,
        //     1.13037,
        //     0.224186,
        //     2.78007,
        //     534.666,
        //     1217.8,
        //     106.04,
        //     0.682875,
        //     1.45055,
        //     0.305452,
        //     0.464135,
        //     1.91332,
        //     42.9938,
        //     1.0,
        //     12.5
        //   ]
        // ];

        // var label = await ml_service.predict(input);
        // print(label);

        // FirebaseModelDownloader.instance
        //     .getModel(
        //         "deneme",
        //         FirebaseModelDownloadType.localModel,
        //         FirebaseModelDownloadConditions(
        //           iosAllowsCellularAccess: true,
        //           iosAllowsBackgroundDownloading: false,
        //           androidChargingRequired: false,
        //           androidWifiRequired: false,
        //           androidDeviceIdleRequired: false,
        //         ))
        //     .then((customModel) {
        //   final localModelPath = customModel.file;

        //   final interpreter = Interpreter.fromFile(localModelPath);
        //   print(interpreter.getInputTensors());
        //   print(interpreter.getOutputTensors());

        //   interpreter.run(input, output);
        //   print(output);
        // });
        // final interpreter =
        //     await Interpreter.fromAsset('SyntheticMuscleDNN_1.tflite');
        // interpreter.allocateTensors();
        // print(interpreter.getInputTensors());
        // print(interpreter.getOutputTensors());

        // var input = [
        //   [
        //     1.28286,
        //     0.019973,
        //     0.00056914,
        //     0.0018633,
        //     1.28308,
        //     0.358558,
        //     809.484,
        //     1.17388,
        //     0.390476,
        //     1.11416,
        //     0.00239583,
        //     0.510301,
        //     0.962426,
        //     26.108,
        //     0.0,
        //     7.0
        //   ]
        // ];
        // var output = List.filled(1 * 3, 0).reshape([1, 3]);

        // interpreter.run(input, output);
        // print(output);
        // await trainingService
        //     .getDatas('25-4-2022', 'Biceps', 'asd', 'SetNumber-2')
        //     .then((value) {
        //   cloudFunctionsService.writeFeatures(value.get('datas').toList());
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
                  size: height * 0.2,
                ),
              ),
            ),
            SizedBox(height: height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: width * 0.05, height: height * 0.05),
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
            SizedBox(height: height * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.025),
                Text(
                  'See the training reports...',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}
