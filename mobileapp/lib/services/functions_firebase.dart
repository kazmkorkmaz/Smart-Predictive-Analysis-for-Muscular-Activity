import 'package:cloud_functions/cloud_functions.dart';

class CloudFunctionsService {
  Future writeFeatures(List data) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('writeFeatures');
    final resp = await callable.call(<String, List>{
      'list': data.toList(),
    });
    print(resp.data);
    return resp.data;
  }
}
