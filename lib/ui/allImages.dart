import 'dart:io';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/database/dboperations.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/apartment.dart';
import 'package:admin_keja/models/company.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/editPhotoViewer.dart';
import 'package:admin_keja/utility/utility.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AllImages extends StatefulWidget {
  AllImages({Key key, this.apartmentId, this.company}) : super(key: key);
  MyCompany company;
  var apartmentId;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AllImages> {
  final dbHelper = DbOperations.instance;
  List<Images> picList = [];
  List<Tags> imageTags = [];
  var apartmentId, userId, companyId;
  Constants constants = Constants();

  @override
  void initState() {
    super.initState();
    apartmentId = widget.apartmentId;
    getPrefs();
    fetchDbImages();
    fetchDbTags();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: LightColors.kDarkYellow,
          title: Text('Pictures'),
        ),
        body: Container(
          child: GridView.count(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(8),
              crossAxisCount: 2,
              children: List.generate(picList.length, (index) {
                return Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: GestureDetector(
                      onTap: () {},
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          picList.elementAt(index) == null ||
                                  picList.elementAt(index).image.isEmpty
                              ? Image.asset('assets/images/placeholder.png')
                              : Image.memory(
                                  Utility.dataFromBase64String(
                                      picList.elementAt(index).image),
                                  height: 150.0,
                                  width: 150.0,
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
                                  vertical: 10.0, horizontal: 20.0),
                              child: imageTags != null && imageTags.isNotEmpty
                                  ? Text(
                                      getTag(index),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(''),
                            ),
                          ),
                          Positioned(
                            bottom: 130,
                            left: 130,
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
        ));
  }

  void getPrefs() {
    userId = sharedPreferences.getUserId();
    companyId = sharedPreferences.getCompanyId();
  }

  void updateImage(var index) async {
    try {
      var tempImage = await FilePicker.platform.pickFiles(type: FileType.custom, 
      allowedExtensions: ['jpg', 'png', 'jpeg']);
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

  void populateImageList(var val) {
    setState(() {
      picList = val;
    });
  }

  void populateTagList(var tags) {
    if (tags != null) {
      imageTags.clear();
      setState(() {
        imageTags = tags;
      });
    }
  }

  Future<void> fetchDbTags() async {
    return await dbHelper.fetchTags(apartmentId).then((value) => {
          if (value != null) {populateTagList(value)}
        });
  }

  Future<void> fetchDbImages() async {
    await dbHelper
        .fetchImages(apartmentId)
        .then((value) => {populateImageList(value)});
  }

  String getTag(int imageIndex) {
    var tag;
    imageTags.forEach((element) {
      if (element.image_id == picList.elementAt(imageIndex).id) {
        tag = element.tag;
      }
    });
    return tag;
    
  }
}
