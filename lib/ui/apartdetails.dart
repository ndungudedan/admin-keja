import 'dart:convert';
import 'dart:io';
import 'package:admin_keja/blocs/featurebloc.dart';
import 'package:admin_keja/blocs/imagebloc.dart';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/database/dao.dart';
import 'package:admin_keja/database/databasehelper.dart';
import 'package:admin_keja/database/dboperations.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/status.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/allImages.dart';
import 'package:admin_keja/ui/editApartment.dart';
import 'package:admin_keja/ui/editPhotoViewer.dart';
import 'package:admin_keja/utility/connectioncallback.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:commons/commons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moor/moor.dart' as moor;

class ApartmentDetails extends StatefulWidget {
  ApartmentDetails({Key key, @required this.apartmentId}) : super(key: key);
  var apartmentId;

  final String title = 'apartmentDetails';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ApartmentDetails> {
  final dbHelper = DbOperations.instance;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var dao = DatabaseDao(databasehelper);
  FeatureBloc featureBloc;
  ImagesBloc imageBloc;
  int step;
  String apartmentId;
  MyApartmentTableData apartment;
  MyImagesTableData imagesTableData;
  final _tagController = TextEditingController();
  Constants constants = Constants();
  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    apartmentId = widget.apartmentId;
    featureBloc = FeatureBloc();
    imageBloc = ImagesBloc();
    featureBloc.fetchFeatures(apartmentId);
    imageBloc.fetchImages(apartmentId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    featureBloc.dispose();
    imageBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: dao.watchSingleApartment(apartmentId),
        builder: (context, snapshot) {
          apartment = snapshot.data;
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
              actions: [
                Switch(
                    value: apartment.enabled,
                    onChanged: (value) {
                      updateEnabled(value);
                    })
              ],
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
                Center(
                  child: Container(
                    height: 200,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: constants.path +
                              sharedPreferences.getCompanyId() +
                              constants.folder +
                              apartment.banner,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                              height: 200,
                              alignment: Alignment(0.0, 2.0),
                              child:
                                  Center(child: CircularProgressIndicator())),
                          errorWidget: (context, url, error) => Container(
                              alignment: Alignment(0.0, 2.0),
                              height: 200,
                              child: Center(child: Icon(Icons.error))),
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
                            backgroundColor: LightColors.kLavender,
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
                StreamBuilder(
                  stream: dao.watchImagesLimit(apartment.onlineid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data.isNotEmpty) {
                      return Container(
                        height: snapshot.data.length <= 3 ? 240 : 400,
                        child: Column(
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
                                  children: List.generate(snapshot.data.length,
                                      (index) {
                                    return Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: <Widget>[
                                              CachedNetworkImage(
                                                imageUrl: constants.path +
                                                    sharedPreferences
                                                        .getCompanyId() +
                                                    constants.folder +
                                                    snapshot.data
                                                        .elementAt(index)
                                                        .image,
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) =>
                                                    Container(
                                                        alignment:
                                                            Alignment(0.0, 2.0),
                                                        child: Center(
                                                            child:
                                                                CircularProgressIndicator())),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Container(
                                                        alignment:
                                                            Alignment(0.0, 2.0),
                                                        child: Center(
                                                            child: Icon(
                                                                Icons.error))),
                                              ),
                                              Positioned(
                                                bottom: 1.0,
                                                left: 0.0,
                                                right: 0.0,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color.fromARGB(
                                                              200, 0, 0, 0),
                                                          Color.fromARGB(
                                                              0, 0, 0, 0)
                                                        ],
                                                        begin: Alignment
                                                            .bottomCenter,
                                                        end:
                                                            Alignment.topCenter,
                                                      ),
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.0,
                                                            horizontal: 20.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _tagController.text =
                                                              snapshot.data
                                                                  .elementAt(
                                                                      index)
                                                                  .tag;
                                                          imagesTableData =
                                                              snapshot
                                                                  .data
                                                                  .elementAt(
                                                                      index);
                                                        });
                                                        _showDialog(snapshot
                                                            .data
                                                            .elementAt(index)
                                                            .onlineid);
                                                      },
                                                      child: Text(
                                                        snapshot.data
                                                            .elementAt(index)
                                                            .tag,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )),
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
                                                      setState(() {
                                                        imagesTableData =
                                                            snapshot
                                                                .data
                                                                .elementAt(
                                                                    index);
                                                      });
                                                      updateImage(
                                                          snapshot.data
                                                              .elementAt(index)
                                                              .image,
                                                          snapshot.data
                                                              .elementAt(index)
                                                              .onlineid,
                                                          snapshot.data
                                                              .elementAt(index)
                                                              .tag);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            snapshot.data.length>3 ?  Positioned(
                                                bottom: 120,
                                                right: 70,
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      LightColors.kLavender,
                                                  child: IconButton(
                                                    icon: Icon(Icons.close),
                                                    color: Colors.red,
                                                    onPressed: () {
                                                      deleteImage(
                                                          snapshot.data
                                                              .elementAt(index)
                                                              .onlineid,
                                                          snapshot.data
                                                              .elementAt(index)
                                                              .image);
                                                    },
                                                  ),
                                                ),
                                              )
                                              :SizedBox()
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(),
                                      SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: FloatingActionButton(
                                            child: Icon(
                                              Icons.add,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            backgroundColor: Colors.deepOrange,
                                            onPressed: () {
                                              addImage();
                                            }),
                                      ),
                                      Text(
                                        'view all',
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                        height: 10,
                        child: Center(
                          child: Text('No data'),
                        ),
                      );
                    } else if (snapshot.data != null && snapshot.data.isEmpty) {
                      return Container(
                        height: 10,
                        child: Center(
                          child: Text(''),
                        ),
                      );
                    }
                    return Container(
                        height: 150.0,
                        width: 150.0,
                        child: Center(child: Text('loading')));
                  },
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  //height: 200,
                  child: StreamBuilder(
                    stream: dao.watchFeatures(apartment.onlineid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data.isNotEmpty) {
                        return Column(
                          children: [
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
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditApartment(
                                                    apartment: apartment,
                                                    features: snapshot.data,
                                                    step: 3,
                                                  )));
                                    },
                                  ),
                                ),
                              ],
                            )),
                            GridView.count(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              childAspectRatio: 6.0,
                              scrollDirection: Axis.vertical,
                              children:
                                  List.generate(snapshot.data.length, (index) {
                                return featuresCard(
                                    snapshot.data.elementAt(index).feat);
                              }),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('No data'),
                        );
                      } else if (snapshot.data != null &&
                          snapshot.data.isEmpty) {
                        return Center(
                          child: Text(''),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
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
                          subtitle: Text(apartment.emailaddress),
                        ),
                        ListTile(
                          title: Text('Address'),
                          leading: Icon(Icons.account_box),
                          subtitle: Text(
                              apartment.address + '\n' + apartment.location),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  SnackBar snack(String message) {
    return SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 500),
    );
  }

  Row featuresCard(var feature) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.star,
          size: 13,
          color: Colors.lightBlueAccent,
        ),
        Expanded(
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

  Container apartmentDetails(var apartment) {
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

  _showDialog(var picId) async {
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
                Navigator.pop(context);
                var result = await NetworkApi()
                    .updateTag(_tagController.text, apartmentId, picId);
                print(result);
                var Map = json.decode(result);
                Status status = Status.fromJson(Map);
                if (status.code == Constants.success) {
                  var companion = MyImagesTableCompanion(
                    onlineid: moor.Value(imagesTableData.onlineid),
                    apartment_id: moor.Value(imagesTableData.apartment_id),
                    tag: moor.Value(_tagController.text),
                    tag_id: moor.Value(imagesTableData.tag_id),
                    image: moor.Value(imagesTableData.image),
                  );
                  dao.upsertImage(companion);
                  successDialog(context, status.message,
                      showNeutralButton: true);
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
                Navigator.pop(context);
                var result = await NetworkApi()
                    .updateBannerTag(_tagController.text, apartmentId);
                print(result);
                var Map = json.decode(result);
                Status status = Status.fromJson(Map);

                if (status.code == Constants.success) {
                  var companion = MyApartmentTableCompanion(
                    onlineid: moor.Value(apartment.onlineid),
                    banner: moor.Value(apartment.banner),
                    bannertag: moor.Value(_tagController.text),
                    description: moor.Value(apartment.description),
                    title: moor.Value(apartment.title),
                    category: moor.Value(apartment.category),
                    emailaddress: moor.Value(apartment.emailaddress),
                    location: moor.Value(apartment.location),
                    address: moor.Value(apartment.address),
                    phone: moor.Value(apartment.phone),
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
                  successDialog(context, status.message,
                      showNeutralButton: true);
                } else {
                  errorDialog(context, status.message, showNeutralButton: true);
                }
              })
        ],
      ),
    );
  }

  void updateImage(var image, var picId, var tag) async {
    try {
      var tempImage = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);
      if (tempImage != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditPhotoViewer(
                  pic: File(tempImage.files.single.path),
                  myImagesTableData: imagesTableData,
                  tag: tag,
                  picId: picId,
                  apartmentId: apartmentId,
                )));
      }
    } on TargetPlatform catch (e) {
      print('Error while picking the file: ' + e.toString());
    }
  }

  Future<void> deleteImage(var id, var image) async {
    var result = await NetworkApi().deleteImage(id, image);
    print(result);
    var Map = json.decode(result);
    Status status = Status.fromJson(Map);

    if (status.code == Constants.success) {
      dao.deleteImage(id);
      successDialog(context, status.message, showNeutralButton: true);
    } else {
      errorDialog(context, status.message, showNeutralButton: true);
    }
  }

  Future<void> addImage() async {
    try {
      var tempImage = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);
      if (tempImage != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditPhotoViewer(
                  pic: File(tempImage.files.single.path),
                  myImagesTableData: null,
                  tag: 'tag',
                  picId: '-2',
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
        File temp = File(tempImage.files.single.path);
        var decodedImage = await decodeImageFromList(temp.readAsBytesSync());
        print(decodedImage.width);
        print(decodedImage.height);
        if (decodedImage.width >= Constants.bannerWidth &&
            decodedImage.height >= Constants.bannerHeight) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EditPhotoViewer(
                    pic: File(tempImage.files.single.path),
                    tag: apartment.bannertag,
                    picId: '-1',
                    apartmentId: apartmentId,
                    apartment: apartment,
                  )));
        } else {
          errorDialog(
              context,
              "Min width: " +
                  Constants.bannerWidth.toString() +
                  "\nMin height: " +
                  Constants.bannerHeight.toString(),
              showNeutralButton: true);
        }
      }
    } on TargetPlatform catch (e) {
      print('Error while picking the file: ' + e.toString());
    }
  }

  Future<void> updateEnabled(bool enabled) async {
    var result = await NetworkApi().updateEnabled(enabled, apartmentId);
    print(result);
    var Map = json.decode(result);
    Status status = Status.fromJson(Map);
    if (status.code == Constants.success) {
      dao.updateEnabled(enabled, apartmentId);
      successDialog(context, status.message);
    } else {
      errorDialog(context, status.message);
    }
  }
}
