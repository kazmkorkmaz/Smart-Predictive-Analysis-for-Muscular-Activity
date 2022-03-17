import 'package:flutter/material.dart';
import 'package:mobileapp/services/user_firebase.dart';

class UpdateBodyMeasurements extends StatefulWidget {
  static const routeName = '/UpdateBodyMeasurements';

  @override
  State<UpdateBodyMeasurements> createState() => _UpdateBodyMeasurementsState();
}

class _UpdateBodyMeasurementsState extends State<UpdateBodyMeasurements> {
  UserService userService = UserService();

  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController arm = TextEditingController();
  TextEditingController chest = TextEditingController();
  TextEditingController shoulder = TextEditingController();
  TextEditingController waist = TextEditingController();
  TextEditingController hipst = TextEditingController();
  TextEditingController thigh = TextEditingController();

  // @override
  // void initState() {
  //   // userService.getBodydata().then((data) {
  //   //   height.text = data.height.toString();
  //   //   weight.text = data.weight.toString();
  //   //   arm.text = data.arm.toString();
  //   //   chest.text = data.chest.toString();
  //   //   shoulder.text = data.shoulder.toString();
  //   //   waist.text = data.waist.toString();
  //   //   hipst.text = data.hipst.toString();
  //   //   thigh.text = data.thigh.toString(); });
  //   userService.getBodydata().then((data) {
  //     data.docs.forEach((element) {
  //       height.text = element['height'];
  //       weight.text = element['weight'];
  //       arm.text = element['arm'];
  //       chest.text = element['chest'];
  //       shoulder.text = element['shoulder'];
  //       waist.text = element['waist'];
  //       hipst.text = element['hipst'];
  //       thigh.text = element['thigh'];
  //     });
  //   });

  //   super.initState();
  // }
  @override
  void initState() {
    userService.getBodydata().then((value) {
      final datalist = value.docs.toList();
      height.text = datalist[0]['height'].toString();
      weight.text = datalist[0]['weight'].toString();
      arm.text = datalist[0]['arm'].toString();
      chest.text = datalist[0]['chest'].toString();
      shoulder.text = datalist[0]['shoulder'].toString();
      waist.text = datalist[0]['waist'].toString();
      hipst.text = datalist[0]['hipst'].toString();
      thigh.text = datalist[0]['thigh'].toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Body Measurements'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: height,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Height',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: weight,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Weight',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: arm,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Arm',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: chest,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Chest',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: shoulder,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Shoulder',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: waist,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Waist',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: hipst,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Hipst',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: thigh,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Thigh',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.blueAccent,
                  onPressed: () {
                    userService.updateBody(
                      double.parse(height.text),
                      double.parse(weight.text),
                      double.parse(arm.text),
                      double.parse(chest.text),
                      double.parse(shoulder.text),
                      double.parse(waist.text),
                      double.parse(hipst.text),
                      double.parse(thigh.text),
                      context,
                    );
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
