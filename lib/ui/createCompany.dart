import 'dart:convert';
import 'dart:io';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/company.dart';
import 'package:admin_keja/models/status.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/login.dart';
import 'package:admin_keja/utility/utility.dart';
import 'package:admin_keja/views/submitButton.dart';
import 'package:admin_keja/views/textfield.dart';
import 'package:commons/commons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CreateCompany extends StatefulWidget {
  CreateCompany({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CreateCompany> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  Constants constants = Constants();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _locationFocus = FocusNode();
  ProgressDialog progressDialog;
  double progress = 0.0;
  MyCompany company = MyCompany();
  Map<String, String> details = {};
  bool loading = false;
  File upload = null;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onProgress(double progress) {
    progressDialog.style(progress: progress);
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Download, isDismissible: true);
    progressDialog.style(
      message: 'Uploading data',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: progress,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Company'),
          backgroundColor: LightColors.kDarkYellow,
        ),
        body: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 100,
                          backgroundImage: upload != null
                              ? FileImage(upload)
                              : AssetImage('assets/images/placeholder.png')),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: LightColors.kLavender,
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.blue,
                            onPressed: () {
                              updateLogo();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
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
                  Builder(
                      builder: (context) => SubmitButton(
                          press: () {
                            if (_formKey.currentState.validate()) {
                              if (upload != null) {
                                submit();
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('add a logo'),
                                ));
                              }
                            }
                          },
                          text: 'Submit',
                          loading: loading)),
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> submit() async {
    details[UploadData.address] = _addressController.text;
    details[UploadData.email] = _emailController.text;
    details[UploadData.location] = _locationController.text;
    details[UploadData.phone] = _phoneController.text;
    details[UploadData.title] = _titleController.text;
    progressDialog.show();
    var result = await NetworkApi().createCompany(upload, details, onProgress);
    print(result);
    var Map = json.decode(result);progressDialog.hide();
    if (CompanyResponse.fromJson(Map).status.code == Constants.success) {
      MyCompany company = CompanyResponse.fromJson(Map).data;
      infoDialog(context, CompanyResponse.fromJson(Map).status.message+". You will be logged out",
          showNeutralButton: true, neutralAction: () {
Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  ModalRoute.withName('/'),
                );      });
    } else {
      errorDialog(context, CompanyResponse.fromJson(Map).status.message,
          showNeutralButton: true);
    }
    
  }

  void saveCompany(MyCompany company) {
    sharedPreferences.setCompanyAddress(company.address);
    sharedPreferences.setCompanyEmail(company.email);
    sharedPreferences.setCompanyId(company.id);
    sharedPreferences.setCompanyLocation(company.address);
    sharedPreferences.setCompanyName(company.name);
    sharedPreferences.setCompanyPhone(company.phone);
    sharedPreferences.setCompanyPhoto(company.logo);
  }

  void updateLogo() async {
    try {
      var result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: false);
      if (result != null) {
        List<File> templist = result.paths.map((path) => File(path)).toList();
        compressAndGetFile(templist.elementAt(0));
      }
    } on TargetPlatform catch (e) {
      print('Error while picking the file: ' + e.toString());
    }
  }

  Future<File> compressAndGetFile(File file) async {
    final directory = await getApplicationDocumentsDirectory();
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      directory.path + '/' + path.basename(file.path),
      quality: 80,
    );
    setState(() {
      upload = result;
    });

    print('worked');
    print(file.lengthSync());
    print(result.lengthSync());
    return result;
  }
}
