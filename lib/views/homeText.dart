import 'package:flutter/material.dart';

class HomeTextArea extends StatelessWidget {
  final String txt;
  final String title;
  final int colorHex;
  HomeTextArea({this.txt, this.title, this.colorHex});
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.fromLTRB(10, 2, 5, 0),
      child: Row(
        children: [
          ClipOval(
                      child: Container(
                        width: 10,
              height: 10,
              color: Color(colorHex),
            ),
          ),
          (RichText(
            text: TextSpan(
                text: title,
                style: TextStyle(fontSize: 14.0,
                color: Colors.black54,
                fontWeight: FontWeight.w500,),
                children: <TextSpan>[
                  TextSpan(
                    text: txt,
                    style: TextStyle(),
                  )
                ]),
          )),
        ],
      ),
    );
  }
}
