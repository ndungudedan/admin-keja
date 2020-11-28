import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/company.dart';
import 'package:admin_keja/models/tenant.dart';
import 'package:admin_keja/models/transaction.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/about.dart';
import 'package:admin_keja/ui/changeCredentials.dart';
import 'package:admin_keja/ui/contactus.dart';
import 'package:admin_keja/ui/editCompany.dart';
import 'package:admin_keja/ui/login.dart';
import 'package:admin_keja/ui/map.dart';
import 'package:admin_keja/ui/terms.dart';
import 'package:admin_keja/utility/utility.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  Settings({Key key, this.myTenant, this.apartmentId, this.companyResponse})
      : super(key: key);
  MyTenant myTenant;
  String apartmentId;
  CompanyResponse companyResponse;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Settings> {
  bool show;
  bool check = false;
  var apartmentId;
  MyTenant myTenant = MyTenant();
  MyTransaction transaction = MyTransaction();
  TransactionList transactionList = TransactionList();
  TransactionResponse transactionResponse = TransactionResponse();
  List<MyTransaction> transactions = List<MyTransaction>();
  MyCompany company = MyCompany();
  var top = 0.0;
  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getPrefs();
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        //backgroundColor: LightColors.kLightYellow,
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            backgroundColor: LightColors.kDarkYellow,
            pinned: true,
            expandedHeight: 220.0,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditCompany(
                            company: company,
                          )));
                },
              ),
            ],
            flexibleSpace: company.id != null
                ? FlexibleSpaceBar(
                    title: Text(company.name),
                    centerTitle: true,
                    background: Container(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          company.logo == null
                            ? Image.asset(
                                'assets/images/pin7.jpg',
                                fit: BoxFit.fitWidth,
                              )
                            : ColorFiltered(
                              colorFilter: ColorFilter.mode(LightColors.kLavender, BlendMode.color),
                                                          child: Image.memory(
                                  Utility.dataFromBase64String(company.logo),
                                  fit: BoxFit.fitWidth,
                                ),
                            ),
                          Positioned(
                            bottom: 50,
                            left: 0,
                            right: 0,
                            child: Container(
                              child: Column(
                                children: [
                                  Text(
                                    company.email,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    company.phone,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    company.address,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : FlexibleSpaceBar(
                    title: Text(''),
                    centerTitle: true,
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        company.logo == null
                            ? Image.asset(
                                'assets/images/pin7.jpg',
                                fit: BoxFit.fitWidth,
                              )
                            : Image.memory(
                                Utility.dataFromBase64String(company.logo),
                                fit: BoxFit.fitWidth,
                              ),
                        Positioned(
                            bottom: 100,
                            left: 50,
                            right: 50,
                            top: 100,
                            child: Container(
                              height: 50,
                              width: 50,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EditCompany()));
                                },
                                child: Text('Create Company'),
                                color: Colors.orange,
                              ),
                            ))
                      ],
                    ),
                  )),
        SliverList(
          delegate: SliverChildListDelegate([
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChangeCredentials()));
              },
              leading: Icon(Icons.lock),
              title: Text('Change Credentials'),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Broadcast Messages'),
            ),
            ListTile(
              leading: Icon(Icons.map_outlined),
              title: Text('Map View'),
              onTap: () {
                Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Gmap()));
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_phone),
              title: Text('Contact us'),
              onTap: () {
                Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ContactUs()));
              },
            ),
            ListTile(
              leading: Icon(Icons.read_more),
              title: Text('Terms & Conditions'),
              onTap: () {
                Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Terms()));
              },
            ),
            ListTile(
              leading: Icon(Icons.chrome_reader_mode_rounded),
              title: Text('About'),
              onTap: () {
                Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => About()));
              },
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
    ModalRoute.withName('/'),
  );
              },
              leading: Icon(Icons.settings_power),
              title: Text('Log Out'),
            ),
          ]),
        )
      ],
    ));
  }

  void getPrefs() async {
    company.id = sharedPreferences.getCompanyId();
    company.address = sharedPreferences.getCompanyAddress();
    // company.adminId = sharedPrefsManagement.();
    company.email = sharedPreferences.getCompanyEmail();
    company.logo = sharedPreferences.getCompanyPhoto();
    company.phone = sharedPreferences.getCompanyPhone();
    company.name = sharedPreferences.getCompanyName();
  }
}
