import 'dart:io';
import 'package:admin_keja/models/company.dart';
import 'package:admin_keja/views/textfield.dart';
import 'package:flutter/material.dart';

class EditCompany extends StatefulWidget {
  EditCompany({Key key, this.title, this.company}) : super(key: key);
  MyCompany company;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<EditCompany> {
  var imageuri;
  var imagepaths;
  var radio;
  var number, account;
  var accountradio;
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _locationFocus = FocusNode();
  MyCompany company = MyCompany();
  List<String> accounts = [
    'Credit',
    'Saving',
  ];

  @override
  void initState() {
    super.initState();
    company = widget.company;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('data'),
        ),
        body: ListView(
          children: <Widget>[
            Center(
                child: Stack(
              children: <Widget>[
                CircleAvatar(
                  minRadius: 50,
                  maxRadius: 70,
                  backgroundImage: imageuri != null
                      ? FileImage(imageuri)
                      : AssetImage('assets/images/avatar.png'),
                  backgroundColor: Colors.amber,
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.blue,
                      onPressed: () {

                      },
                    ),
                  ),
                ),
              ],
            )),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFieldArea(
                    hint: 'Title',
                    currentfocus: _titleFocus,
                    nextfocus: _emailFocus,
                    inputType: TextInputType.text,
                    controller: _titleController,
                  ),
                  TextFieldArea(
                    hint: 'Email',
                    currentfocus: _emailFocus,
                    nextfocus: _phoneFocus,
                    inputType: TextInputType.emailAddress,
                    controller: _emailController,
                  ),
                  TextFieldArea(
                    hint: 'Phone',
                    currentfocus: _phoneFocus,
                    nextfocus: _addressFocus,
                    inputType: TextInputType.number,
                    controller: _phoneController,
                  ),
                  TextFieldArea(
                    hint: 'Address',
                    currentfocus: _addressFocus,
                    nextfocus: _locationFocus,
                    inputType: TextInputType.streetAddress,
                    controller: _addressController,
                  ),
                  TextFieldArea(
                    hint: 'Location',
                    currentfocus: _locationFocus,
                    nextfocus: _locationFocus,
                    inputType: TextInputType.streetAddress,
                    controller: _locationController,
                  ),
                  Center(
                    child: RaisedButton(
                      splashColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                        side: BorderSide(color: Colors.amberAccent),
                      ),
                      color: Colors.lightBlueAccent,
                      highlightElevation: 10,
                      elevation: 15,
                      animationDuration: Duration(seconds: 2),
                      focusElevation: 10,
                      colorBrightness: Brightness.dark,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(90, 15, 90, 15),
                        child: Text('Submit'),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          submit();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          
          ],
        )
        );
  }

  void submit() {}

}
