import 'dart:convert';
import 'dart:typed_data';
import 'package:admin_keja/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManagement {
  static SharedPreferences sharedPreferences;
  init() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  @override
  String saveImage(String userId, String key, Uint8List image) {
    final base64Image = Base64Encoder().convert(image);
    sharedPreferences.setString(SharedPrefs.photo, base64Image);
    return key;
  }

  @override
  Uint8List getImage(String userId, String key) {
    final base64Image = sharedPreferences.getString(SharedPrefs.photo);
    if (base64Image != null) return Base64Decoder().convert(base64Image);
    return null;
  }

  checkFirstTime() {
    return sharedPreferences.containsKey(SharedPrefs.firstlogin);
  }

  checkEmail() {
    return sharedPreferences.containsKey(SharedPrefs.email);
  }

  unsetEmail() {
    sharedPreferences.remove(SharedPrefs.email);
  }

  setEmail(var val) {
    sharedPreferences.setString(SharedPrefs.email, val);
  }

  setPassword(var val) {
    sharedPreferences.setString(SharedPrefs.password, val);
  }

  setCompanyId(var val) {
    sharedPreferences.setString(SharedPrefs.companyid, val);
  }

  setUserId(var val) {
    sharedPreferences.setString(SharedPrefs.userid, val);
  }

  setPhone(var val) {
    sharedPreferences.setString(SharedPrefs.phone, val);
  }

  setPhoto(var val) {
    sharedPreferences.setString(SharedPrefs.photo, val);
  }

  setSurname(var val) {
    sharedPreferences.setString(SharedPrefs.surname, val);
  }

  setFirstname(var val) {
    sharedPreferences.setString(SharedPrefs.firstname, val);
  }

  setFirstLogin(var val) {
    sharedPreferences.setBool(SharedPrefs.firstlogin, val);
  }

  setCompanyName(var val) {
    sharedPreferences.setString(SharedPrefs.companyname, val);
  }

  setCompanyPhone(var val) {
    sharedPreferences.setString(SharedPrefs.companyphone, val);
  }

  setCompanyAddress(var val) {
    sharedPreferences.setString(SharedPrefs.companyaddress, val);
  }

  setCompanyEmail(var val) {
    sharedPreferences.setString(SharedPrefs.companyemail, val);
  }

  setCompanyLocation(var val) {
    sharedPreferences.setString(SharedPrefs.companylocation, val);
  }

  setCompanyPhoto(String image) {
    sharedPreferences.setString(SharedPrefs.companyphoto, image);
  }

  getEmail() {
    return sharedPreferences.getString(SharedPrefs.email);
  }

  getPassword() {
    return sharedPreferences.getString(SharedPrefs.password);
  }

  getPhone() {
    return sharedPreferences.getString(SharedPrefs.phone);
  }

  getPhoto() {
    return sharedPreferences.getString(SharedPrefs.photo);
  }

  getUserId() {
    return sharedPreferences.getString(SharedPrefs.userid);
  }

  getCompanyId() {
    return sharedPreferences.getString(SharedPrefs.companyid);
  }

  getSurname() {
    return sharedPreferences.getString(SharedPrefs.surname);
  }

  getFirstLogin() {
    return sharedPreferences.getBool(SharedPrefs.firstlogin);
  }

  getFirstname() {
    return sharedPreferences.getString(SharedPrefs.firstname);
  }

  @override
  String getCompanyPhoto() {
    final base64Image = sharedPreferences.getString(SharedPrefs.companyphoto);
    if (base64Image != null) return base64Image;
    return null;
  }

  getCompanyAddress() {
    return sharedPreferences.getString(SharedPrefs.companyaddress);
  }

  getCompanyEmail() {
    return sharedPreferences.getString(SharedPrefs.companyemail);
  }

  getCompanyLocation() {
    return sharedPreferences.getString(SharedPrefs.companylocation);
  }

  getCompanyName() {
    return sharedPreferences.getString(SharedPrefs.companyname);
  }

  getCompanyPhone() {
    return sharedPreferences.getString(SharedPrefs.companyphone);
  }
}

final sharedPreferences = SharedPrefsManagement();
