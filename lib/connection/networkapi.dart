import 'dart:convert';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/management/management.dart';

import 'network.dart';

class NetworkApi {
  Constants constants=Constants();
  
  Future<dynamic> login(var email, var pass) async {
    Network network = Network(constants.baseurl);
    var data = await network.call(loginjson(email, pass));
    return data;
  }
    Future<dynamic> getApartmentLocations() async {
    Network network = Network(constants.baseurl);
    var data = await network.call(locationsjson());
    return data;
  }

    Future<dynamic> changeCredentials(var email, var pass,var userId) async {
    Network network = Network(constants.baseurl);
    var data = await network.call(changeCredentialsjson(email, pass,userId));
    return data;
  }

  Future<dynamic> fetchCompany(var userId) async {
    Network network = Network(constants.baseurl);
    var data = await network.call(companyjson(userId));
    return data;
  }
  Future<dynamic> fetchApartments(var companyId) async {
    Network network = Network(constants.baseurl);
    var data = await network.call(apartmentsjson(companyId));
    return data;
  }
  Future<dynamic> fetchHome(var companyId,var month,var year) async {
    Network network = Network(constants.baseurl);
    var data = await network.call(homejson(companyId,month,year));
    return data;
  }
  Future<dynamic> fetchApartmentSummary(var apartmentId,var month,var year) async {
    Network network = Network(constants.baseurl);
    var data = await network.call(apartmentSummaryjson(apartmentId,month,year));
    return data;
  }
    Future<dynamic> fetchTransactions(var apartmentId,var month,var year) async {
    Network network = Network(constants.baseurl);
    var data = await network.call(apartmentTransactionsjson(apartmentId,month,year));
    return data;
  }
  Future<dynamic> fetchTenants(var apartmentId) async {
    Network network = Network(constants.baseurl);
    var data = await network.call(tenantsjson(apartmentId));
    return data;
  }
  Future<dynamic> fetchTenantTransactions(var apartmentId,var tenantId) async {
    Network network = Network(constants.baseurl);
    var data = await network.call(tenanttransjson(apartmentId,tenantId));
    return data;
  }
    Future<dynamic> addUnit(var apartmentId,var userId,var unit) async {
    Network network = Network(constants.baseurl);
    var data = await network.call(addUnitjson(apartmentId,userId,unit));
    return data;
  }
  Future<dynamic> fungaKeja(var apartmentId,var userId) async {
    Network network = Network(constants.baseurl);
    var data = await network.call(fungaKejajson(apartmentId,userId));
    return data;
  }
    Future<dynamic> getImages(var apartmentId) async {
    // 6
    Network network = Network(constants.baseurl);
    // 7
    var Data = await network.call(imagejson(apartmentId));
    return Data;
  }
      Future<dynamic> getTags(var apartmentId) async {
    Network network = Network(constants.baseurl);
    var Data = await network.call(tagjson(apartmentId));
    return Data;
  }
    Future<dynamic> getFeatures(String apartmentId) async {
    // 6
    Network network = Network(constants.baseurl);
    // 7
    var Data = await network.call(getFeaturesJson(apartmentId));
    return Data;
  }

  Future<dynamic> upload(var images,var tags,var features,var details,Function onProgress) async {
    // 6
    Network network = Network(constants.uploadurl);
    // 7
    var Data = await network.uploadApartment(images,tags,features,details,onProgress);
    return Data;
  }
    Future<dynamic> updateImage(var file,var tag,var apartmentId,var picIndex,Function onProgress) async {
    // 6
    Network network = Network(constants.updateurl);
    // 7
    var Data = await network.updateApartment(file,tag,apartmentId,picIndex,onProgress);
    return Data;
  }
      Future<dynamic> updateTag(var tag,var apartmentId,var picIndex) async {
    // 6
    Network network = Network(constants.updateurl);
    // 7
    var Data = await network.call(updateTagJson(tag,apartmentId,picIndex));
    return Data;
  }
    Future<dynamic> updateStep1(var apartmentId,var details) async {
    // 6
    Network network = Network(constants.updateurl);
    // 7
    var Data = await network.call(updateStep1Json(apartmentId,details));
    return Data;
  }
  Future<dynamic> updateStep2(var apartmentId,var details) async {
    // 6
    Network network = Network(constants.updateurl);
    // 7
    var Data = await network.call(updateStep2Json(apartmentId,details));
    return Data;
  }
    Future<dynamic> updateFeatures(var apartmentId,var features) async {
    // 6
    Network network = Network(constants.updateurl);
    // 7
    var Data = await network.updateFeatures(features,apartmentId);
    return Data;
  }
  Future<dynamic> updateCompany(var upload,var details) async {
    // 6
    Network network = Network(constants.updateurl);
    // 7
    var Data = await network.updateCompany(upload,details);
    return Data;
  }
    Future<dynamic> fetchCategorys() async {
    Network network = Network(constants.baseurl);
    var data = await network.call(categoryjson());
    return data;
  }

