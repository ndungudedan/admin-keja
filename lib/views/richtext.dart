import 'package:flutter/material.dart';

class RichTextArea extends StatelessWidget {
  final String txt;
  final String title;
  RichTextArea({this.txt,this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.fromLTRB(10, 2, 5, 0),
      child: (RichText(
        text: TextSpan(
            text: title,
            style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.normal),
            children: <TextSpan>[
              TextSpan(
                  text: txt,
                  style: TextStyle(),
                    )
            ]),
      )),
    );
  }
}
