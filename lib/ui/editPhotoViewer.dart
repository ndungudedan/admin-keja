import 'dart:io';
import 'package:admin_keja/database/dboperations.dart';
import 'package:admin_keja/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class EditPhotoViewer extends StatefulWidget {
  File pic;
  String tag;
  var index;
  var apartmentId;
  EditPhotoViewer(
      {Key key,
      @required this.pic,
      @required this.tag,
      @required this.index,
      @required this.apartmentId})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<EditPhotoViewer> {
  final dbHelper = DbOperations.instance;
  File pic;
  String tag;
  //List<String> tempList = [];
  final _tagController = TextEditingController();
  var picIndex = 0;
  var apartmentId;

  @override
  void initState() {
    pic = widget.pic;
    tag = widget.tag;
    //tempList = widget.tagList;
    picIndex = widget.index;
    apartmentId = widget.apartmentId;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              compressAndGetFile(pic);
            },
          ),
        ],
      ),
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.file(
                pic,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: displayTag(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container displayTag() {
    return Container(
      decoration: BoxDecoration(
          border:
              Border.all(style: BorderStyle.solid, width: 2, color: Colors.red),
          color: Colors.transparent),
      child: TextFormField(
        controller: _tagController,
        onFieldSubmitted: (term) {
          setState(() {
            tag = _tagController.text;
          });
        },
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.green, style: BorderStyle.solid, width: 5.0),
          ),
          contentPadding: const EdgeInsets.only(
              top: 10.0, right: 30.0, bottom: 10.0, left: 5.0),
        ),
      ),
    );
  }

  Future<File> compressAndGetFile(File file) async {
    final directory = await getApplicationDocumentsDirectory();
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      directory.path + '/' + path.basename(file.path),
      quality: 80,
    );
    //toUpload.add(result);
    print('worked');
    print(file.lengthSync());
    print(result.lengthSync());
    return result;
  }

  void updateLocal() {
    dbHelper.updateTag(
        'tag' + picIndex.toString(), apartmentId, _tagController.text);
  }
}
