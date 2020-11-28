import 'dart:convert';

import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/status.dart';
import 'package:admin_keja/models/user.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/index.dart';
import 'package:admin_keja/utility/connectioncallback.dart';
import 'package:admin_keja/views/inputFieldArea.dart';
import 'package:admin_keja/views/submitButton.dart';
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
    final FocusNode _emailFocus = FocusNode();
  final FocusNode _oldpasswordFocus = FocusNode();
    final FocusNode _newpassFocus = FocusNode();
  final FocusNode _confirmpasswordFocus = FocusNode();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  AnimationController _loginButtonController;
  Animation buttonSqueezeAnimation;
  var animationStatus = 0;
  bool loading = false;
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
                    ConnectionCallback(
                      onlineCall: () {},
                    ),
                    InputFieldArea(
                      controller: _emailController,
                      currentfocus: _emailFocus,
                      nextfocus: _oldpasswordFocus,
                      hint: 'email',
                      obscure: false,
                      icon: Icons.person_outline,
                    ),
                    InputFieldArea(
                      controller: _oldController,
                      currentfocus: _oldpasswordFocus,
                      nextfocus: _newpassFocus,
                      hint: 'Current Password',
                      obscure: true,
                      icon: Icons.lock_outline,
                    ),
                    InputFieldArea(
                      controller: _newController,
                      currentfocus: _newpassFocus,
                      nextfocus: _confirmpasswordFocus,
                      hint: 'New Password',
                      obscure: true,
                      icon: Icons.lock_outline,
                    ),
                    InputFieldArea(
                      controller: _confirmController,
                      currentfocus: _confirmpasswordFocus,
                      hint: 'Confirm Password',
                      obscure: true,
                      icon: Icons.lock_outline,
                    ),
                    SubmitButton(
                      text: 'Submit',
                      loading: loading,
                      press: () {
                        login();
                      },
                    ),
                  ],
                ),
              )),
        ));
  }

  login() async {
    if (!sharedPreferences.checkEmail()) {
      _scaffoldKey.currentState.showSnackBar(snack('Please Login First'));
      return;
    } else if (sharedPreferences.getPassword() != _oldController.text) {
      _scaffoldKey.currentState.showSnackBar(snack('Incorrect password'));
      return;
    } else {
      setState(() {
        loading = true;
      });
      var result = await NetworkApi().changeCredentials(_emailController.text,
          _confirmController.text, sharedPreferences.getUserId());
      print(result);
      if (result != Constants.fail) {
        var Map = json.decode(result);
        Status status = Status.fromJson(Map);
        setState(() {
          loading = false;
        });
        if (status.code == '1') {
          savePrefs();
          Navigator.of(context).pop();
        } else {
          _scaffoldKey.currentState.showSnackBar(snack(status.message));
        }
      }else{
        _scaffoldKey.currentState
            .showSnackBar(snack("Failed..Please try later"));
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
