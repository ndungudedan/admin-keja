import 'dart:convert';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/database/dboperations.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/apartment.dart';
import 'package:admin_keja/models/company.dart';
import 'package:admin_keja/models/home.dart';
import 'package:admin_keja/models/status.dart';
import 'package:admin_keja/ui/company.dart';
import 'package:admin_keja/ui/home.dart';
import 'package:admin_keja/ui/settings.dart';
import 'package:admin_keja/utility/floatingactionbutton.dart';
import 'package:admin_keja/utility/utility.dart';
import 'package:admin_keja/views/bottomBar.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'createApartment.dart';

class Index extends StatefulWidget {
  Index({Key key, this.phone, this.userid}) : super(key: key);

  final String phone;
  final String userid;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Index> with TickerProviderStateMixin {
  final dbHelper = DbOperations.instance;
  int _selectedIndex = 0;
  GlobalKey bottomNavigationKey = GlobalKey();
  MyCompany company = MyCompany();
  Constants constants = Constants();
  ApartmentList apartmentList = ApartmentList();
  CompanyResponse companyResponse = CompanyResponse();
  MyHomeResponse myHomeResponse = MyHomeResponse();
  MyApartmentResponse myApartmentResponse = MyApartmentResponse();
  FancyBottomNavigationState fState;
  List<MyApartment> apartments = List<MyApartment>();
  List<MyHome> myHomes = List<MyHome>();
  List<MyHomeSummary> myHomesummarys = List<MyHomeSummary>();
  Status status = Status();
  bool active;
  var month, year;
  var phone, userid;
  bool signed_in = false;
  var companyId;
  var currDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    fState = bottomNavigationKey.currentState;
    active = true;
    userid = widget.userid;
    month = currDate.month;
    year = currDate.year;
    getPrefs();
    fetchCompany();
    fetchDbApartments();
    fetchDbHomeSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Home(
            myHomeSummary: myHomesummarys,
            companyId: companyId,
          ),
          Company(
            apartments: apartments,
            status: status,
          ),
          Settings(),
        ],
      ),
      floatingActionButton: floatingButton(
        title: 'new',
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreateApartment()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: MyBottomAppBar(
        selected: _selectedIndex,
        homePressed: () {
        setState(() {
          _selectedIndex = 0;
        });
      }, companyPressed: () {
        setState(() {
          _selectedIndex = 1;
        });
      }, settingsPressed: () {
        setState(() {
          _selectedIndex = 2;
        });
      }),
    );
  }

  Future<void> fetchCompany() async {
    var result = await NetworkApi().fetchCompany(userid);
    print(result);
    var Map = json.decode(result);
    setState(() {
      companyResponse = CompanyResponse.fromJson(Map);
      company = companyResponse.data;
      companyId = company.id;
    });
    saveCompany(company);
    fetchApartments(company.id);
    fetchHome(company.id);
  }

  void getPrefs() {
    userid = sharedPreferences.getUserId();
  }

  Future<void> fetchApartments(var companyId) async {
    var result = await NetworkApi().fetchApartments(companyId);
    print(result);
    var Map = json.decode(result);
    myApartmentResponse = MyApartmentResponse.fromJson(Map);
    _insertApartment(myApartmentResponse.data.apartments);
    fetchDbApartments();
    setState(() {
      status = myApartmentResponse.status;
    });
  }

  Future<void> fetchHome(var companyId) async {
    var result =
        await NetworkApi().fetchHome(companyId, month, year.toString());
    print(result);
    var Map = json.decode(result);
    myHomeResponse = MyHomeResponse.fromJson(Map);
    insertHome(myHomeResponse.data.myhomes);
    insertHomeSummary(myHomeResponse.summary.values);
  }

  void saveCompany(MyCompany company) {
    sharedPreferences.setCompanyAddress(company.address);
    sharedPreferences.setCompanyEmail(company.email);
    sharedPreferences.setCompanyId(company.id);
    sharedPreferences.setCompanyLocation(company.address);
    sharedPreferences.setCompanyName(company.name);
    sharedPreferences.setCompanyPhone(company.phone);
    Utility.base64String(
            constants.path + companyId + constants.folder + company.logo)
        .then((value) => {sharedPreferences.setCompanyPhoto(value)});
  }

  void _insertApartment(List<MyApartment> apartments) async {
    for (int i = 0; i < apartments.length; i++) {
      MyApartment myApartment = MyApartment();
      myApartment.id = apartments.elementAt(i).id;
      myApartment.owner_id = apartments.elementAt(i).owner_id;
      myApartment.category = apartments.elementAt(i).category;
      myApartment.title = apartments.elementAt(i).title;
      myApartment.description = apartments.elementAt(i).description;
      myApartment.location = apartments.elementAt(i).location;
      myApartment.email = apartments.elementAt(i).email;
      myApartment.video = apartments.elementAt(i).video;
      myApartment.price = apartments.elementAt(i).price;
      myApartment.address = apartments.elementAt(i).address;
      myApartment.phone = apartments.elementAt(i).phone;
      myApartment.deposit = apartments.elementAt(i).deposit;
      myApartment.space = apartments.elementAt(i).space;
      myApartment.latitude = apartments.elementAt(i).latitude;
      myApartment.longitude = apartments.elementAt(i).longitude;
      myApartment.likes = apartments.elementAt(i).likes;
      myApartment.comments = apartments.elementAt(i).comments;
      myApartment.rating = apartments.elementAt(i).rating;
      final id = await dbHelper.insertApartment(myApartment);
      Utility.base64String(constants.path +
              companyId +
              constants.folder +
              apartments.elementAt(i).banner)
          .then((value) async =>
              {await dbHelper.updateBanner(apartments.elementAt(i).id, value)});
      print('inserted row id: $id');
    }
  }

  void fetchDbApartments() async {
    var res = await dbHelper.fetchApartments();
    setState(() {
      apartments = res;
    });
  }

  void insertHome(List<MyHome> myhomes) async {
    for (int i = 0; i < myhomes.length; i++) {
      MyHome myHome = MyHome();
      myHome.id = myhomes.elementAt(i).id;
      myHome.apartment_id = myhomes.elementAt(i).apartment_id;
      myHome.company_id = myhomes.elementAt(i).company_id;
      myHome.title = myhomes.elementAt(i).title;
      myHome.year = myhomes.elementAt(i).year;
      myHome.month = myhomes.elementAt(i).month;
      myHome.paid = myhomes.elementAt(i).paid;
      myHome.expected = myhomes.elementAt(i).expected;
      myHome.due = myhomes.elementAt(i).due;
      final id = await dbHelper.insertHome(myHome);
      print('inserted row id: $id');
    }
  }

  void insertHomeSummary(List<MyHomeSummary> myhomesummary) async {
    for (int i = 0; i < myhomesummary.length; i++) {
      MyHomeSummary myHome = MyHomeSummary();
      myHome.year = myhomesummary.elementAt(i).year;
      myHome.month = myhomesummary.elementAt(i).month;
      myHome.paid = myhomesummary.elementAt(i).paid;
      myHome.expected = myhomesummary.elementAt(i).expected;
      myHome.due = myhomesummary.elementAt(i).due;
      final id = await dbHelper.insertHomeSummary(myHome);
      print('inserted row id: $id');
    }
  }

  Future<void> fetchDbHomeSummary() async {
    var res = await dbHelper.fetchHomeSummary();
    setState(() {
      myHomesummarys = res;
    });
  }
}
