import 'dart:convert';

import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/user.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/index.dart';
import 'package:admin_keja/views/inputFieldArea.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  User user = User();
  UserResponse userResponse = UserResponse();
  Constants constant = Constants();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
      resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: Container(
          decoration: BoxDecoration(image: backgroundImage),
          child: Padding(

padding: EdgeInsets.fromLTRB(40, 100, 40, 150),            child: Card(
                  color: LightColors.kDarkYellow,
                  elevation: 50,
                        child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Form(
                        key: form,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            InputFieldArea(
                              controller: _emailController,
                              hint: 'email',
                              obscure: false,
                              icon: Icons.person_outline,
                            ),
                            InputFieldArea(
                              controller: _passwordController,
                              hint: 'Password',
                              obscure: true,
                              icon: Icons.lock_outline,
                            ),
                          ],
                        )),
                    InkWell(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
                          width: buttonSqueezeAnimation.value,
                          height: 50.0,
                          alignment: FractionalOffset.center,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(247, 64, 106, 1.0),
                              borderRadius:
                                  BorderRadius.all(const Radius.circular(30.0))),
                          child: buttonSqueezeAnimation.value > 75.0
                              ? Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 0.3,
                                  ),
                                )
                              : CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.white),
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
              ),
            ),
          ),
        ));
  }

  Future<void> login() async {
    if (sharedPreferences.checkEmail()) {
      localSignIn();
    } else {
      var result = await NetworkApi()
          .login(_emailController.text, _passwordController.text);
      print(result);
      var Map = json.decode(result);
      userResponse = UserResponse.fromJson(Map);
      if (userResponse.status.code == '1') {
        savePrefs(userResponse.data);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Index()));
      } else {
        _scaffoldKey.currentState
            .showSnackBar(snack(userResponse.status.message));
      }
    }
  }

  Future<void> savePrefs(User user) async {
    sharedPreferences.setEmail(user.email);
    sharedPreferences.setPassword(user.password);
    sharedPreferences.setUserId(user.id);
    sharedPreferences.setPhone(user.phone);
    sharedPreferences.setPhoto(user.photo);
    sharedPreferences.setSurname(user.name);
  }

  localSignIn() {
    if (sharedPreferences.getEmail() == _emailController.text.trim()) {
      if (sharedPreferences.getPassword() == _passwordController.text) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Index()));
      }
    }
  }

  SnackBar snack(String message) {
    return SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 500),
    );
  }
}
