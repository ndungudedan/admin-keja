import 'dart:convert';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/category.dart';
import 'package:admin_keja/models/status.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/photoviewer.dart';
import 'package:admin_keja/views/doneTextview.dart';
import 'package:admin_keja/views/textfield.dart';
import 'package:commons/commons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart' as path;
import 'package:video_player/video_player.dart';

class CreateApartment extends StatefulWidget {
  CreateApartment({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _CreateApartmentState createState() => _CreateApartmentState();
}

class _CreateApartmentState extends State<CreateApartment> {
  @override
  void initState() {
    location = false;
    getCategory();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<File> image_uri = [];
  List<File> toUpload = [];
  List<String> imagepaths = [];
  var promoimage_uri, promoimage_path;
  File videofile;
  String _imagefilePath;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _depositController = TextEditingController();
  final _addressController = TextEditingController();
  final _rentController = TextEditingController();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _featController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _spaceController = TextEditingController();
  final _bannertagController = TextEditingController();
  final _descriptionController = TextEditingController();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _rentFocus = FocusNode();
  final FocusNode _depositFocus = FocusNode();
  final FocusNode _locationFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _spaceFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  File banner;
  String bannertag = '';
  String apartmentName = '';
  List<String> downloadurl = [];
  Map<String, String> details = {};
  var step = 0;
  List<String> tags = [];
  List<String> features = [];
  double latitude;
  double longitude;
  bool location;
  bool isloading = false;
  Geolocator geolocator = Geolocator();
  Position currentLocation;
  final _step1Key = GlobalKey<FormState>();
  final _step2Key = GlobalKey<FormState>();
  MyCategory category;
  List<MyCategory> categories = List<MyCategory>();
  Status status = Status();
  double progress = 0.0;
  bool validatestep1 = false, validatestep2 = false;
  ProgressDialog progressDialog;

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId(apartmentName),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(
          title: apartmentName,
          //    snippet: office.address,
        ),
      );
      _markers[apartmentName] = marker;
    });
  }

  void pickMultipleImages() async {
    try {
      var result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'jpeg'],
          allowMultiple: true);
      if (result != null) {
        List<File> templist = result.paths.map((path) => File(path)).toList();
        for (int i = 0; i < templist.length; i++) {
          if (i < 16 && toUpload.length < 16) {
            compressAndGetFile(templist.elementAt(i));
          }
        }
      }
    } on TargetPlatform catch (e) {
      print('Error while picking the file: ' + e.toString());
    }
  }

  void pickBanner() async {
    try {
      var result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'jpeg'],
          allowMultiple: false);
      if (result != null) {
        File temp = File(result.files.single.path);
        var decodedImage = await decodeImageFromList(temp.readAsBytesSync());
        print(decodedImage.width);
        print(decodedImage.height);
        if (decodedImage.width >= Constants.bannerWidth &&
            decodedImage.height >= Constants.bannerHeight) {
          final directory = await getApplicationDocumentsDirectory();
          var res = await FlutterImageCompress.compressAndGetFile(
            temp.absolute.path,
            directory.path + '/' + path.basename(temp.path),
            quality: 40,
          );
          setState(() {
            banner = res;
          });
          print('worked');
          print(temp.lengthSync());
          print(res.lengthSync());
        }
      }
    } on TargetPlatform catch (e) {
      print('Error while picking the file: ' + e.toString());
    }
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
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: LightColors.kDarkYellow,
        title: Text('createApartment'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                width: 200,
                child: StepProgressIndicator(
                  onTap: (index) {
                    return () {
                      setState(() {
                        step = index;
                      });
                    };
                  },
                  totalSteps: 7,
                  currentStep: step,
                  size: 36,
                  selectedColor: Colors.amber,
                  unselectedColor: Colors.grey[200],
                  customStep: (index, color, _) => color == Colors.amber
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            color: color,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            color: color,
                            child: Icon(
                              Icons.remove,
                            ),
                          ),
                        ),
                ),
              ),
            ),
            Container(
              child: step == 0
                  ? step1()
                  : step == 1
                      ? step2()
                      : step == 2
                          ? locationMap()
                          : step == 3
                              ? step6()
                              : step == 4
                                  ? step3()
                                  : step == 5
                                      ? step4()
                                      : step == 6
                                          ? step5()
                                          : SizedBox(
                                              child: Text('data'),
                                            ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded step1() {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: <Widget>[
          Form(
            key: _step1Key,
            child: Column(
              children: <Widget>[
                Container(
                  width: 400,
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      border: Border.all()),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<MyCategory>(
                      validator: (value) =>
                          value == null ? 'Please choose an option' : null,
                      hint: Text("Select Category"),
                      value: category,
                      onChanged: (MyCategory val) {
                        setState(() {
                          category = val;
                        });
                      },
                      items: categories.map((MyCategory val) {
                        return DropdownMenuItem<MyCategory>(
                          value: val,
                          child: Text(
                            val.title,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                TextFieldArea(
                  hint: 'Title',
                  currentfocus: _titleFocus,
                  nextfocus: _descriptionFocus,
                  inputType: TextInputType.text,
                  controller: _titleController,
                ),
                TextFieldArea(
                  hint: 'Short description',
                  currentfocus: _descriptionFocus,
                  nextfocus: _rentFocus,
                  inputType: TextInputType.text,
                  controller: _descriptionController,
                ),
                TextFieldArea(
                  hint: 'Rent',
                  currentfocus: _rentFocus,
                  nextfocus: _depositFocus,
                  inputType: TextInputType.number,
                  controller: _rentController,
                ),
                TextFieldArea(
                  hint: 'Deposit',
                  currentfocus: _depositFocus,
                  nextfocus: _spaceFocus,
                  inputType: TextInputType.number,
                  controller: _depositController,
                ),
                TextFieldArea(
                  hint: 'Units',
                  currentfocus: _spaceFocus,
                  nextfocus: _spaceFocus,
                  inputType: TextInputType.number,
                  controller: _spaceController,
                ),
                Center(
                  child: RaisedButton(
                    splashColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                      side: BorderSide(color: Colors.amberAccent),
                    ),
                    color: const Color.fromRGBO(247, 64, 106, 1.0),
                    highlightElevation: 10,
                    elevation: 15,
                    animationDuration: Duration(seconds: 2),
                    focusElevation: 10,
                    colorBrightness: Brightness.dark,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(90, 15, 90, 15),
                      child: Text('Next'),
                    ),
                    onPressed: () {
                      if (_step1Key.currentState.validate()) {
                        setState(() {
                          step = 1;
                          validatestep1 = true;
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded step2() {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: <Widget>[
          Form(
            key: _step2Key,
            child: Column(
              children: <Widget>[
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
                  inputType: TextInputType.phone,
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
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: RaisedButton(
                      splashColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                        side: BorderSide(color: Colors.amberAccent),
                      ),
                      color: const Color.fromRGBO(247, 64, 106, 1.0),
                      highlightElevation: 10,
                      elevation: 15,
                      animationDuration: Duration(seconds: 2),
                      focusElevation: 10,
                      colorBrightness: Brightness.dark,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(90, 15, 90, 15),
                        child: Text('next'),
                      ),
                      onPressed: () {
                        if (_step2Key.currentState.validate()) {
                          setState(() {
                            step = 2;
                            validatestep2 = true;
                          });
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container step3() {
    return Container(
      child: Expanded(
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Text(toUpload.length.toString() + '/16'),
            ),
            Center(
              child: toUpload.length < 16
                  ? Container(
                      margin: EdgeInsets.all(12),
                      height: MediaQuery.of(context).size.height / 10,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.amberAccent,
                      child: IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: () {
                          if (toUpload.length < 16) {
                            pickMultipleImages();
                          } else {}
                        },
                      ),
                    )
                  : Center(
                      child: RaisedButton(
                        splashColor: Colors.amber,
                        color: const Color.fromRGBO(247, 64, 106, 1.0),
                        highlightElevation: 10,
                        elevation: 15,
                        animationDuration: Duration(seconds: 2),
                        focusElevation: 10,
                        colorBrightness: Brightness.dark,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(90, 15, 90, 15),
                          child: Text('Next'),
                        ),
                        onPressed: () {
                          setState(() {
                            step = 5;
                          });
                        },
                      ),
                    ),
            ),
            Container(
                child: toUpload.isNotEmpty
                    ? GridView.count(
                        shrinkWrap: true,
                        primary: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        scrollDirection: Axis.vertical,
                        children: List.generate(toUpload.length, (index) {
                          return GestureDetector(
                            child: Container(
                              margin: EdgeInsets.all(8),
                              alignment: Alignment.center,
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  Image.file(
                                    toUpload.elementAt(index),
                                    fit: BoxFit.fill,
                                  ),
                                  Positioned(
                                    bottom: 1.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(200, 0, 0, 0),
                                            Color.fromARGB(0, 0, 0, 0)
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 20.0),
                                      child: Text(
                                        tags != null && tags.isNotEmpty
                                            ? tags.elementAt(index)
                                            : index.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                        icon: Icon(Icons.close),
                                        color: Colors.red,
                                        onPressed: () {
                                          setState(() {
                                            toUpload.removeAt(index);
                                            tags.removeAt(index);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              addtag(index);
                            },
                          );
                        }),
                      )
                    : Center(
                        child: SizedBox(
                          child: Text('Please pick some images'),
                        ),
                      )),
          ],
        ),
      ),
    );
  }

  Container step6() {
    return Container(
      child: Expanded(
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Text('Please pick a banner'),
            ),
            Center(
                child: Text(
                    'Min height:' +
                        Constants.bannerHeight.toString() +
                        '\nMin width:' +
                        Constants.bannerWidth.toString(),
                    style: TextStyle(
                      color: Colors.red,
                    ))),
            Center(
                child: Container(
              margin: EdgeInsets.all(12),
              height: MediaQuery.of(context).size.height / 10,
              width: MediaQuery.of(context).size.width,
              color: Colors.blueAccent,
              child: IconButton(
                icon: Icon(Icons.add_a_photo),
                onPressed: () {
                  pickBanner();
                },
              ),
            )),
            banner != null
                ? Container(
                    child: Container(
                    margin: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Image.file(
                          banner,
                          fit: BoxFit.fill,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            controller: _bannertagController,
                            onFieldSubmitted: (value) {
                              setState(() {
                                bannertag = _bannertagController.text;
                              });
                            },
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: 'Say something nice',
                                labelText: 'tag',
                                helperText: 'keep it short'),
                            maxLines: 3,
                          ),
                        ),
                        Center(
                          child: RaisedButton(
                            splashColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0),
                              side: BorderSide(color: Colors.amberAccent),
                            ),
                            color: const Color.fromRGBO(247, 64, 106, 1.0),
                            highlightElevation: 10,
                            elevation: 15,
                            animationDuration: Duration(seconds: 2),
                            focusElevation: 10,
                            colorBrightness: Brightness.dark,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(90, 15, 90, 15),
                              child: Text('Next'),
                            ),
                            onPressed: () {
                              setState(() {
                                step = 4;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ))
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Flexible step4() {
    return Flexible(
      child: Container(
        height: double.maxFinite,
        child: Column(
          children: [
            Center(
              child: Text(features.length.toString() + '/11'),
            ),
            Flexible(
              child: Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(8),
                    itemCount: features.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(features.elementAt(index)),
                        leading: IconButton(
                          onPressed: () {
                            setState(() {
                              String deletedItem = features.removeAt(index);
                              Scaffold.of(context).showSnackBar(
                                  deletesnack(deletedItem, index));
                            });
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      );
                    }),
              ),
            ),
            features.length < 11
                ? Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5 / 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _featController,
                          onSubmitted: (value) {
                            setState(() {
                              if (features.length < 11) {
                                features.add(_featController.text);
                                _featController.clear();
                              }
                            });
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            icon: Icon(
                              Icons.business_center,
                              color: Colors.orangeAccent,
                              size: 30,
                            ),
                            hintText: 'Add Feature',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )),
                  )
                : Center(
                    child: RaisedButton(
                      splashColor: Colors.amber,
                      color: const Color.fromRGBO(247, 64, 106, 1.0),
                      highlightElevation: 10,
                      elevation: 15,
                      animationDuration: Duration(seconds: 2),
                      focusElevation: 10,
                      colorBrightness: Brightness.dark,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(90, 15, 90, 15),
                        child: Text('Next'),
                      ),
                      onPressed: () {
                        setState(() {
                          step = 6;
                        });
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Container step5() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Divider(),
          Text(
            'Apartment details',
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          Divider(),
          DoneTextArea(
            title: 'name: ',
            txt: _titleController.text,
          ),
          DoneTextArea(
            title: 'description: ',
            txt: _descriptionController.text,
          ),
          DoneTextArea(
            title: 'rent: ',
            txt: _rentController.text,
          ),
          DoneTextArea(
            title: 'deposit: ',
            txt: _depositController.text,
          ),
          DoneTextArea(
            title: 'space: ',
            txt: _spaceController.text,
          ),
          DoneTextArea(
              title: 'category: ', txt: category != null ? category.title : ''),
          DoneTextArea(
            title: 'phone: ',
            txt: _phoneController.text,
          ),
          DoneTextArea(
            title: 'email: ',
            txt: _emailController.text,
          ),
          DoneTextArea(
            title: 'address: ',
            txt: _addressController.text,
          ),
          DoneTextArea(
            title: 'location: ',
            txt: _locationController.text,
          ),
          DoneTextArea(
            title: 'latlong: ',
            txt: latitude.toString() + ' : ' + longitude.toString(),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: FlatButton(
                splashColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.amberAccent),
                ),
                highlightColor: Colors.green,
                onPressed: () {
                  submit();
                  if (validatestep1 && validatestep2) {
                    if (toUpload.length != 16) {
                      _scaffoldKey.currentState
                          .showSnackBar(snack('Please add more Images'));
                      return;
                    }
                    if (banner == null) {
                      _scaffoldKey.currentState
                          .showSnackBar(snack('Please add a banner'));
                      return;
                    }
                    if (latitude == null && latitude == null) {
                      _scaffoldKey.currentState
                          .showSnackBar(snack('Please pick a location'));
                      return;
                    }
                    if (_bannertagController.text.isEmpty) {
                      _scaffoldKey.currentState
                          .showSnackBar(snack('Banner tag cannot be empty'));
                      return;
                    }
                    if (tags.length != 16) {
                      _scaffoldKey.currentState
                          .showSnackBar(snack('Please fill all tags'));
                      return;
                    }
                    if (features.length != 11) {
                      _scaffoldKey.currentState
                          .showSnackBar(snack('Please add more features'));
                      return;
                    }
                    submit();
                  } else {
                    _scaffoldKey.currentState
                        .showSnackBar(snack('Please fill all details'));
                  }
                },
                child: Text(
                  'Finish',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SnackBar deletesnack(String deletedItem, var index) {
    return SnackBar(
      content: Text("Deleted \"${deletedItem}\""),
      action: SnackBarAction(
          label: "UNDO",
          onPressed: () => setState(
                () => features.insert(index, deletedItem),
              )),
    );
  }

  SnackBar snack(String message) {
    return SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );
  }

  Expanded locationMap() {
    return Expanded(
      child: Container(
          height: MediaQuery.of(context).size.height - 200,
          decoration: BoxDecoration(
              border: Border.all(
                  style: BorderStyle.solid, width: 2, color: Colors.blueGrey),
              color: Colors.transparent),
          child: PlacePicker(
            apiKey: Constants.googleApiKey, // Put YOUR OWN KEY here.
            onPlacePicked: (result) {
              print(result.geometry.location.lat);
              setState(() {
                step = 3;
                latitude = result.geometry.location.lat;
                longitude = result.geometry.location.lng;
              });
            },
            automaticallyImplyAppBarLeading: false,
            initialPosition: LatLng(-1.1567844, 36.913108),
            useCurrentLocation: true,
            resizeToAvoidBottomInset: true,
          )),
    );
  }

  void addtag(var index) async {
    var result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PhotoViewer(
              picList: image_uri,
              tagList: tags,
              index: index,
            )));
    setState(() {
      tags = result;
    });
  }

  Row featuresCard(var feature) {
    return Row(
      children: <Widget>[
        Icon(Icons.star),
        Container(
            child: Text(
          feature,
          style: TextStyle(
            color: Colors.lightBlueAccent,
          ),
        ))
      ],
    );
  }

  void submit() async {
    setState(() {
      details[UploadData.latitude] = latitude.toString();
      details[UploadData.longitude] = longitude.toString();
      details[UploadData.apartmentName] = _titleController.text;
      details[UploadData.apartmentRent] = _rentController.text;
      details[UploadData.apartmentDeposit] = _depositController.text;
      details[UploadData.apartmentPhone] = _phoneController.text;
      details[UploadData.description] = _descriptionController.text;
      details[UploadData.address] = _addressController.text;
      details[UploadData.category] = category.id;
      details[UploadData.companyId] = sharedPreferences.getCompanyId();
      details[UploadData.email] = _emailController.text;
      details[UploadData.location] = _locationController.text;
      details[UploadData.units] = _spaceController.text;
      details[UploadData.bannertag] = _bannertagController.text;
    });
    progressDialog.show();
    var result = await NetworkApi()
        .upload(toUpload, banner, tags, features, details, onProgress);
    print(result);
    progressDialog.hide();
    if (result != Constants.fail) {
      var Map = json.decode(result);
      setState(() {
        status = Status.fromJson(Map);
      });
      if (status.code == "1") {
        infoDialog(context, status.message, showNeutralButton: true,
            neutralAction: () {
          Navigator.pop(context);
        });
      } else {
        errorDialog(context, status.message, showNeutralButton: true);
      }
    } else {
      errorDialog(context, "Upload failed...", showNeutralButton: true);
    }
  }

  Future<void> getCategory() async {
    var result = await NetworkApi().fetchCategorys();
    print(result);
    if (result != Constants.fail) {
      var Map = json.decode(result);
      setState(() {
        var response = CategoryResponse.fromJson(Map);
        categories = response.data.categorys;
      });
    } else {
      errorDialog(context, "Could not fetch Category", showNeutralButton: true);
    }
  }

  Future<File> compressAndGetFile(File file) async {
    final directory = await getApplicationDocumentsDirectory();
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      directory.path + '/' + path.basename(file.path),
      quality: 40,
    );
    setState(() {
      toUpload.add(result);
      tags.add("Please add tag");
    });
    print('worked');
    print(file.lengthSync());
    print(result.lengthSync());
    return result;
  }
}
