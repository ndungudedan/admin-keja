import 'dart:convert';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/user.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/index.dart';
import 'package:admin_keja/ui/register.dart';
import 'package:admin_keja/utility/connectioncallback.dart';
import 'package:admin_keja/views/inputFieldArea.dart';
import 'package:admin_keja/views/submitButton.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
  bool online = false;

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
                      child: ConnectionCallback(
                        onlineCall: () {
                          setState(() {
                            online = true;
                          });
                        },
                      ),
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
                            Image.asset(
                              'assets/images/logo_trans.png',
                              height: 150,
                            ),
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
                            FlatButton(onPressed: (){
                              Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Register()));
                            }, child: Text('CREATE ACCOUNT ?',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.blue
                            ),))
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
    if (sharedPreferences.checkEmail()&&!online) {
      localSignIn();
    } else {
      var result = await NetworkApi()
          .login(_emailController.text.trim(), _passwordController.text);
      print(result);
      var map = json.decode(result);
      userResponse = UserResponse.fromJson(map);
      print(map);
        setState(() {
          loading = false;
        });
      if (result !=null) {
        
        
        if (userResponse.status.code == Constants.success) {
          showTopSnackBar(
    context,
    CustomSnackBar.success(
      message:
          "success",
    ),
);
          savePrefs(userResponse.data);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Index()));
        } else {
          showTopSnackBar(
    context,
    CustomSnackBar.error(
      message:userResponse.status.message,
    ),
);
        }
      } else {
        showTopSnackBar(
    context,
    CustomSnackBar.error(
      message:
          "Something went wrong. Please try again later",
    ),
);
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
    if (sharedPreferences.getEmail() == _emailController.text.trim() &&
        sharedPreferences.getPassword() == _passwordController.text) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Index()));
    } else {
      showTopSnackBar(
    context,
    CustomSnackBar.error(
      message:
          "Invalid Credentals",
    ),
);
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
