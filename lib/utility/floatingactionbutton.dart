import 'package:admin_keja/common/app_icons.dart';
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
            Icon(
              AppIcons.home,
              color: Colors.amber,
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
