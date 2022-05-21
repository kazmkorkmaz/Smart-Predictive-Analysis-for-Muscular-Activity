import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsAndPolicy extends StatefulWidget {
  String fileName;
  TermsAndPolicy({required this.fileName});
  @override
  State<TermsAndPolicy> createState() => _TermsAndPolicyState();
}

class _TermsAndPolicyState extends State<TermsAndPolicy> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 150)).then((value) {
                return rootBundle.loadString('lib/assets/${widget.fileName}');
              }),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return Markdown(
                    data: snapshot.data.toString(),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Ok',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
