import 'dart:convert';
import 'dart:io';
import 'package:admin_keja/blocs/imagebloc.dart';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/database/dao.dart';
import 'package:admin_keja/database/databasehelper.dart';
import 'package:admin_keja/database/dboperations.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/apartment.dart';
import 'package:admin_keja/models/status.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/editPhotoViewer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:commons/commons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AllImages extends StatefulWidget {
  AllImages({Key key, this.apartmentId}) : super(key: key);
  var apartmentId;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AllImages> {
  final dbHelper = DbOperations.instance;
  var dao = DatabaseDao(databasehelper);
  ImagesBloc imageBloc;
  var apartmentId;
  Constants constants = Constants();
  final _tagController = TextEditingController();

  @override
  void initState() {
    super.initState();
    apartmentId = widget.apartmentId;
    imageBloc = ImagesBloc();
    imageBloc.fetchImages(apartmentId);
  }

  @override
  void dispose() {
    super.dispose();
    imageBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kDarkYellow,
        title: Text('Pictures'),
      ),
      body: StreamBuilder(
        stream: dao.watchImages(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.isNotEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('*Click on the tag to edit'),
                Expanded(
                  child: GridView.count(
                      padding: const EdgeInsets.all(8),
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                      children: List.generate(snapshot.data.length, (index) {
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
                                  CachedNetworkImage(
                                    imageUrl: constants.path +
                                        sharedPreferences.getCompanyId() +
                                        constants.folder +
                                        snapshot.data.elementAt(index).image,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) => Container(
                                        alignment: Alignment(0.0, 2.0),
                                        child: Center(
                                            child:
                                                CircularProgressIndicator())),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                            alignment: Alignment(0.0, 2.0),
                                            child: Center(
                                                child: Icon(Icons.error))),
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
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _tagController.text =
                                                  snapshot.data.elementAt(index).tag;
                                            });
                                            _showDialog(snapshot.data.elementAt(index).onlineid);
                                          },
                                          child: Text(
                                            snapshot.data.elementAt(index).tag,
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
                                      backgroundColor: LightColors.kLavender,
                                      child: IconButton(
                                        icon: Icon(Icons.edit),
                                        color: Colors.blue,
                                        onPressed: () {
                                          updateImage(
                                              snapshot.data.elementAt(index).image,
                                              snapshot.data.elementAt(index).onlineid,
                                              snapshot.data.elementAt(index).tag);
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
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('No data'),
            );
          } else if (snapshot.data != null && snapshot.data.isEmpty) {
            return Center(
              child: Text(''),
            );
          }
          return Center(
              child: Center(
            child: Container(
                height: 150.0,
                width: 150.0,
                child: Center(child: Text('loading'))),
          ));
        },
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
                var result = await NetworkApi()
                    .updateTag(_tagController.text, apartmentId, picId);
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

  void updateImage(var image, var picId, var tag) async {
    try {
      var tempImage = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);
      if (tempImage != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditPhotoViewer(
                  pic: File(tempImage.files.single.path),
                  tag: tag,
                  picId: picId,
                  apartmentId: apartmentId,
                )));
      }
    } on TargetPlatform catch (e) {
      print('Error while picking the file: ' + e.toString());
    }
  }
}
