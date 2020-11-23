import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class MyBottomAppBar extends StatelessWidget {
  const MyBottomAppBar({
    this.companyPressed,
    this.homePressed,
    this.settingsPressed,
    this.selected,
  });
  final GestureTapCallback homePressed;
  final GestureTapCallback companyPressed;
  final GestureTapCallback settingsPressed;
  final int selected;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: LightColors.kDarkYellow,
      // shape: shape,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon:  Icon(
                Icons.menu,
                color: selected==0 ? Colors.deepOrange :Colors.white,
                size: 30,
              ),
              onPressed: () {
                homePressed();
              },
            ),
            //        if (centerLocations.contains(fabLocation)) const Spacer(),
            IconButton(
              icon:  Icon(
                Icons.search,
                color: selected==1 ? Colors.deepOrange :Colors.white,
                size: 30,
              ),
              onPressed: () {
                companyPressed();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: selected==2 ? Colors.deepOrange :Colors.white,
                size: 30,
              ),
              onPressed: () {
                settingsPressed();
              },
            ),
          ],
        ),
      ),
    );
  }
}
