import 'dart:convert';

import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/status.dart';
import 'package:admin_keja/models/user.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/utility/connectioncallback.dart';
import 'package:admin_keja/views/inputFieldArea.dart';
import 'package:admin_keja/views/submitButton.dart';
import 'package:commons/commons.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Register extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Register> with TickerProviderStateMixin {
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
          title: Text('Create Account'),
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
    setState(() {
      loading = true;
    });
    var result = await NetworkApi().signUp(_emailController.text);
    print(result);
    var Map = json.decode(result);
    Status status = Status.fromJson(Map);
    setState(() {
      loading = false;
    });
    if (status.code == '1') {
      successDialog(context, status.message, neutralAction: () {
        Navigator.pop(context);
      });
    } else {
      errorDialog(context, status.message);
    }
  }

  SnackBar snack(String message) {
    return SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 500),
    );
  }
}
