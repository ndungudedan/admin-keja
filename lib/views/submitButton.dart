import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  SubmitButton({
    Key key,
    @required this.press,
    @required this.text,
    @required this.loading,
  }) : super(key: key);

  final VoidCallback press;
  final bool loading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
                  child: RaisedButton(
                    splashColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                      side: BorderSide(color: Colors.amberAccent),
                    ),
                    color: const Color.fromRGBO(247, 64, 106, 1.0),
                    highlightElevation: 10,
                    elevation: 15,
                    animationDuration: Duration(seconds: 2),
                    focusElevation: 10,
                    colorBrightness: Brightness.dark,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      child: !loading ?Text(text)
                      :SizedBox(
                        height: 20,width: 20,
                        child: CircularProgressIndicator(backgroundColor: Colors.white)),
                    ),
                    onPressed: () {
                      press();                        
                    },
                  ),
                );
  }
}
