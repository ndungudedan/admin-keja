import 'dart:convert';
import 'dart:io';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/database/dboperations.dart';
import 'package:admin_keja/models/status.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';

class EditPhotoViewer extends StatefulWidget {
  File pic;
  String tag;
  var picId;
  var apartmentId;
  EditPhotoViewer(
      {Key key,
      @required this.pic,
      @required this.tag,
      @required this.picId,
      @required this.apartmentId})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<EditPhotoViewer> {
  final dbHelper = DbOperations.instance;
  File pic;
  String tag;
  final _tagController = TextEditingController();
  String picId = '0';
  var apartmentId;
  double progress = 0.0;
  ProgressDialog progressDialog;

  @override
  void initState() {
    pic = widget.pic;
    tag = widget.tag;
    _tagController.text = widget.tag;
    picId = widget.picId;
    apartmentId = widget.apartmentId;

    super.initState();
  }

  onProgress(double progress) {
    progressDialog.update(
      progress: progress,
    );
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Download, isDismissible: false);
    progressDialog.style(
      message: 'Uploading data',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: progress,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: LightColors.kDarkYellow,
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: displayTag(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> upload(var file) async {
    await progressDialog.show();
    var result;
    if(picId=='-1'){
      result = await NetworkApi()
        .updateBannerImage(file, tag, apartmentId, onProgress);
    }else{
   result = await NetworkApi()
        .updateImage(file, tag, apartmentId, picId, onProgress);
    }
    print(result);
    if (result != Constants.fail) {
      var Map = json.decode(result);
      Status status = Status.fromJson(Map);
      progressDialog.hide();
      if (status.code == Constants.success) {
        infoDialog(context, status.message, showNeutralButton: true);
      } else {
        errorDialog(context, status.message, showNeutralButton: true);
      }
    } else {
      errorDialog(context, "Failed...Please try again later",
          showNeutralButton: true);
    }
  }

  Container displayTag() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              style: BorderStyle.solid,
              width: 2,
              color: LightColors.kLightYellow),
          color: Colors.grey[400]),
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
      quality: 40,
    ).then((value) => {upload(value), print(value.lengthSync())});
    print('worked');
    print(file.lengthSync());
  }

  void updateLocal() {
    //dbHelper.updateTag(apartmentId, _tagController.text);
  }
}
