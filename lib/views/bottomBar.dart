import 'package:admin_keja/common/app_icons.dart';
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
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon:  Icon(
                AppIcons.home,
                color: selected==0 ? Colors.deepOrange :Colors.white,
                size: 30,
              ),
              onPressed: () {
                homePressed();
              },
            ),
            IconButton(
              icon:  Icon(
                AppIcons.edit,
                color: selected==1 ? Colors.deepOrange :Colors.white,
                size: 30,
              ),
              onPressed: () {
                companyPressed();
              },
            ),
            IconButton(
              icon: Icon(
                AppIcons.article_alt,
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
