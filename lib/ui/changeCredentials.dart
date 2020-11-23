import 'dart:convert';

import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/status.dart';
import 'package:admin_keja/models/user.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/index.dart';
import 'package:admin_keja/views/inputFieldArea.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChangeCredentials extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<ChangeCredentials>
    with TickerProviderStateMixin {
  User user = User();
  Constants constant = Constants();
  final _emailController = TextEditingController();
  final _oldController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  AnimationController _loginButtonController;
  Animation buttonSqueezeAnimation;
  var animationStatus = 0;
  final form = GlobalKey<FormState>();

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);
    buttonSqueezeAnimation = Tween(
      begin: 320.0,
      end: 70.0,
    ).animate(
      CurvedAnimation(
        parent: _loginButtonController,
        curve: Interval(
          0.0,
          0.150,
        ),
      ),
    );
  }

  DecorationImage backgroundImage = DecorationImage(
    image: ExactAssetImage('assets/images/show.jpg'),
    fit: BoxFit.cover,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kDarkYellow,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Credentials'),
      ),
        key: _scaffoldKey,
        body: Container(
          child: Card(
                color: LightColors.kDarkYellow,
                elevation: 50,
                child: Form(
          key: form,
          child: ListView(
            children: <Widget>[
              InputFieldArea(
          controller: _emailController,
          hint: 'email',
          obscure: false,
          icon: Icons.person_outline,
              ),
              InputFieldArea(
          controller: _oldController,
          hint: 'Current Password',
          obscure: true,
          icon: Icons.lock_outline,
              ),
              InputFieldArea(
          controller: _newController,
          hint: 'New Password',
          obscure: true,
          icon: Icons.lock_outline,
              ),
              InputFieldArea(
          controller: _confirmController,
          hint: 'Confirm Password',
          obscure: true,
          icon: Icons.lock_outline,
              ),
              InkWell(
            child: Container(
            margin: EdgeInsets.fromLTRB(10, 80, 10, 0),
            width: buttonSqueezeAnimation.value,
            height: 40.0,
            alignment: FractionalOffset.center,
            decoration: BoxDecoration(
          color: const Color.fromRGBO(247, 64, 106, 1.0),
          borderRadius: BorderRadius.all(
            const Radius.circular(30.0))),
            child: buttonSqueezeAnimation.value > 75.0
          ? Text(
            'Confirm',
            style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3,
            ),
                )
          : CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white),
                )),
            onTap: () {
            login();
            setState(() {
            animationStatus = 1;
            });
            _playAnimation();
            },
                )
            ],
            ),
          )),
        ));
  }

  Future<void> login() async {
    if (!sharedPreferences.checkEmail()) {
      _scaffoldKey.currentState.showSnackBar(snack('Please Login First'));
      return;
    } else if (sharedPreferences.getPassword() != _oldController.text) {
      _scaffoldKey.currentState.showSnackBar(snack('Incorrect password'));
      return;
    } else {
      var result = await NetworkApi()
          .changeCredentials(_emailController.text, _confirmController.text,
          sharedPreferences.getUserId());
      print(result);
      var Map = json.decode(result);
      Status status = Status.fromJson(Map);
      if (status.code == '1') {
        savePrefs();
        Navigator.of(context).pop();
      } else {
        _scaffoldKey.currentState
            .showSnackBar(snack(status.message));
      }
    }
  }

  Future<void> savePrefs() async {
    sharedPreferences.setEmail(_emailController.text);
    sharedPreferences.setPassword(_confirmController.text);
  }

  SnackBar snack(String message) {
    return SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 500),
    );
  }
}
