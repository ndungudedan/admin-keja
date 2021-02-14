import 'dart:convert';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/database/dao.dart';
import 'package:admin_keja/database/databasehelper.dart';
import 'package:admin_keja/database/dboperations.dart';
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
import 'package:moor/moor.dart' as moor;

class EditApartment extends StatefulWidget {
  EditApartment({
    Key key,
    this.title,
    this.apartment,
    this.features,
    @required this.step,
  }) : super(key: key);
  final String title;
  final MyApartmentTableData apartment;
  final List<MyFeaturesTableData> features;
  final int step;
  @override
  _CreateApartmentState createState() => _CreateApartmentState();
}

class _CreateApartmentState extends State<EditApartment> {
  List<Features> typeChangeFeatures(List<MyFeaturesTableData> features) {
    List<Features> result = [];
    if (features != null && features.isNotEmpty) {
      features.forEach((element) {
        Features val = Features();
        val.apartment_id = element.apartment_id;
        val.feat = element.feat;
        val.id = element.onlineid;
        result.add(val);
      });
    }
    return result;
  }

  MyApartment typeChangeApartment(MyApartmentTableData apartmentTableData) {
    MyApartment apartment = MyApartment();
    apartment.address = apartmentTableData.address;
    apartment.banner = apartmentTableData.banner;
    apartment.bannertag = apartmentTableData.bannertag;
    apartment.category = apartmentTableData.category;
    apartment.comments = apartmentTableData.comments;
    apartment.deposit = apartmentTableData.deposit;
    apartment.description = apartmentTableData.description;
    apartment.email = apartmentTableData.emailaddress;
    apartment.id = apartmentTableData.onlineid;
    apartment.latitude = apartmentTableData.latitude;
    apartment.likes = apartmentTableData.likes;
    apartment.location = apartmentTableData.location;
    apartment.longitude = apartmentTableData.longitude;
    apartment.phone = apartmentTableData.phone;
    apartment.price = apartmentTableData.price;
    apartment.rating = apartmentTableData.rating;
    apartment.space = apartmentTableData.space;
    apartment.title = apartmentTableData.title;
    apartment.video = apartmentTableData.video;
    apartment.vacant = apartmentTableData.vacant;
    apartment.enabled = apartmentTableData.enabled;
    return apartment;
  }

  @override
  void initState() {
    super.initState();
    location = false;
    step = widget.step;
    apartment = typeChangeApartment(widget.apartment);
    features = typeChangeFeatures(widget.features);
    getCategory();
    initData(apartment);
  }

  @override
  void dispose() {
    super.dispose();
  }

