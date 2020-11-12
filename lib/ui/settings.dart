import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/company.dart';
import 'package:admin_keja/models/tenant.dart';
import 'package:admin_keja/models/transaction.dart';
import 'package:admin_keja/ui/editCompany.dart';
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
  List<String> tableList = [
    'Send to Mpesa',
    'Deposit',
    'Send Money',
    'Loans',
    'Savings',
    'Utilities'
  ];

  List<String> icons = [
    'assets/images/ic_account.png',
    'assets/images/ic_fund_transfer.png',
    'assets/images/ic_statement.png',
    'assets/images/ic_loan.png',
    'assets/images/ic_deposite.png',
    'assets/images/ic_more.png'
  ];
  List<String> accounts = [
    'Savings Account',
    'Credit Account',
    'Savings Account',
    'Credit Account'
  ];

  List<Icon> hide = [
    Icon(
      Icons.star,
      color: Colors.amber,
      size: 12,
    ),
    Icon(
      Icons.star,
      color: Colors.amber,
      size: 12,
    ),
    Icon(
      Icons.star,
      color: Colors.amber,
      size: 12,
    ),
    Icon(
      Icons.star,
      color: Colors.amber,
      size: 12,
    ),
    Icon(
      Icons.star,
      color: Colors.amber,
      size: 12,
    ),
    Icon(
      Icons.star,
      color: Colors.amber,
      size: 12,
    ),
    Icon(
      Icons.star,
      color: Colors.amber,
      size: 12,
    ),
    Icon(
      Icons.star,
      color: Colors.amber,
      size: 12,
    ),
    Icon(
      Icons.star,
      color: Colors.amber,
      size: 12,
    ),
    Icon(
      Icons.star,
      color: Colors.amber,
      size: 12,
    ),
  ];
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
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
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
                          Image.asset(
                            'assets/images/login.jpeg',
                            fit: BoxFit.fitWidth,
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
                       company.logo ==null ?
                Image.asset('assets/images/pin7.jpg',
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
              leading: Icon(Icons.lock),
              title: Text('Change Credentials'),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Broadcast Messages'),
            ),
            ListTile(
              leading: Icon(Icons.settings_power),
              title: Text('Log Out'),
            ),
          ]
          ),
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
