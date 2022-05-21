import 'dart:io';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class ML_Service {
  FirebaseModelDownloader downloader = FirebaseModelDownloader.instance;

  Future<File> loadModel(String modelName) async {
    try {
      final model = FirebaseModelDownloader.instance.getModel(
          modelName,
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

  Future<int> predictInjuryRisk(var input) async {
    final modelFile = await loadModel("deneme4");
    final interpreter = Interpreter.fromFile(modelFile);
    var output = List.filled(1 * 2, 0).reshape([1, 2]);

    interpreter.run(input, output);
    double max = 0;
    int index = 0;
    for (var i = 0; i < output[0].length; i++) {
      if (output[0][i] >= max) {
        max = output[0][i];
        index = i;
      }
    }

    return index;
  }

  Future predictImprovement(var input) async {
    final modelFile = await loadModel("deneme3");
    final interpreter = Interpreter.fromFile(modelFile);
    var output = List.filled(1 * 3, 0).reshape([1, 3]);

    interpreter.run(input, output);
    double max = 0;
    int index = 0;
    for (var i = 0; i < output[0].length; i++) {
      if (output[0][i] >= max) {
        max = output[0][i];
        index = i;
      }
    }
    return index;
  }

  Future predictLastFive(var input) async {
    final modelFile = await loadModel("deneme5");
    final interpreter = Interpreter.fromFile(modelFile);
    var inputFinal = List.filled(1, input).reshape([1, 5, 16]);
    var output = List.filled(1 * 2, 0).reshape([1, 2]);
    interpreter.run(inputFinal, output);

    double max = 0;
    int index = 0;
    for (var i = 0; i < output[0].length; i++) {
      if (output[0][i] >= max) {
        max = output[0][i];
        index = i;
      }
    }

    return index;
  }
}
