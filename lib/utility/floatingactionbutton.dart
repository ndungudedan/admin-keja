import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class floatingButton extends StatelessWidget {
  floatingButton({@required this.onPressed,@required this.title});
  final GestureTapCallback onPressed;
  String title;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.deepOrange,
      splashColor: Colors.orange,
      child: Padding(
        padding:  EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children:  <Widget>[
            RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.explore,
                color: Colors.amber,
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}