  final dbHelper = DbOperations.instance;
  MyApartment apartment;
  List<File> image_uri = [];
  List<File> toUpload = [];
  List<String> imagepaths = [];
  var promoimage_uri, promoimage_path;
  File videofile;
  String _imagefilePath;
  int featIndex;
  var dao = DatabaseDao(databasehelper);
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
                if (features.length >= 4) {
                  submitStep4();
                } else {
                  _scaffoldKey.currentState
                      .showSnackBar(snack('Not less than 4 features'));
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
                        featIndex = index;
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
                  features.elementAt(featIndex).feat = _featController.text;
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
        var companion = MyApartmentTableCompanion(
          onlineid: moor.Value(apartment.id),
          banner: moor.Value(apartment.banner),
          bannertag: moor.Value(apartment.bannertag),
          description: moor.Value(apartment.description),
          title: moor.Value(_titleController.text),
          category: moor.Value(category.title),
          emailaddress: moor.Value(apartment.email),
          location: moor.Value(apartment.location),
          address: moor.Value(apartment.address),
          phone: moor.Value(apartment.phone),
          video: moor.Value(apartment.video),
          price: moor.Value(_rentController.text),
          deposit: moor.Value(_depositController.text),
          space: moor.Value(_spaceController.text),
          latitude: moor.Value(apartment.latitude),
          longitude: moor.Value(apartment.longitude),
          rating: moor.Value(apartment.rating),
          likes: moor.Value(apartment.likes),
          comments: moor.Value(apartment.comments),
          enabled: moor.Value(apartment.enabled),
          vacant: moor.Value(apartment.vacant),
        );
        dao.upsertApartment(companion);
        successDialog(context, status.message, showNeutralButton: true);
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
      details[UploadData.location] = _locationController.text;
      details[UploadData.address] = _addressController.text;
    });

    var result =
        await NetworkApi().updateStep2(apartment.id.toString(), details);
    print(result);
    if (result != Constants.fail) {
      var Map = json.decode(result);
      Status status = Status.fromJson(Map);
      if (status.code == Constants.success) {
        var companion = MyApartmentTableCompanion(
          onlineid: moor.Value(apartment.id),
          banner: moor.Value(apartment.banner),
          bannertag: moor.Value(apartment.bannertag),
          description: moor.Value(apartment.description),
          title: moor.Value(apartment.title),
          category: moor.Value(apartment.category),
          emailaddress: moor.Value(_emailController.text),
          location: moor.Value(_locationController.text),
          address: moor.Value(_addressController.text),
          phone: moor.Value(_phoneController.text),
          video: moor.Value(apartment.video),
          price: moor.Value(apartment.price),
          deposit: moor.Value(apartment.deposit),
          space: moor.Value(apartment.space),
          latitude: moor.Value(apartment.latitude),
          longitude: moor.Value(apartment.longitude),
          rating: moor.Value(apartment.rating),
          likes: moor.Value(apartment.likes),
          comments: moor.Value(apartment.comments),
          enabled: moor.Value(apartment.enabled),
          vacant: moor.Value(apartment.vacant),
        );
        dao.upsertApartment(companion);
        successDialog(context, status.message, showNeutralButton: true);
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
    var Map = json.decode(result);
    Status status = Status.fromJson(Map);
    if (status.code == Constants.success) {
      final _items = <MyFeaturesTableCompanion>[];
      features.forEach((feat) {
        var companion = MyFeaturesTableCompanion(
          onlineid: moor.Value(feat.id),
          apartment_id: moor.Value(feat.apartment_id),
          feat: moor.Value(feat.feat),
        );
        _items.add(companion);
      });
      dao.insertFeatures(_items);
      successDialog(context, status.message, showNeutralButton: true);
    } else {
      errorDialog(context, status.message, showNeutralButton: true);
    }
  }

  void deleteFeature(int index, var featId) async {
    var result = await NetworkApi().deleteFeature(featId);
    print(result);
    var Map = json.decode(result);
    Status status = Status.fromJson(Map);
    if (status.code == Constants.success) {
      successDialog(context, status.message, showNeutralButton: true);
      dao.deleteSingleFeature(featId);
      setState(() {
        features.removeAt(index);
      });
    } else {
      errorDialog(context, status.message, showNeutralButton: true);
    }
  }

  void insertFeature() async {
    var result = await NetworkApi()
        .insertFeature(apartment.id.toString(), _featController.text);
    var response = jsonDecode(result);
    print(result);
    if (response != Constants.fail) {
      var companion = MyFeaturesTableCompanion(
        onlineid: moor.Value(response),
        apartment_id: moor.Value(apartment.id),
        feat: moor.Value(_featController.text),
      );
      dao.upsertFeature(companion);
      Features feat = Features();
      feat.apartment_id = apartment.id;
      feat.feat = _featController.text;
      feat.id = response;
      setState(() {
        features.add(feat);
        _featController.text = '';
      });
      successDialog(context, "Success", showNeutralButton: true);
    } else {
      errorDialog(context, "Failed", showNeutralButton: true);
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
        categories.forEach((element) {
          if (element.title == apartment.category) {
            category = element;
          }
        });
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
