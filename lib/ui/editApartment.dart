import 'dart:convert';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/database/dboperations.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/apartment.dart';
import 'package:admin_keja/models/category.dart';
import 'package:admin_keja/models/features.dart';
import 'package:admin_keja/models/status.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/views/textfield.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class EditApartment extends StatefulWidget {
  EditApartment({
    Key key,
    this.title,
    this.apartment,
    this.features,
    @required this.step,
  }) : super(key: key);
  final String title;
  final MyApartment apartment;
  final List<Features> features;
  final int step;
  @override
  _CreateApartmentState createState() => _CreateApartmentState();
}

class _CreateApartmentState extends State<EditApartment> {
  @override
  void initState() {
    super.initState();
    location = false;
    step = widget.step;
    apartment = widget.apartment;
    features = widget.features;
    getCategory();
    initData(apartment);
  }

  @override
  void dispose() {
    super.dispose();
  }

  final dbHelper = DbOperations.instance;
  MyApartment apartment = MyApartment();
  List<File> image_uri = [];
  List<File> toUpload = [];
  List<String> imagepaths = [];
  var promoimage_uri, promoimage_path;
  File videofile;
  String _imagefilePath;
  String featId;
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
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _rentFocus = FocusNode();
  final FocusNode _depositFocus = FocusNode();
  final FocusNode _locationFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _spaceFocus = FocusNode();
  String apartmentName = '';
  List<String> downloadurl = [];
  Map<String, String> details = {};
  var step = 0;
  List<String> tags = [];
  List<Features> features = [];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(apartment.title),
        backgroundColor: LightColors.kDarkYellow,
        actions: [
          step == 3
              ? IconButton(
                  icon: Icon(
                    Icons.add_box_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _showDialog();
                  })
              : SizedBox(),
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              if (step == 0) {
                if (_step1Key.currentState.validate()) {
                  submitStep1();
                }
              } else if (step == 1) {
                if (_step2Key.currentState.validate()) {
                  submitStep2();
                }
              } else if (step == 3) {
                if (features.length >= 11) {
                  submitStep4();
                } else {
                  _scaffoldKey.currentState
                      .showSnackBar(snack('Not less than 11 features'));
                }
              }
            },
          ),
        ],
      ),
      body: Container(
        child: step == 0
            ? step1()
            : step == 1
                ? step2()
                : step == 3
                    ? step4()
                    : SizedBox(
                        child: Text('data'),
                      ),
      ),
    );
  }

  ListView step1() {
    return ListView(
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
                nextfocus: _rentFocus,
                inputType: TextInputType.text,
                controller: _titleController,
              ),
              TextFieldArea(
                hint: 'Rent',
                currentfocus: _rentFocus,
                nextfocus: _depositFocus,
                inputType: TextInputType.emailAddress,
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
            ],
          ),
        ),
      ],
    );
  }

  ListView step2() {
    return ListView(
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
              locationMap(),
            ],
          ),
        ),
      ],
    );
  }

  Column step4() {
    return Column(
      children: [
        Flexible(
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(8),
                itemCount: features.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        _featController.text = features.elementAt(index).feat;
                        featId = features.elementAt(index).id;
                      });
                    },
                    title: Text(features.elementAt(index).feat),
                    leading: IconButton(
                      onPressed: () {
                        infoDialog(context, "Please confirm feature deletion.",
                            positiveAction: () {
                          Scaffold.of(context)
                              .showSnackBar(snack('Request sent....'));
                          deleteFeature(index, features.elementAt(index).id);
                        },
                            positiveText: 'Yes',
                            negativeAction: () {},
                            negativeText: 'No',
                            showNeutralButton: false);
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
        Align(
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
                  features.elementAt(int.parse(featId)).feat =
                      _featController.text;
                  _featController.text = '';
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
                hintText: 'Edit Feature',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  SnackBar deletesnack(String deletedItem, var index) {
    return SnackBar(
      content: Text("Deleted \"${deletedItem}\""),
      action: SnackBarAction(
          label: "UNDO",
          onPressed: () => setState(
                () => features.elementAt(index).feat = deletedItem,
              )),
    );
  }

  SnackBar snack(String message) {
    return SnackBar(
      content: Text(message),
    );
  }

  Container locationMap() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              style: BorderStyle.solid, width: 2, color: Colors.blueGrey),
          color: Colors.transparent),
    );
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(8.0),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _featController,
                autofocus: true,
                decoration: InputDecoration(labelText: 'Add feature'),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          FlatButton(
              child: const Text('DONE'),
              onPressed: () {
                insertFeature();
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  void submitStep1() async {
    setState(() {
      details[UploadData.apartmentName] = _titleController.text;
      details[UploadData.apartmentRent] = _rentController.text;
      details[UploadData.apartmentDeposit] = _depositController.text;
      details[UploadData.category] = category.id;
      details[UploadData.units] = _spaceController.text;
    });

    var result = await NetworkApi().updateStep1(apartment.id, details);
    print(result);
    if (result != Constants.fail) {
      var Map = json.decode(result);
      Status status = Status.fromJson(Map);
      if (status.code == Constants.success) {
        infoDialog(context, status.message, showNeutralButton: true);
      } else {
        errorDialog(context, status.message, showNeutralButton: true);
      }
    } else {
      errorDialog(context, "Upload failed...", showNeutralButton: true);
    }
  }

  void submitStep2() async {
    setState(() {
      details[UploadData.latitude] = latitude.toString();
      details[UploadData.longitude] = longitude.toString();
      details[UploadData.apartmentPhone] = _phoneController.text;
      details[UploadData.email] = _emailController.text;
      details[UploadData.location] =
          _addressController.text + _locationController.text;
    });

    var result = await NetworkApi().updateStep2(apartment.id, details);
    print(result);
    if (result != Constants.fail) {
      var Map = json.decode(result);
      Status status = Status.fromJson(Map);
      if (status.code == Constants.success) {
        infoDialog(context, status.message, showNeutralButton: true);
      } else {
        errorDialog(context, status.message, showNeutralButton: true);
      }
    } else {
      errorDialog(context, "Upload failed...", showNeutralButton: true);
    }
  }

  void submitStep4() async {
    var result = await NetworkApi().updateFeatures(apartment.id, features);
    print(result);
    if (result != Constants.fail) {
      var Map = json.decode(result);
      Status status = Status.fromJson(Map);
      if (status.code == Constants.success) {
        infoDialog(context, status.message, showNeutralButton: true);
      } else {
        errorDialog(context, status.message, showNeutralButton: true);
      }
    } else {
      errorDialog(context, "Operation failed...", showNeutralButton: true);
    }
  }

  void deleteFeature(int index, var id) async {
    var result = await NetworkApi().deleteFeature(id);
    print(result);
    if (result != Constants.fail) {
      var Map = json.decode(result);
      Status status = Status.fromJson(Map);
      if (status.code == Constants.success) {
        setState(() {
          String deletedItem = features.removeAt(index).feat;
        });
        successDialog(context, status.message, showNeutralButton: true);
        dbHelper.deleteFeature(int.tryParse(features.removeAt(index).id));
      } else {
        errorDialog(context, status.message, showNeutralButton: true);
      }
    } else {
      errorDialog(context, "Operation failed...", showNeutralButton: true);
    }
  }

  void insertFeature() async {
    var result =
        await NetworkApi().insertFeature(apartment.id, _featController.text);
    print(result);
    if (result != Constants.fail) {
      var Map = json.decode(result);
      Status status = Status.fromJson(Map);
      setState(() {
        _featController.text = '';
      });
      if (status.code == Constants.success) {
        successDialog(context, status.message, showNeutralButton: true);
      } else {
        errorDialog(context, status.message, showNeutralButton: true);
      }
    } else {
      errorDialog(context, "Operation failed...", showNeutralButton: true);
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
      errorDialog(context, "Upload failed...", showNeutralButton: true);
    }
  }

  void initData(MyApartment apartment) {
    setState(() {
      _titleController.text = apartment.title;
      _emailController.text = apartment.email;
      _addressController.text = apartment.address;
      _depositController.text = apartment.deposit;
      _rentController.text = apartment.price;
      _phoneController.text = apartment.phone;
      _spaceController.text = apartment.space;
      _locationController.text = apartment.location;
    });
  }
}
