import 'dart:convert';
import 'package:admin_keja/blocs/apartmentBloc.dart';
import 'package:admin_keja/blocs/homeBloc.dart';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/company.dart';
import 'package:admin_keja/ui/company.dart';
import 'package:admin_keja/ui/home.dart';
import 'package:admin_keja/ui/settings.dart';
import 'package:admin_keja/utility/floatingactionbutton.dart';
import 'package:admin_keja/views/bottomBar.dart';
import 'package:commons/commons.dart';
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
  MyApartmentsBloc myApartmentsBloc;
  MyHomeBloc myHomeBloc;
  int _selectedIndex = 0;
  var month, year;
  var currDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    myApartmentsBloc = MyApartmentsBloc();
    myHomeBloc = MyHomeBloc();
    month = currDate.month;
    year = currDate.year;
    fetchCompany();
  }

  @override
  void dispose() {
    super.dispose();
    myApartmentsBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Home(),
          Company(),
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
            //infoDialog(context, 'You dont have acces to this page');
            setState(() {
              _selectedIndex = 0;
            });
          },
          companyPressed: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
          settingsPressed: () {
            setState(() {
              _selectedIndex = 2;
            });
          }),
    );
  }

  Future<void> fetchCompany() async {
    var result = await NetworkApi().fetchCompany(sharedPreferences.getUserId());
    print(result);
      var Map = json.decode(result);
        MyCompany company = CompanyResponse.fromJson(Map).data;
        saveCompany(company);
      myApartmentsBloc.fetchMyApartments(company.id);
      myHomeBloc.fetchMyHome(company.id, month, year.toString());
    
  }

  void saveCompany(MyCompany company) {
    sharedPreferences.setCompanyAddress(company.address);
    sharedPreferences.setCompanyEmail(company.email);
    sharedPreferences.setCompanyId(company.id);
    sharedPreferences.setCompanyLocation(company.address);
    sharedPreferences.setCompanyName(company.name);
    sharedPreferences.setCompanyPhone(company.phone);
    sharedPreferences.setCompanyPhoto(company.logo);
  }
}
