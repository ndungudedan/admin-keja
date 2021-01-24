import 'dart:io';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class PhotoViewer extends StatefulWidget {
  List<File> picList = [];
  List<String> tagList = [];
  var index;
  PhotoViewer(
      {Key key,
      @required this.picList,
      @required this.tagList,
      @required this.index})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PhotoViewer> {
  List<File> picList = [];
  List<String> tagList = [];
  List<String> tempList = [];
  final _tagController = TextEditingController();
  var picIndex = 0;

  @override
  void initState() {
    picList = widget.picList;
    tagList = widget.tagList;
    tempList = widget.tagList;
    picIndex = widget.index;
    _tagController.text = tagList.elementAt(picIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: LightColors.kLightYellow,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, tempList),
        ),
        backgroundColor: LightColors.kDarkYellow,
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context, tagList);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  child: InteractiveViewer(
                    child: Image.file(
                      picList.elementAt(picIndex),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
          Positioned(bottom: 0, child: displayTag())
        ],
      ),
    );
  }

  Container displayTag() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border:
              Border.all(style: BorderStyle.solid, width: 2, color: Colors.red),
          color: Colors.white),
      child: TextFormField(
        controller: _tagController,
        onFieldSubmitted: (term) {
          setState(() {
            tagList.removeAt(picIndex);
            tagList.insert(picIndex, _tagController.text);
            _tagController.text = '';
          });
          Navigator.pop(context, tagList);
        },
        style: const TextStyle(
          color: Colors.black,
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
}
