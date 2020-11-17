import 'dart:convert';
import 'package:admin_keja/common/app_icons.dart';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/database/dboperations.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/models/apartment.dart';
import 'package:admin_keja/models/home.dart';
import 'package:admin_keja/models/tenant.dart';
import 'package:admin_keja/models/transaction.dart';
import 'package:admin_keja/ui/tenant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Apartment extends StatefulWidget {
  Apartment({
    Key key,
    this.passedList,
    this.apartmentId,
    this.month,
  }) : super(key: key);
  List<MyHome> passedList;
  String apartmentId;
  String month;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Apartment> {
  bool check = false;
  bool hasMore = true;
  final dbHelper = DbOperations.instance;
  MyTenant tenant = MyTenant();
  List<MyHome> passedList = List<MyHome>();
  List<MyTenant> tenantList = List<MyTenant>();
  TransactionList transactionList = TransactionList();
  List<MyTransaction> transactions = List<MyTransaction>();
  List<MyTransaction> sortedtransactions = List<MyTransaction>();
  List<MyHome> summary = List<MyHome>();
  List<MyHome> sorted = List<MyHome>();
  MyHomeResponse myHomeResponse = MyHomeResponse();
  TransactionResponse transactionResponse = TransactionResponse();
  MyTenantResponse myTenantResponse = MyTenantResponse();
  var totalExpected = 0, totalPaid = 0, totalDue = 0;
  var apartmentId, companyId;
  int month, sortMonth;
  var year;
  var currDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    summary = widget.passedList;
    apartmentId = widget.apartmentId;
    //alter this to the lowest month in list
    month = currDate.month;
    year = currDate.year;
    sortMonth = month;
    getPrefs();
    sortSummary(summary, month);
    fetchTransactions(apartmentId, month,year);
    fetchSummary(apartmentId, month,year);
    fetchTenants();
    fetchDbTransactions();
    fetchDbTenants();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Apartment'),
            bottom: TabBar(
              tabs: <Widget>[
                Text('Summary'),
                Text('Tenants'),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Center(
                child: ListView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Card(
                        elevation: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(AppIcons.left_open_outline),
                              onPressed: () {
                                if(sortMonth==1){
                                  setState(() {
                                  sortMonth = sortMonth - 1;
                                });
                                fetchMore(summary, sortMonth,year-1);
                                sortSummary(summary, sortMonth);
                                sortTransactions(transactions, sortMonth);
                                }
                                else{
                                  setState(() {
                                  sortMonth = sortMonth - 1;
                                });
                                fetchMore(summary, sortMonth,year);
                                sortSummary(summary, sortMonth);
                                sortTransactions(transactions, sortMonth);
                                }
                               
                              },
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Center(
                                    child: Text(DateFormat.MMM().format(DateTime.parse(
                                year.toString() +
                                    '0' +
                                    sortMonth.toString() +
                                    '01'))+' '+year.toString()),
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('Expected: '),
                                        Text(totalExpected.toString()),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('paid: '),
                                        Text(totalPaid.toString())
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('due: '),
                                        Text(totalDue.toString()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(AppIcons.right_open_outline),
                              onPressed: () {
                                setState(() {
                                  sortMonth = sortMonth + 1;
                                });
                                sortSummary(summary, sortMonth);
                                sortTransactions(transactions, sortMonth);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    transactions != null && transactions.isNotEmpty
                        ? Container(
                            child: DataTable(
                              columnSpacing: 15.0,
                              columns: [
                                DataColumn(
                                  label: Text('unit'),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Text('Trasaction'),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Text('Date paid'),
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
                          )
                        : Text('Empty')
                  ],
                ),
              ),
              tenantList != null && tenantList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(8),
                      itemCount: tenantList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Tenant(
                                    apartmentId: apartmentId,
                                    myTenant: tenantList.elementAt(index))));
                          },
                          child: Container(
                            color: tenantList.elementAt(index).payed != '0'
                                ? Colors.white
                                : Colors.red,
                            child: ListTile(
                              title: Text(tenantList.elementAt(index).name),
                              subtitle: Text(tenantList.elementAt(index).email),
                              trailing: Text(
                                tenantList.elementAt(index).photo,
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ),
                        );
                      })
                  : Center(child: Text('empty')),
            ],
          )),
    );
  }

  Future<void> fetchTenants() async {
    var result = await NetworkApi().fetchTenants('3'); //update the parameter
    print(result);
    var Map = json.decode(result);
    myTenantResponse = MyTenantResponse.fromJson(Map);
    insertTenant(myTenantResponse.data.tenants);
    fetchDbTenants();
  }

  Future<void> fetchTransactions(var apartmentId, var month,var year) async {
    var result = await NetworkApi().fetchTransactions(apartmentId, month,year.toString());
    print(result);
    var Map = json.decode(result);
    transactionResponse = TransactionResponse.fromJson(Map);
    insertTransaction(transactionResponse.data.transactions);
    fetchDbTransactions();
  }

  Future<void> fetchSummary(var apartmentId, var month,var year) async {
    var result = await NetworkApi().fetchApartmentSummary(apartmentId, month,year.toString());
    print(result);
    var Map = json.decode(result);
    myHomeResponse = MyHomeResponse.fromJson(Map);
    insertHome(myHomeResponse.data.myhomes);
    fetchDbHome();
  }

  void populateSummary(List<MyHome> myHomeList) {
    if (myHomeList != null) {
      if (myHomeList.isNotEmpty) {
        setState(() {
          for (var i = 0; i < myHomeList.length; i++) {
            summary.add(myHomeList.elementAt(i));
          }
        });
      } else {
        setState(() {
          hasMore = false;
        });
      }
    }
  }

  void transactionSummary(List<MyTransaction> transactionList) {
    if (transactionList != null) {
      if (transactionList.isNotEmpty) {
        setState(() {
          for (var i = 0; i < transactionList.length; i++) {
            transactions.add(transactionList.elementAt(i));
          }
        });
      }
    }
  }

  void sortSummary(List<MyHome> values, var mnth) {
    setState(() {
      if (mnth <= month) {
        sorted.clear();
        sortMonth = mnth;
        for (var i = 0; i < values.length; i++) {
          if (values.elementAt(i).month == '0' + mnth.toString()) {
            sorted.add(values.elementAt(i));
            totalDue = int.parse(values.elementAt(i).due);
            totalExpected = int.parse(values.elementAt(i).expected);
            totalPaid = int.parse(values.elementAt(i).paid);
          } else {
            totalDue = 0;
            totalExpected = 0;
            totalPaid = 0;
          }
        }
      }
    });
  }

  void sortTransactions(List<MyTransaction> values, var mnth) {
    setState(() {
      if (mnth <= month) {
        sortedtransactions.clear();
        sortMonth = mnth;
        for (var i = 0; i < transactions.length; i++) {
          if (values.elementAt(i).month == '0' + mnth.toString()) {
            year = values.elementAt(i).year;
            sortedtransactions.add(transactions.elementAt(i));
          }
        }
      }
    });
  }

  void fetchMore(List<MyHome> values, var month,var year) {
    if (hasMore) {
      for (int i = 0; i < values.length; i++) {
        if (values.elementAt(i).month == '0' + month.toString()) {
          if (i == values.length - 1) {
            fetchSummary(apartmentId, month - 1,year);
            fetchTransactions(companyId, month,year);
          }
        }
      }
    }
  }

  void getPrefs() {
    companyId = sharedPreferences.getCompanyId();
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

  Future<void> fetchDbHome() async {
    var res = await dbHelper.fetchHome();
    populateSummary(res);
  }

  void insertTransaction(List<MyTransaction> mytransactions) async {
    for (int i = 0; i < mytransactions.length; i++) {
      MyTransaction mytrans = MyTransaction();
      mytrans.id = mytransactions.elementAt(i).id;
      mytrans.user_id = mytransactions.elementAt(i).user_id;
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
    var res = await dbHelper.fetchTransactions(apartmentId);
    transactionSummary(res);
  }

  void insertTenant(List<MyTenant> mytenants) async {
    for (int i = 0; i < mytenants.length; i++) {
      MyTenant tenant = MyTenant();
      tenant.id = mytenants.elementAt(i).id;
      tenant.apartment_id = mytenants.elementAt(i).apartment_id;
      tenant.photo = mytenants.elementAt(i).photo;
      tenant.email = mytenants.elementAt(i).email;
      tenant.name = mytenants.elementAt(i).name;
      tenant.payed = mytenants.elementAt(i).payed;
      tenant.unit = mytenants.elementAt(i).unit;
      final id = await dbHelper.insertTenant(tenant);
      print('inserted row id: $id');
    }
  }

  Future<void> fetchDbTenants() async {
    var res = await dbHelper.fetchTenants(apartmentId);
    setState(() {
      tenantList = res;
    });
  }
}
