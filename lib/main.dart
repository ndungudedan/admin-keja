import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/ui/introduction.dart';
import 'package:admin_keja/ui/login.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPreferences.init();
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: firsttime ? OnBoardingPage() : LoginPage(),
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
