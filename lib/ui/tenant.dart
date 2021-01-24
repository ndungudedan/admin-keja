import 'dart:convert';
import 'package:admin_keja/blocs/transactionsBloc.dart';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/database/dao.dart';
import 'package:admin_keja/database/databasehelper.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/status.dart';
import 'package:admin_keja/models/tenant.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

//add call,message and email functions
class Tenant extends StatefulWidget {
  Tenant({Key key, this.myTenant, this.apartmentId}) : super(key: key);
  MyTenantTableData myTenant;
  String apartmentId;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Tenant> {
  var dao = DatabaseDao(databasehelper);
  var apartmentId;
  Constants constants = Constants();
  MyTenantTableData myTenant;
  final unitController = TextEditingController();
  var unit;
  MyTransactionsBloc myTransactionsBloc;

  @override
  void initState() {
    super.initState();
    myTenant = widget.myTenant;
    apartmentId = widget.apartmentId;
    myTransactionsBloc = MyTransactionsBloc();
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
                icon: Icon(
                  Icons.remove_circle_outline_outlined,
                  color: Colors.red,
                ),
                onPressed: () {
                  infoDialog(
                      context, "Do you really want to vacate the tenant?",
                      positiveAction: () {
                    fungaKeja();
                  },
                      negativeAction: () {},
                      negativeText: 'NO',
                      positiveText: 'YES',
                      showNeutralButton: false);
                })
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.deepOrange, Colors.deepOrange]
                  )
              ),
             // margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(300),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:  myTenant.photo,
                          placeholder: (context, url) => Container(
                              alignment: Alignment(0.0, 2.0),
                              child:
                                  Center(child: CircularProgressIndicator())),
                          errorWidget: (context, url, error) => Container(
                              alignment: Alignment(0.0, 2.0),
                              child: Center(child: Icon(Icons.error))),
                        ),
                      ),
                    ),
                  ),
                 Text('name: '+myTenant.name),
                          Text('email: '+myTenant.email),
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
            StreamBuilder(
                stream: dao.watchTenantTransactions(myTenant.onlineid),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.isNotEmpty) {
                    return SingleChildScrollView(
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
                        rows: getRows(snapshot.data),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('No data'),
                    );
                  } else if (snapshot.data != null && snapshot.data.isEmpty) {
                    return Center(
                      child: Text('No data'),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ));
  }

  void submitUnit() async {
    var result = await NetworkApi().addUnit(apartmentId, myTenant.onlineid, unit);
    print(result);
    var Map = json.decode(result);
    Status status = Status.fromJson(Map);
    if (status.code == Constants.success) {
      successDialog(context, status.message, showNeutralButton: true);
    } else {
      errorDialog(context, status.message, showNeutralButton: true);
    }
  }

  void fungaKeja() async {
    var result = await NetworkApi().fungaKeja(apartmentId, myTenant.onlineid);
    print(result);
    if (result != Constants.fail) {
      var Map = json.decode(result);
      Status status = Status.fromJson(Map);
      if (status.code == Constants.success) {
        infoDialog(context, status.message, showNeutralButton: true);
      } else {
        errorDialog(context, status.message, showNeutralButton: true);
      }
    } else {
      errorDialog(context, "Failed...Please try again later",
          showNeutralButton: true);
    }
  }
    List<DataRow> getRows(var values) {
    var result = List<DataRow>();
    for (var transaction in values) {
      var row = DataRow(cells: [DataCell(
                                  Text(transaction.onlineid),
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
      ]);
      result.add(row);
    }
    return result;
  }
  SnackBar snack(String message) {
    return SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 300),
    );
  }
}
