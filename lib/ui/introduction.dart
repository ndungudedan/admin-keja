import 'package:admin_keja/ui/index.dart';
import 'package:admin_keja/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';


class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset(assetName, width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Your sacco at hand",
          body:
              "Access all sacco services seamlessly from the palm of your hand.",
          image: _buildImage('assets/images/login.jpeg'),
          decoration: pageDecoration,
        ),

        PageViewModel(
          title: "Your sacco at hand",
          body:
              "Access all sacco services seamlessly from the palm of your hand.",
          image: _buildImage('assets/images/ic_launcher.png'),
          decoration: pageDecoration,
        ),
    
        PageViewModel(
          title: "Get set, Ready!!! Launch",
          body:
              "Access all sacco services seamlessly from the palm of your hand.",
          image: _buildImage('assets/images/ic_launcher.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Skip',
        style: TextStyle(fontSize: 20,color: Colors.orange),),
      ),
      //next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
