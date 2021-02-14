import 'dart:convert';
import 'dart:io';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/company.dart';
import 'package:admin_keja/models/status.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/utility/utility.dart';
import 'package:admin_keja/views/submitButton.dart';
import 'package:admin_keja/views/textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:commons/commons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';

class EditCompany extends StatefulWidget {
  EditCompany({Key key, this.title, this.company}) : super(key: key);
  MyCompany company;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<EditCompany> {
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
  ProgressDialog progressDialog;
  double progress = 0.0;

  Constants constants = Constants();
  MyCompany company = MyCompany();
  Map<String, String> details = {};
  bool loading = false;
  File upload = null;
  @override
  void initState() {
    super.initState();
    company = widget.company;
    if (company != null) {
      initText(company);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initText(MyCompany company) {
    _titleController.text = company.name ?? '';
    _emailController.text = company.email ?? '';
    _addressController.text = company.address ?? '';
    _phoneController.text = company.phone ?? '';
    _locationController.text = company.location ?? '';
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
          title: Text('Edit Company Details'),
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
                              : CachedNetworkImageProvider(
                                  constants.path +
                                      sharedPreferences.getCompanyId() +
                                      constants.folder +
                                      company.logo,
                                )),
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
                  SubmitButton(
                      press: () {
                        if (_formKey.currentState.validate()) {
                          submit();
                        }
                      },
                      text: 'Submit',
                      loading: loading)
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> submit() async {
    details[UploadData.address] = _addressController.text;
    details[UploadData.companyId] = sharedPreferences.getCompanyId();
    details[UploadData.email] = _emailController.text;
    details[UploadData.location] = _locationController.text;
    details[UploadData.phone] = _phoneController.text;
    details[UploadData.title] = _titleController.text;
    progressDialog.show();
    var result = await NetworkApi().updateCompany(upload, details);
    print(result);
    progressDialog.hide();
    if (result != Constants.fail) {
      var Map = json.decode(result);
      Status status = Status.fromJson(Map);
      if (status.code == Constants.success) {
        saveCompany();
        infoDialog(context, status.message, showNeutralButton: true,
            neutralAction: () {
          Navigator.pop(context);
        });
      } else {
        errorDialog(context, status.message, showNeutralButton: true);
      }
    } else {
      errorDialog(context, "Failed...Please try again later",
          showNeutralButton: true);
    }
  }

  void saveCompany() {
    sharedPreferences.setCompanyAddress(_addressController.text);
    sharedPreferences.setCompanyEmail(_emailController.text);
    sharedPreferences.setCompanyLocation(_locationController.text);
    sharedPreferences.setCompanyName(_titleController.text);
    sharedPreferences.setCompanyPhone(_phoneController.text);
    if (upload != null) {
      sharedPreferences.setCompanyPhoto(path.basename(upload.path));
    }
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
