import 'dart:convert';

import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/database/dboperations.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/status.dart';
import 'package:admin_keja/models/tenant.dart';
import 'package:admin_keja/models/transaction.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

//add call,message and email functions
class Tenant extends StatefulWidget {
  Tenant({Key key, this.myTenant, this.apartmentId}) : super(key: key);
  MyTenant myTenant;
  String apartmentId;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Tenant> {
  bool show;
  bool check = false;
  var apartmentId;
  Constants constants = Constants();
  final dbHelper = DbOperations.instance;
  MyTenant myTenant = MyTenant();
  MyTransaction transaction = MyTransaction();
  TransactionList transactionList = TransactionList();
  TransactionResponse transactionResponse = TransactionResponse();
  List<MyTransaction> transactions = List<MyTransaction>();
  final unitController = TextEditingController();
  var unit;

  @override
  void initState() {
    super.initState();
    myTenant = widget.myTenant;
    apartmentId = widget.apartmentId;
    show = false;
    fetchTransactions();
    fetchDbTransactions();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tenant'),
          backgroundColor: LightColors.kDarkYellow,
          actions: [
            IconButton(
                icon: Icon(Icons.remove_circle_outline_outlined,color: Colors.red,),
                onPressed: () {
                   infoDialog(context, "Do you really want to vacate the tenant?", positiveAction:() {
                     fungaKeja();
                  },negativeAction:() {},negativeText: 'NO',positiveText: 'YES',showNeutralButton: false);
                })
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Card(
                elevation: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                        borderRadius: BorderRadius.circular(300),
                                              child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: constants.path +
                              sharedPreferences.getCompanyId() +
                              constants.folder +
                              myTenant.photo,
                          placeholder: (context, url) => Container(
                              alignment: Alignment(0.0, 2.0),
                              child: Center(child: CircularProgressIndicator())),
                          errorWidget: (context, url, error) => Container(
                              alignment: Alignment(0.0, 2.0),
                              child: Center(child: Icon(Icons.error))),
                        ),
                      ),
                                          ),
                    ),
                    Expanded(
                                          child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(myTenant.name),
                            Text(myTenant.email),
                            Text(myTenant.name),
                            Text('01/01/2020'),
                            myTenant.unit == null
                                ? RaisedButton(
                                    child: Text("unit"),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Assign Unit"),
                                            content: TextFormField(
                                              controller: unitController,
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("OK"),
                                                onPressed: () {
                                                  Navigator.pop(context,
                                                      unitController.text);
                                                },
                                              )
                                            ],
                                          );
                                        },
                                      ).then((val) {
                                        setState(() {
                                          unit = val;
                                        });
                                      });
                                    },
                                  )
                                : Text('unit: ' + myTenant.unit)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                          child: DataTable(
                  columnSpacing: 15.0,
                  columns: [
                    DataColumn(
                      label: Text('unit'),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text('Transaction'),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text('Date'),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text('Type'),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text('Amount'),
                      numeric: false,
                    ),
                  ],
                  rows: transactions
                      .map(
                (transaction) => DataRow(cells: [
                  DataCell(
                    Text(transaction.id),
                  ),
                  DataCell(
                    Text(transaction.transaction_id),
                  ),
                  DataCell(
                    Text(transaction.time),
                  ),
                  DataCell(
                    Text(transaction.type),
                  ),
                  DataCell(
                    Text(transaction.amount),
                  ),
                ]),
                      )
                      .toList(),
                ),
            ),
          ],
        ));
  }

  Future<void> fetchTransactions() async {
    var result = await NetworkApi()
        .fetchTenantTransactions('13', myTenant.id); //update parameterz
    print(result);
    if (result != Constants.success) {
      var Map = json.decode(result);
      transactionResponse = TransactionResponse.fromJson(Map);
      insertTransaction(transactionResponse.data.transactions);
      fetchDbTransactions();
    }
  }

  void insertTransaction(List<MyTransaction> mytransactions) async {
    for (int i = 0; i < mytransactions.length; i++) {
      MyTransaction mytrans = MyTransaction();
      mytrans.id = mytransactions.elementAt(i).id;
      mytrans.user_id = myTenant.id;
      mytrans.apartment_id = mytransactions.elementAt(i).apartment_id;
      mytrans.transaction_id = mytransactions.elementAt(i).transaction_id;
      mytrans.status = mytransactions.elementAt(i).status;
      mytrans.year = mytransactions.elementAt(i).year;
      mytrans.month = mytransactions.elementAt(i).month;
      mytrans.amount = mytransactions.elementAt(i).amount;
      mytrans.time = mytransactions.elementAt(i).time;
      mytrans.type = mytransactions.elementAt(i).type;
      final id = await dbHelper.insertTransaction(mytrans);
      print('inserted row id: $id');
    }
  }

  Future<void> fetchDbTransactions() async {
    var res = await dbHelper.fetchTenantTransactions(myTenant.id, apartmentId);
    setState(() {
      transactions = res;
    });
  }

  void submitUnit() async {
    var result = await NetworkApi().addUnit(apartmentId, myTenant.id, unit);
    print(result);
    if (result != Constants.fail) {
      var Map = json.decode(result);
      Status  status = Status.fromJson(Map);
      if (status.code == Constants.success) {
      infoDialog(context, status.message, showNeutralButton: true);
    } else {
      errorDialog(context, status.message, showNeutralButton: true);
    }
    }else{
      errorDialog(context, "Failed...Please try again later", showNeutralButton: true);
    }
  }

  void fungaKeja() async {
    var result = await NetworkApi().fungaKeja(apartmentId, myTenant.id);
    print(result);
    if (result != Constants.fail) {
      var Map = json.decode(result);
      Status  status = Status.fromJson(Map);
      if (status.code == Constants.success) {
      infoDialog(context, status.message, showNeutralButton: true);
    } else {
      errorDialog(context, status.message, showNeutralButton: true);
    }
    }else{
      errorDialog(context, "Failed...Please try again later", showNeutralButton: true);
    }
  }
   SnackBar snack(String message) {
    return SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 300),
    );
  }
}
