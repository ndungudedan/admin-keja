import 'package:flutter/material.dart';

class MyBottomAppBar extends StatelessWidget {
  const MyBottomAppBar({
      this.companyPressed, this.homePressed, this.settingsPressed,});
  final GestureTapCallback homePressed;
  final GestureTapCallback companyPressed;
  final GestureTapCallback settingsPressed;
  static final centerLocations = <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // shape: shape,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              icon: const Icon(
                Icons.menu,
                color: Colors.amberAccent,
              ),
              onPressed: () {
                homePressed();
              },
            ),
            //        if (centerLocations.contains(fabLocation)) const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.amber,
              ),
              onPressed: () {
                
                companyPressed();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.amberAccent,
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
