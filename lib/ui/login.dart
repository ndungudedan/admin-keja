import 'dart:convert';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/management/management.dart';
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
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final form = GlobalKey<FormState>();
  bool loading = false;

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
    /* _loginButtonController = AnimationController(
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
    ); */
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
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: SafeArea(
                                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ConnectionCallback(),
                  ),
                )),
              Positioned(
                bottom: 80,
                top: 80,
                right: 40,
                left: 40,
                child: Card(
                  color: LightColors.kDarkYellow,
                  elevation: 50,
                  child: Center(
                    child: Form(
                        key: form,
                        child: ListView(
                          children: <Widget>[
                            Image.asset('assets/images/logo_trans.png',height: 150,),
                            InputFieldArea(
                              controller: _emailController,
                              currentfocus: _emailFocus,
                              nextfocus: _passwordFocus,
                              hint: 'email',
                              obscure: false,
                              icon: Icons.person_outline,
                            ),
                            InputFieldArea(
                              controller: _passwordController,
                              currentfocus: _passwordFocus,
                              hint: 'Password',
                              obscure: true,
                              icon: Icons.lock_outline,
                            ),
                            SubmitButton(
                      text: 'Sign In',
                      loading: loading,
                      press: () {
                        login();
                      },
                    ),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  login() async {
    setState(() {
      loading = true;
    });
    if (sharedPreferences.checkEmail()) {
      localSignIn();
    } else {
      var result = await NetworkApi()
          .login(_emailController.text.trim(), _passwordController.text);
      print(result);
      if (result != Constants.fail) {
        var Map = json.decode(result);
        userResponse = UserResponse.fromJson(Map);
        setState(() {
          loading = false;
        });
        if (userResponse.status.code == Constants.success) {
          savePrefs(userResponse.data);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Index()));
        } else {
          _scaffoldKey.currentState
              .showSnackBar(snack(userResponse.status.message));
        }
      } else {
        _scaffoldKey.currentState
            .showSnackBar(snack("Failed..Please try later"));
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
    if (sharedPreferences.getEmail() == _emailController.text.trim()
    &&sharedPreferences.getPassword() == _passwordController.text) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Index()));
      
    } else {
      _scaffoldKey.currentState.showSnackBar(snack("Invalid credentials"));
      setState(() {
        loading = false;
      });
    }
  }

  SnackBar snack(String message) {
    return SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1000),
    );
  }
}
