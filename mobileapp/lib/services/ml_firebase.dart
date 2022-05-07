import 'dart:io';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class ML_Service {
  FirebaseModelDownloader downloader = FirebaseModelDownloader.instance;

  Future<File> loadModel() async {
    try {
      final model = FirebaseModelDownloader.instance.getModel(
          "deneme2",
          FirebaseModelDownloadType.localModel,
          FirebaseModelDownloadConditions(
            iosAllowsCellularAccess: true,
            iosAllowsBackgroundDownloading: false,
            androidChargingRequired: false,
            androidWifiRequired: false,
            androidDeviceIdleRequired: false,
          ));

      var modelFile = await model.then((value) => value.file);
      return modelFile;
    } catch (exception) {
      rethrow;
    }
  }

  Future predict(var input) async {
    final modelFile = await loadModel();
    final interpreter = Interpreter.fromFile(modelFile);
    var output = List.filled(1 * 3, 0).reshape([1, 3]);

    interpreter.run(input, output);
    double max = 0;
    int index = 0;
    for (var i = 0; i < output[0].length; i++) {
      print(output[0][i]);
      if (output[0][i] >= max) {
        max = output[0][i];
        index = i;
      }
    }
    return index;
  }
}
