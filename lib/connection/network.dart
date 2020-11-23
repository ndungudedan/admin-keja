import 'dart:convert';
import 'dart:io';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/utility/uploadProgress.dart';
import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path/path.dart' as path;

class Network {
  final String url;
  Network(this.url);

  Future call(String json) async {
    print('Calling uri: $url');
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

  Future uploadApartment(List<File> files, var tags, var features, var details,
      Function onProgress) async {
    List<MultipartFile> imageList = new List<MultipartFile>();

    for (File file in files) {
      var multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: path.basename(file.path),
      );
      imageList.add(multipartFile);
    }

    FormData formData = FormData.fromMap({
      "title": details[UploadData.apartmentName],
      "rent": details[UploadData.apartmentRent],
      "longitude": details[UploadData.longitude],
      "latitude": details[UploadData.latitude],
      "deposit": details[UploadData.apartmentDeposit],
      "phone": details[UploadData.apartmentPhone],
      "categoryId": details[UploadData.category],
      "email": details[UploadData.email],
      "location": details[UploadData.location],
      "address": details[UploadData.address],
      "description": details[UploadData.description],
      "units": details[UploadData.units],
      "companyId": details[UploadData.companyId],
      "tags": tags,
      "features": features,
      "images": imageList,
    });

    Dio dio = new Dio();
    var response = await dio.post(url, data: formData,
        onSendProgress: (int sent, int total) {
      double progress = (sent / total) * 100;
      onProgress(progress);
      print("progress:  $progress");
    });
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(response.statusCode);
    }
    print(response);
  }
}
