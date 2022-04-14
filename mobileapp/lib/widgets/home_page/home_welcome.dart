import 'package:flutter/material.dart';

class HomeWelcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? text;
    int date = DateTime.now().hour + 3;

    if (date < 12 && date > 6) {
      text = 'Good Morning';
    } else if (date >= 12 && date <= 17) {
      text = 'Good Afternoon';
    } else if (date > 17 && date < 21) {
      text = 'Good Evening';
    } else {
      text = 'Good Night';
    }
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.orangeAccent, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${text},',
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              )
            ],
          ),
          Divider(
            color: Colors.orangeAccent,
            height: 10,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
        ],
      ),
    );
  }
}
