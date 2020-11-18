import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
 
class Utility {
 
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }
 
  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }
 
  static Future<String> base64String(String url) async {
    final ByteData imageData = await NetworkAssetBundle(Uri.parse(url)).load("");
    final Uint8List bytes = imageData.buffer.asUint8List();
    return base64Encode(bytes);
  }
}
