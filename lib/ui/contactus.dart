import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  Constants constants=Constants();

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
          title: Text('Contact Us'),
        ),
          body: Center(
        child: 
          Container(
            padding: EdgeInsets.all(5),
            child: Container(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('Phone'),
                    leading: Icon(Icons.call),
                    subtitle: Text('0700314700'),
                  ),
                  ListTile(
                    title: Text('Email'),
                    leading: Icon(Icons.email),
                    subtitle: Text('adminkeja@gmail.com'),
                  ),
                  ListTile(
                    title: Text('Address'),
                    leading: Icon(Icons.account_box),
                    subtitle:
                        Text('255-00200' + '\n' + 'Nairobi'),
                  ),
                ],
              ),
            ),
          ),
       
      ),
    );
  }
}