    String categoryjson() {
    var json = jsonEncode(<String, String>{
      'functionality': 'getCategorys',
    });
    return json;
  }

  String getFeaturesJson(String apartmentId) {
    var json = jsonEncode(<String, String>{
      'functionality': 'getFeatures',
      'apartmentId': apartmentId,
    });
    return json;
  }
  String imagejson(var apartmentId) {
    var json = jsonEncode(<String, String>{
      'functionality': 'retreiveImages',
      'apartmentId': apartmentId,
    });
    return json;
  }
    String tagjson(var apartmentId) {
    var json = jsonEncode(<String, String>{
      'functionality': 'retreiveTags',
      'apartmentId': apartmentId,
    });
    return json;
  }

  String addUnitjson(var apartmentId, var userId,var unit) {
    var json = jsonEncode(<String, String>{
      'functionality':'addUnit',
      'apartmentId': apartmentId,
      'userId': userId,
      'unit': unit,
    });
    return json;
  }
    String fungaKejajson(var apartmentId, var userId) {
    var json = jsonEncode(<String, String>{
      'functionality':'fungaKeja',
      'apartmentId': apartmentId,
      'tenantId': userId,
      'present': '0',
    });
    return json;
  }

  String loginjson(var email, var pass) {
    var json = jsonEncode(<String, String>{
      'functionality':'login',
      'email': email,
      'password': pass,
    });
    return json;
  }
    String locationsjson() {
    var json = jsonEncode(<String, String>{
      'functionality':'getLocations',
      'companyId': sharedPreferences.getCompanyId(),
    });
    return json;
  }
    String changeCredentialsjson(var email, var pass,var userId) {
    var json = jsonEncode(<String, String>{
      'functionality':'updateCredentials',
      'email': email,
      'password': pass,
      'userId': userId,
    });
    return json;
  }

  String companyjson(var userId) {
    var json = jsonEncode(<String, String>{
      'functionality':'getCompany',
      'userId': userId,
    });
    return json;
  }
  String tenantsjson(var apartmentId) {
    var json = jsonEncode(<String, String>{
      'functionality':'getTenants',
      'apartmentId': apartmentId,
    });
    return json;
  }
  
    String apartmentsjson(var companyId) {
    var json = jsonEncode(<String, String>{
      'functionality':'getApartments',
      'companyId': companyId,
    });
    return json;
  }
  String tenanttransjson(var apartmentId,var tenantId) {
    var json = jsonEncode(<String, String>{
      'functionality':'getTenantTransactions',
      'apartmentId': apartmentId,
      'tenantId': tenantId,
    });
    return json;
  }

  String homejson(var companyId,var month,var year) {
    var json = jsonEncode(<String, String>{
      'functionality':'getHome',
      'companyId': companyId,
      'year': year,
      'month': '0'+month.toString(),
    });
    return json;
  } String apartmentSummaryjson(var apartmentId,var month,var year) {
    var json = jsonEncode(<String, String>{
      'functionality':'getApartmentSummary',
      'apartmentId': apartmentId,
      'year': year,
      'month': '0'+month.toString(),
    });
    return json;
  }
  
   String apartmentTransactionsjson(var apartmentId,var month,var year) {
    var json = jsonEncode(<String, String>{
      'functionality':'getApartmentTransactions',
      'apartmentId': apartmentId,
      'year': year,
      'month': '0'+month.toString(),
    });
    return json;
  }
  String updateStep1Json(var apartmentId,var details) {
    var json = jsonEncode(<String, String>{
      'functionality':'updateStep1',
      'apartmentId': apartmentId,
      'title': details[UploadData.apartmentName],
      'rent': details[UploadData.apartmentRent],
      'deposit': details[UploadData.apartmentDeposit],
      'categoryId': details[UploadData.category],
      'units': details[UploadData.units],
    });
    return json;
  }
    String updateTagJson(var tag,var apartmentId,var picIndex) {
    var json = jsonEncode(<String, String>{
      'functionality':'updateTag',
      'apartmentId': apartmentId,
      'tag': tag,
      "index": picIndex.toString(),
    });
    return json;
  }
  
    String updateStep2Json(var apartmentId,var details) {
    var json = jsonEncode(<String, String>{
      'functionality':'updateStep2',
      'apartmentId': apartmentId,
      'longitude': details[UploadData.longitude],
      'latitude': details[UploadData.latitude],
      'phone': details[UploadData.apartmentPhone],
      'email': details[UploadData.email],
      'location': details[UploadData.location],
    });
    return json;
  }
}
