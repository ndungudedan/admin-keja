import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/introduction.dart';
import 'package:admin_keja/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPreferences.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: LightColors.kLightYellow, // navigation bar color
    statusBarColor: Color(0xffffb969), // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool firsttime = false;
  Constants constants=Constants();

  @override
  Widget build(BuildContext context) {
    initPrefs();
    return MaterialApp(
      title: 'Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: LightColors.kDarkBlue,
              displayColor: LightColors.kDarkBlue,
              fontFamily: 'Poppins'
            ),
      ),
      home: firsttime ? OnBoardingPage() : LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
    Future<void> initPrefs() async {
    if (!sharedPreferences.checkFirstTime()) {
      sharedPreferences.setFirstLogin(false);
      firsttime = true;
    } else {
      firsttime = sharedPreferences.getFirstLogin();
    }
  }
}
