import 'dart:convert';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/apartment.dart';
import 'package:admin_keja/models/category.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/views/textfield.dart';
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
  final List<String> features;
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
    getApartmentLocation();
    initData(apartment);
    
  }

  @override
  void dispose() {
    super.dispose();
  }

  MyApartment apartment = MyApartment();
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
      //key: _scaffoldKey,
      appBar: AppBar(
        title: Text(apartment.title),
        backgroundColor: LightColors.kDarkYellow,
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
                    if (_step1Key.currentState.validate()) {
                      setState(() {
                        step = 1;
                      });
                    }
                  },
                ),
              )
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
                    child: Text('next'),
                  ),
                  onPressed: () {
                    if (_step2Key.currentState.validate()) {
                      setState(() {
                        step = 2;
                      });
                    }
                  },
                ),
              )
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
                  features.add(_featController.text);
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
                () => features.insert(index, deletedItem),
              )),
    );
  }

  SnackBar snack(String message) {
    return SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 500),
    );
  }

  Container locationMap() {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                style: BorderStyle.solid, width: 2, color: Colors.blueGrey),
            color: Colors.transparent),
        child: location == false
            ? Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    child: Center(
                      child: isloading
                          ? CircularProgressIndicator()
                          : IconButton(
                              icon: Icon(Icons.location_on),
                              onPressed: () {
                                setState(() {
                                  isloading = true;
                                });
                                getApartmentLocation();
                              },
                            ),
                    ),
                  ),
                  Text(
                      'Add location..You should be at location of site for correct coordinates')
                ],
              )
            : Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(latitude, longitude),
                        zoom: 2,
                      ),
                      markers: _markers.values.toSet(),
                    ),
                  ),
                ],
              ));
  }

  Future<Position> locateApartment() async {
    return geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void getApartmentLocation() async {
    currentLocation = await locateApartment();
    setState(() {
      latitude = currentLocation.latitude;
      longitude = currentLocation.longitude;
      location = true;
    });
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
  }

  void submitStep4() async {
    var result = await NetworkApi()
        .updateFeatures(sharedPreferences.getCompanyId(), features);
    print(result);
  }

  Future<void> getCategory() async {
    var result = await NetworkApi().fetchCategorys();
    print(result);
    var Map = json.decode(result);
    setState(() {
      var response = CategoryResponse.fromJson(Map);
      categories = response.data.categorys;
    });
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
