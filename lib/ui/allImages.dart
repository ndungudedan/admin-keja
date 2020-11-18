import 'dart:io';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/database/dboperations.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/apartment.dart';
import 'package:admin_keja/models/company.dart';
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
  final List<String> picList = [];
  final List<String> imageTags = [];
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
                        children: <Widget>[
                          picList.elementAt(index) == null ||
                                  picList.elementAt(index).isEmpty
                              ? Container(
                                  height: 150.0,
                                  width: 150.0,
                                  color: Colors.black87,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ))
                              : Image.memory(
                                  Utility.dataFromBase64String(
                                      picList.elementAt(index)),
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
                                      imageTags.elementAt(index),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(''),
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
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
        ));
  }

  void getPrefs() {
    userId = sharedPreferences.getUserId();
    companyId = sharedPreferences.getCompanyId();
  }

  void updateImage(var index) async {
    try {
      var tempImage = await FilePicker.platform.pickFiles(
        type: FileType.image
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

  void populateImageList(var index, var val) {
    setState(() {
      picList.insert(index, val);
    });
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

  Future<void> fetchDbTags() async {
    return await dbHelper.fetchTags(apartmentId).then((value) => {
          if (value != null) {populateTagList(value)}
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
    await dbHelper
        .fetchSingleImage('image6', apartmentId)
        .then((value) => {populateImageList(6, value)});
    await dbHelper
        .fetchSingleImage('image7', apartmentId)
        .then((value) => {populateImageList(7, value)});
    await dbHelper
        .fetchSingleImage('image8', apartmentId)
        .then((value) => {populateImageList(8, value)});
    await dbHelper
        .fetchSingleImage('image9', apartmentId)
        .then((value) => {populateImageList(9, value)});
    await dbHelper
        .fetchSingleImage('image10', apartmentId)
        .then((value) => {populateImageList(10, value)});
    await dbHelper
        .fetchSingleImage('image11', apartmentId)
        .then((value) => {populateImageList(11, value)});
    await dbHelper
        .fetchSingleImage('image12', apartmentId)
        .then((value) => {populateImageList(12, value)});
    await dbHelper
        .fetchSingleImage('image13', apartmentId)
        .then((value) => {populateImageList(13, value)});
    await dbHelper
        .fetchSingleImage('image14', apartmentId)
        .then((value) => {populateImageList(14, value)});
    await dbHelper
        .fetchSingleImage('image15', apartmentId)
        .then((value) => {populateImageList(15, value)});
  }
}
