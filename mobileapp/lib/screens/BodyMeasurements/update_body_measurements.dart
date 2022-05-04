import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
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
                      prefixIcon: Icon(Icons.height),
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
                      prefixIcon: Icon(FontAwesomeIcons.weight),
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
                      prefixIcon: Icon(FontAwesomeIcons.dumbbell),
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
                      prefixIcon: Icon(FontAwesomeIcons.dumbbell),
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
                      prefixIcon: Icon(FontAwesomeIcons.dumbbell),
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
                      prefixIcon: Icon(FontAwesomeIcons.dumbbell),
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
                      prefixIcon: Icon(FontAwesomeIcons.dumbbell),
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
                      prefixIcon: Icon(FontAwesomeIcons.dumbbell),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                    widthDevice * 0.6,
                    heightDevice * 0.06,
                  )),
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
                    style: TextStyle(
                        color: Colors.white, fontSize: widthDevice * 0.05),
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
