import 'dart:convert';
import 'dart:io';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/database/dboperations.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/apartment.dart';
import 'package:admin_keja/models/features.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/allImages.dart';
import 'package:admin_keja/ui/editApartment.dart';
import 'package:admin_keja/ui/editPhotoViewer.dart';
import 'package:admin_keja/ui/map.dart';
import 'package:admin_keja/utility/connectioncallback.dart';
import 'package:admin_keja/models/locations.dart' as locations;
import 'package:admin_keja/utility/utility.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  Constants constants = Constants();
  final List<String> picList = [];
  final List<String> imageTags = [];
  final List<String> featurelist = [];
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
          Center(
            child: apartmentDetails(apartment),
          ),
          Container(
            height: 300,
            child: picList != null && picList.isNotEmpty
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: GridView.count(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            crossAxisCount: 3,
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
                                        picList.elementAt(index) == null ||
                                                picList.elementAt(index).isEmpty
                                            ? Container(
                                                color: Colors.black87,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ))
                                            : Image.memory(
                                                Utility.dataFromBase64String(
                                                    picList.elementAt(index)),
                                                //height: 150,
                                                fit: BoxFit.cover,
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
                                                ? Text(
                                                    imageTags.elementAt(index),
                                                    style: TextStyle(
                                                      color: Colors.white,
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
                                            backgroundColor: Colors.white,
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
                              style: TextStyle(color: Colors.blue,),
                            ),
                          ))
                    ],
                  )
                : Container(
                    height: 150.0,
                    width: 150.0,
                    child: Center(child: Text('loading'))),
          ),
          Container(
            padding: EdgeInsets.all(5),
            //height: 200,
            child: Column(
              children: <Widget>[
                Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Text('Features')),
                    CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  icon: Icon(Icons.edit),
                                  color: Colors.blue,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
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
                          children:
                              List.generate(featurelist.length, (index) {
                            return featuresCard(
                                featurelist.elementAt(index));
                          }),
                        ),
                      )
                    : Container(
                        child: Center(
                          child: CircularProgressIndicator(),
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
                        Center(child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: Text('More Details')),
                            CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  icon: Icon(Icons.edit),
                                  color: Colors.blue,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
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
          ConnectionCallback(
            onlineCall: () {},
          ),
        ],
      ),
    );
  }

  void fetchImages() async {
    var result = await NetworkApi().getImages(apartmentId);
    print(result);
    var Map = json.decode(result);
    _insertImages(Images.fromJson(Map));
  }

  void fetchTags() async {
    var result = await NetworkApi().getTags(apartmentId);
    print(result);
    var Map = json.decode(result);
    _insertTags(Tags.fromJson(Map));
  }

  void fetchFeatures() async {
    var result = await NetworkApi().getFeatures(apartmentId);
    print(result);
    var Map = json.decode(result);
    _insertFeatures(Features.fromJson(Map));
  }

  void populateTagList(Tags tags) {
    setState(() {
      imageTags.add(tags.tag0);
      imageTags.add(tags.tag1);
      imageTags.add(tags.tag2);
      imageTags.add(tags.tag3);
      imageTags.add(tags.tag4);
      imageTags.add(tags.tag5);
      imageTags.add(tags.tag6);
      imageTags.add(tags.tag7);
      imageTags.add(tags.tag8);
      imageTags.add(tags.tag9);
      imageTags.add(tags.tag10);
      imageTags.add(tags.tag11);
      imageTags.add(tags.tag12);
      imageTags.add(tags.tag13);
      imageTags.add(tags.tag14);
      imageTags.add(tags.tag15);
    });
  }

  void updateTagList(Tags tags) {
    setState(() {
      imageTags.clear();
      imageTags.add(tags.tag0);
      imageTags.add(tags.tag1);
      imageTags.add(tags.tag2);
      imageTags.add(tags.tag3);
      imageTags.add(tags.tag4);
      imageTags.add(tags.tag5);
      imageTags.add(tags.tag6);
      imageTags.add(tags.tag7);
      imageTags.add(tags.tag8);
      imageTags.add(tags.tag9);
      imageTags.add(tags.tag10);
      imageTags.add(tags.tag11);
      imageTags.add(tags.tag12);
      imageTags.add(tags.tag13);
      imageTags.add(tags.tag14);
      imageTags.add(tags.tag15);
    });
  }

  void populateImageList(var index, var val) {
    setState(() {
      picList.insert(index, val);
    });
  }

  void updateImageList(var index, var val) {
    setState(() {
      if (!picList.contains(val)) {
        if (index < picList.length) {
          picList.removeAt(index);
          picList.insert(index, val);
        } else if(picList.length<=6) {
          picList.insert(index, val);
        }
      }
    });
  }

  void populateFeaturesList(Features features) {
    if (features != null) {
      featurelist.clear();
      setState(() {
        featurelist.add(features.feat0);
        featurelist.add(features.feat1);
        featurelist.add(features.feat2);
        featurelist.add(features.feat3);
        featurelist.add(features.feat4);
        featurelist.add(features.feat5);
        featurelist.add(features.feat6);
        featurelist.add(features.feat7);
        featurelist.add(features.feat8);
        featurelist.add(features.feat9);
        featurelist.add(features.feat10);
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
              backgroundColor: Colors.white,
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

  void _insertImages(Images images) async {
    Images image = Images();
    image.id = images.id;
    image.apartment_id = images.apartment_id;

    final id = await dbHelper.insertImages(image);
    print('inserted row id: $id');
    Utility.base64String(
            constants.path + companyId + constants.folder + images.image0)
        .then((value) async => {
              await dbHelper
                  .updateImage('image0', images.apartment_id, value)
                  .then((value) async => {
                        await dbHelper
                            .fetchSingleImage('image0', apartmentId)
                            .then((value) => {updateImageList(0, value)})
                      }),
            });

    Utility.base64String(
            constants.path + companyId + constants.folder + images.image1)
        .then((value) async => {
              await dbHelper
                  .updateImage('image1', images.apartment_id, value)
                  .then((value) async => {
                        await dbHelper
                            .fetchSingleImage('image1', apartmentId)
                            .then((value) => {updateImageList(1, value)})
                      }),
            });

    Utility.base64String(
            constants.path + companyId + constants.folder + images.image2)
        .then((value) async => {
              await dbHelper
                  .updateImage('image2', images.apartment_id, value)
                  .then((value) async => {
                        await dbHelper
                            .fetchSingleImage('image2', apartmentId)
                            .then((value) => {updateImageList(2, value)})
                      }),
            });

    Utility.base64String(
            constants.path + companyId + constants.folder + images.image3)
        .then((value) async => {
              await dbHelper
                  .updateImage('image3', images.apartment_id, value)
                  .then((value) async => {
                        await dbHelper
                            .fetchSingleImage('image3', apartmentId)
                            .then((value) => {updateImageList(3, value)})
                      }),
            });

    Utility.base64String(
            constants.path + companyId + constants.folder + images.image4)
        .then((value) async => {
              await dbHelper
                  .updateImage('image4', images.apartment_id, value)
                  .then((value) async => {
                        await dbHelper
                            .fetchSingleImage('image4', apartmentId)
                            .then((value) => {updateImageList(4, value)})
                      }),
            });

    Utility.base64String(
            constants.path + companyId + constants.folder + images.image5)
        .then((value) async => {
              await dbHelper
                  .updateImage('image5', images.apartment_id, value)
                  .then((value) async => {
                        await dbHelper
                            .fetchSingleImage('image5', apartmentId)
                            .then((value) => {updateImageList(5, value)})
                      }),
            });

    Utility.base64String(
            constants.path + companyId + constants.folder + images.image6)
        .then((value) async =>
            {await dbHelper.updateImage('image6', images.apartment_id, value)});

    Utility.base64String(
            constants.path + companyId + constants.folder + images.image7)
        .then((value) async =>
            {await dbHelper.updateImage('image7', images.apartment_id, value)});

    Utility.base64String(
            constants.path + companyId + constants.folder + images.image8)
        .then((value) async =>
            {await dbHelper.updateImage('image8', images.apartment_id, value)});

    Utility.base64String(
            constants.path + companyId + constants.folder + images.image9)
        .then((value) async =>
            {await dbHelper.updateImage('image9', images.apartment_id, value)});

    Utility.base64String(
            constants.path + companyId + constants.folder + images.image10)
        .then((value) async => {
              await dbHelper.updateImage('image10', images.apartment_id, value)
            });

    Utility.base64String(
            constants.path + companyId + constants.folder + images.image11)
        .then((value) async => {
              await dbHelper.updateImage('image11', images.apartment_id, value)
            });

    Utility.base64String(
            constants.path + companyId + constants.folder + images.image12)
        .then((value) async => {
              await dbHelper.updateImage('image12', images.apartment_id, value)
            });

    Utility.base64String(
            constants.path + companyId + constants.folder + images.image13)
        .then((value) async => {
              await dbHelper.updateImage('image13', images.apartment_id, value)
            });

    Utility.base64String(
            constants.path + companyId + constants.folder + images.image14)
        .then((value) async => {
              await dbHelper.updateImage('image14', images.apartment_id, value)
            });

    Utility.base64String(
            constants.path + companyId + constants.folder + images.image15)
        .then((value) async => {
              await dbHelper.updateImage('image15', images.apartment_id, value),
            });
  }

  Future<void> fetchDbImages() async {
    await dbHelper
        .fetchSingleImage('image0', apartmentId)
        .then((value) => {populateImageList(0, value)});
    await dbHelper
        .fetchSingleImage('image1', apartmentId)
        .then((value) => {populateImageList(1, value)});
    await dbHelper
        .fetchSingleImage('image2', apartmentId)
        .then((value) => {populateImageList(2, value)});
    await dbHelper
        .fetchSingleImage('image3', apartmentId)
        .then((value) => {populateImageList(3, value)});
    await dbHelper
        .fetchSingleImage('image4', apartmentId)
        .then((value) => {populateImageList(4, value)});
    await dbHelper
        .fetchSingleImage('image5', apartmentId)
        .then((value) => {populateImageList(5, value)});
  }

  void _insertTags(Tags tags) async {
    final id =
        await dbHelper.insertTags(tags).then((value) => {updateTagList(value)});
    print('inserted row id: $id');
  }

  Future<void> fetchDbTags() async {
    return await dbHelper.fetchTags(apartmentId).then((value) => {
          if (value != null) {populateTagList(value)}
        });
  }

  void _insertFeatures(Features features) async {
    final id = await dbHelper.insertFeatures(features);
    print('inserted row id: $id');
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
        type: FileType.custom,allowedExtensions: ['jpg', 'png', 'jpeg']
      );
      if (tempImage != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditPhotoViewer(
                  pic: File(tempImage.files.single.path),
                  tag: imageTags.elementAt(index),
                  index: index,
                  apartmentId: apartmentId,
                )));
      }
    } on TargetPlatform catch (e) {
      print('Error while picking the file: ' + e.toString());
    }
  }
}
