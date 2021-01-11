import 'dart:convert';
import 'dart:io';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/database/dboperations.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/apartment.dart';
import 'package:admin_keja/models/features.dart';
import 'package:admin_keja/models/status.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/allImages.dart';
import 'package:admin_keja/ui/editApartment.dart';
import 'package:admin_keja/ui/editPhotoViewer.dart';
import 'package:admin_keja/ui/map.dart';
import 'package:admin_keja/utility/connectioncallback.dart';
import 'package:admin_keja/models/locations.dart' as locations;
import 'package:admin_keja/utility/utility.dart';
import 'package:commons/commons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ApartmentDetails extends StatefulWidget {
  ApartmentDetails({Key key, @required this.apartment}) : super(key: key);
  MyApartment apartment;

  final String title = 'apartmentDetails';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ApartmentDetails> {
  final dbHelper = DbOperations.instance;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String userId;
  int step;
  String apartmentId, companyId;
  MyApartment apartment;
  final _tagController = TextEditingController();
  Constants constants = Constants();
  List<Images> picList = [];
  List<Tags> imageTags = [];
  List<Features> featurelist = [];
  final Map<String, Marker> _markers = {};
  var features;

  @override
  void initState() {
    apartment = widget.apartment;
    apartmentId = widget.apartment.id;
    getPrefs();
    fetchImages();
    fetchFeatures();
    fetchTags();
    fetchDbTags();
    fetchDbImages();
    fetchDbFeatures();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: LightColors.kDarkYellow,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(apartment.title + ' Apartments'),
      ),
      body: ListView(
        //shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ConnectionCallback(
            onlineCall: () {},
          ),
          Center(
            child: apartmentDetails(apartment),
          ),
          Center(child:Container(
            height: 200,
            child: Stack(
                                        fit: StackFit.expand,
                                        children: <Widget>[
                                        apartment.banner==
                                                      null ||
                                                  apartment.banner
                                                      .isEmpty
                                              ? Image.asset(
                                                  'assets/images/placeholder.png')
                                              : Container(
                                                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                                child: Image.memory(
                                                    Utility.dataFromBase64String(apartment.banner),
                                                    fit: BoxFit.fill,
                                                  ),
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
                                                  vertical: 10.0,
                                                  horizontal: 20.0),
                                              child: apartment.bannertag != null &&
                                                      apartment.bannertag.isNotEmpty
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _tagController.text =
                                                              apartment.bannertag;
                                                        });
                                                        _showBannerDialog(apartment.bannertag);
                                                      },
                                                      child: Text(
                                                        apartment.bannertag,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )
                                                  : Text(''),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor:
                                                  LightColors.kLavender,
                                              child: IconButton(
                                                icon: Icon(Icons.edit),
                                                color: Colors.blue,
                                                onPressed: () {
                                                  updateBannerImage();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
          ),
                                  ),
          Container(
            height: 350,
            child: picList != null && picList.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('*Click on the tag to edit'),
                      Expanded(
                        child: GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(8),
                            crossAxisCount: 3,
                            childAspectRatio: 0.7,
                            children: List.generate(picList.length, (index) {
                              return Container(
                                margin: EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        picList.elementAt(index).image ==
                                                    null ||
                                                picList
                                                    .elementAt(index)
                                                    .image
                                                    .isEmpty
                                            ? Image.asset(
                                                'assets/images/placeholder.png')
                                            : Image.memory(
                                                Utility.dataFromBase64String(
                                                    picList
                                                        .elementAt(index)
                                                        .image),
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
                                                vertical: 10.0,
                                                horizontal: 20.0),
                                            child: imageTags != null &&
                                                    imageTags.isNotEmpty
                                                ? GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _tagController.text =
                                                            getTag(index);
                                                      });
                                                      _showDialog(index);
                                                    },
                                                    child: Text(
                                                      getTag(index),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                : Text(''),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 120,
                                          left: 70,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                LightColors.kLavender,
                                            child: IconButton(
                                              icon: Icon(Icons.edit),
                                              color: Colors.blue,
                                              onPressed: () {
                                                updateImage(index);
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllImages(
                                          apartmentId: apartmentId,
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'view all',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ))
                    ],
                  )
                : Center(
                  child: Container(
                      height: 150.0,
                      width: 150.0,
                      child: Center(child: Text('loading'))),
                ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            //height: 200,
            child: Column(
              children: <Widget>[
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Text('Features')),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: LightColors.kLavender,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditApartment(
                                    apartment: apartment,
                                    features: featurelist,
                                    step: 3,
                                  )));
                        },
                      ),
                    ),
                  ],
                )),
                featurelist.isNotEmpty
                    ? Center(
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 6.0,
                          scrollDirection: Axis.vertical,
                          children: List.generate(featurelist.length, (index) {
                            return featuresCard(
                                featurelist.elementAt(index).feat);
                          }),
                        ),
                      )
                    : Container(
                        child: Center(
                          child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator()),
                        ),
                      ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Container(
              child: Column(
                children: <Widget>[
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Text('More Details')),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: LightColors.kLavender,
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditApartment(
                                      apartment: apartment,
                                      features: featurelist,
                                      step: 1,
                                    )));
                          },
                        ),
                      ),
                    ],
                  )),
                  ListTile(
                    title: Text('Phone'),
                    leading: Icon(Icons.call),
                    subtitle: Text(apartment.phone),
                  ),
                  ListTile(
                    title: Text('Email'),
                    leading: Icon(Icons.email),
                    subtitle: Text(apartment.email),
                  ),
                  ListTile(
                    title: Text('Address'),
                    leading: Icon(Icons.account_box),
                    subtitle:
                        Text(apartment.address + '\n' + apartment.location),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void fetchImages() async {
    var result = await NetworkApi().getImages(apartmentId);
    print(result);
    var Map = json.decode(result);
    _insertImages(ImagesResponse.fromJson(Map).data.data)
        .then((value) => {fetchDbImages()});
  }

  void fetchTags() async {
    var result = await NetworkApi().getTags(apartmentId);
    print(result);
    var Map = json.decode(result);
    _insertTags(TagsResponse.fromJson(Map).data.data);
  }

  void fetchFeatures() async {
    var result = await NetworkApi().getFeatures(apartmentId);
    print(result);
    var Map = json.decode(result);
    _insertFeatures(FeaturesResponse.fromJson(Map).data.data);
  }

  void populateTagList(var tags) {
    if (mounted && tags != null) {
      imageTags.clear();
      setState(() {
        imageTags = tags;
      });
    }
  }

  void populateImageList(var val) {
    if (mounted) {
      setState(() {
        picList = val;
      });
    }
  }

  String getTag(int imageIndex) {
    var tag = '';
    imageTags.forEach((element) {
      if (element.image_id == picList.elementAt(imageIndex).id) {
        tag = element.tag;
      }
    });
    return tag;
  }

  void updateImageList(var index, var val) {
    setState(() {
      if (!picList.contains(val)) {
        if (index < picList.length) {
          picList.removeAt(index);
          picList.insert(index, val);
        } else if (picList.length <= 6) {
          picList.insert(index, val);
        }
      }
    });
  }

  void populateFeaturesList(var features) {
    if (mounted && features != null) {
      featurelist.clear();
      setState(() {
        featurelist = features;
      });
    }
  }

  SnackBar snack(String message) {
    return SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 500),
    );
  }

  Row featuresCard(var feature) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.star,
          size: 13,
          color: Colors.lightBlueAccent,
        ),
        Flexible(
          child: Text(
            feature,
            overflow: TextOverflow.visible,
            softWrap: true,
            style: TextStyle(
              color: Colors.lightBlueAccent,
            ),
          ),
        )
      ],
    );
  }

  Container apartmentDetails(MyApartment apartment) {
    return Container(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            padding: EdgeInsets.all(10),
            color: Colors.orangeAccent,
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Category: ' + apartment.category,
                        style: TextStyle(color: Colors.white)),
                    Text(
                      'Rent: ' + apartment.price,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Deposit fee: ' + apartment.deposit,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Units: ' + apartment.space,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 5,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: LightColors.kLavender,
              child: IconButton(
                icon: Icon(Icons.edit),
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditApartment(
                            apartment: apartment,
                            step: 0,
                          )));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getPrefs() {
    userId = sharedPreferences.getUserId();
    companyId = sharedPreferences.getCompanyId();
  }

  _showDialog(var index) async {
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
                controller: _tagController,
                autofocus: true,
                decoration: InputDecoration(labelText: 'Tag'),
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
              onPressed: () async {
                var result = await NetworkApi().updateTag(_tagController.text,
                    apartmentId, picList.elementAt(index).id);
                print(result);
                var Map = json.decode(result);
                Status status = Status.fromJson(Map);
                Navigator.pop(context);
                if (status.code == Constants.success) {
                  infoDialog(context, status.message, showNeutralButton: true);
                } else {
                  errorDialog(context, status.message, showNeutralButton: true);
                }
              })
        ],
      ),
    );
  }
  _showBannerDialog(var tag) async {
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
                controller: _tagController,
                autofocus: true,
                decoration: InputDecoration(labelText: 'Tag'),
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
              onPressed: () async {
                var result = await NetworkApi().updateBannerTag(_tagController.text,
                    apartmentId);
                print(result);
                var Map = json.decode(result);
                Status status = Status.fromJson(Map);
                Navigator.pop(context);
                if (status.code == Constants.success) {
                  infoDialog(context, status.message, showNeutralButton: true);
                } else {
                  errorDialog(context, status.message, showNeutralButton: true);
                }
              })
        ],
      ),
    );
  }
  Future<void> _insertImages(List<Images> images) async {
    if (images != null) {
      Images image = Images();
      var res = await Future.wait(images.map((element) async {
        Utility.base64String(
                constants.path + companyId + constants.folder + element.image)
            .then((value) async => {
                  image.id = element.id,
                  image.image = value,
                  image.apartment_id = element.apartment_id,
                  await dbHelper
                      .insertImages(image)
                      .then((value) => {fetchDbImages()}),
                });
      }));
      if (res != null) {
        fetchDbImages();
      }
    }
  }

  Future<void> fetchDbImages() async {
    await dbHelper
        .fetchDetailsImages(apartmentId)
        .then((value) => {populateImageList(value)});
  }

  void _insertTags(List<Tags> tags) async {
    for (int i = 0; i < tags.length; i++) {
      Tags tag = Tags();
      tag.id = tags.elementAt(i).id;
      tag.tag = tags.elementAt(i).tag;
      tag.image_id = tags.elementAt(i).image_id;
      tag.apartment_id = tags.elementAt(i).apartment_id;
      final id = await dbHelper.insertTags(tag);
      print('inserted row id: $id');
    }
    fetchDbTags();
  }

  Future<void> fetchDbTags() async {
    return await dbHelper.fetchTags(apartmentId).then((value) => {
          if (value != null) {populateTagList(value)}
        });
  }

  void _insertFeatures(List<Features> features) async {
    for (int i = 0; i < features.length; i++) {
      Features feat = Features();
      feat.id = features.elementAt(i).id;
      feat.feat = features.elementAt(i).feat;
      feat.apartment_id = features.elementAt(i).apartment_id;
      final id = await dbHelper.insertFeatures(feat);
      print('inserted row id: $id');
    }
    fetchDbFeatures();
  }

  Future<void> fetchDbFeatures() async {
    return await dbHelper
        .fetchFeatures(apartmentId)
        .then((value) => {populateFeaturesList(value)});
  }

  void updateImage(var index) async {
    try {
      var tempImage = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);
      if (tempImage != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditPhotoViewer(
                  pic: File(tempImage.files.single.path),
                  tag: getTag(index),
                  picId: picList.elementAt(index).id,
                  apartmentId: apartmentId,
                )));
      }
    } on TargetPlatform catch (e) {
      print('Error while picking the file: ' + e.toString());
    }
  }
    void updateBannerImage() async {
    try {
      var tempImage = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);
      if (tempImage != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditPhotoViewer(
                  pic: File(tempImage.files.single.path),
                  tag: apartment.bannertag,
                  picId: '-1',
                  apartmentId: apartmentId,
                )));
      }
    } on TargetPlatform catch (e) {
      print('Error while picking the file: ' + e.toString());
    }
  }
}
