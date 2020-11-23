import 'package:admin_keja/common/app_icons.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final GestureTapCallback prevPressed;
  final GestureTapCallback nextPressed;
  final sortMonth, year, totalExpected, totalPaid, totalDue;

  const CustomBarWidget({
    Key key,
    @required this.nextPressed,
    @required this.prevPressed,
    @required this.height,
    @required this.sortMonth,
    @required this.year,
    @required this.totalDue,
    @required this.totalExpected,
    @required this.totalPaid,
  });

  @override
  _CustomBarWidgetState createState() => _CustomBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomBarWidgetState extends State<CustomBarWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.0,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
          color: LightColors.kDarkYellow,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))),
              width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  child: Center(
                    child: Text(
                      "Home",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
            Positioned(
              top: 80.0,
                      left: 0.0,
                      right: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                          color: LightColors.kLightYellow2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(AppIcons.left_open_outline),
                      onPressed: () {
                        widget.prevPressed();
                      },
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              DateFormat.MMM().format(
                                DateTime.parse(widget.year+widget.sortMonth+'01')
                                )+' '+widget.year,
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Expected: '),
                                Text(widget.totalExpected.toString()),
                              ],
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('paid: '),
                                Text(widget.totalPaid.toString())
                              ],
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('due: '),
                                Text(widget.totalDue.toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(AppIcons.right_open_outline),
                      onPressed: () {
                        widget.nextPressed();
                      },
                    ),
                  ],
                ),
              ),
            )),
          ],
        ));
  }
}
