import 'package:admin_keja/blocs/tenantBloc.dart';
import 'package:admin_keja/blocs/transactionsBloc.dart';
import 'package:admin_keja/common/app_icons.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/database/dao.dart';
import 'package:admin_keja/database/databasehelper.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/tenant.dart';
import 'package:admin_keja/utility/connectioncallback.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Apartment extends StatefulWidget {
  Apartment({
    Key key,
    this.apartmentId,
    this.month,
    this.year,
    this.title,
  }) : super(key: key);
  String apartmentId;
  String title;
  String month;
  String year;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Apartment> {
  var dao = DatabaseDao(databasehelper);
  Constants constants = Constants();
  int selected_index = 0;
  var apartmentId;
  String month;
  String title;
  var year;
  MyTenantBloc myTenantBloc;
  MyTransactionsBloc myTransactionsBloc;

  @override
  void initState() {
    super.initState();
    myTenantBloc = MyTenantBloc();
    myTransactionsBloc = MyTransactionsBloc();
    apartmentId = widget.apartmentId;
    month = widget.month;
    year = widget.year;
    title = widget.title;
    myTenantBloc.fetchMyTenants(apartmentId);
    myTransactionsBloc.fetchTransactions(apartmentId, month, year);
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
            backgroundColor: LightColors.kDarkYellow,
            title: Text(title),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.house),
                  text: 'Summary',
                ),
                Tab(
                  icon: Icon(Icons.person),
                  text: 'Tenants',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              StreamBuilder(
                stream: dao.watchApartmentPaymentHistory(apartmentId),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.isNotEmpty) {
                  return ListView(
                    children: <Widget>[
                      ConnectionCallback(
                        onlineCall: () {},
                      ),
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
                                  setState(() {
                    if (selected_index>0) {
                      selected_index = selected_index - 1;
                    }
                  });
                                },
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                      child: Text(DateFormat.MMM().format(
                                                    DateTime.parse(snapshot.data.elementAt(selected_index).year +
                                                        snapshot.data.elementAt(selected_index).month +
                                                        '01')) +
                                                ' ' +
                                                widget.year,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('Expected: '),
                                          Text(snapshot.data.elementAt(selected_index).expected ?? ''),
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('paid: '),
                                          Text(snapshot.data.elementAt(selected_index).paid ?? '')
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('due: '),
                                          Text(snapshot.data.elementAt(selected_index).due ?? ''),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(AppIcons.right_open_outline),
                                onPressed: () {setState(() {
                    if (selected_index < snapshot.data.length-1) {
                      selected_index = selected_index + 1;
                    }
                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                     StreamBuilder(
                       stream: dao.watchApartmentTransactions(apartmentId, 
                       snapshot.data.elementAt(selected_index).month, 
                       snapshot.data.elementAt(selected_index).year),
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
                  ); }
                     )
                    ],
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
                }
              ),
              
              StreamBuilder(
                  stream: dao.watchApartmentTenants(apartmentId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data.isNotEmpty) {
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(8),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Tenant(
                                      apartmentId: apartmentId,
                                      myTenant:
                                          snapshot.data.elementAt(index))));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color:
                                    snapshot.data.elementAt(index).payed != '0'
                                        ? Colors.green
                                        : Colors.red,
                              )),
                              child: ListTile(
                                isThreeLine: true,
                                title:
                                    Text(snapshot.data.elementAt(index).name),
                                subtitle: Text(
                                    snapshot.data.elementAt(index).email +
                                        '\n' +
                                        'unit: ' +
                                        snapshot.data.elementAt(index).unit),
                                trailing: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: CircleAvatar(
                                    radius: 25,
                                                                      backgroundImage: CachedNetworkImageProvider(
                                                                        snapshot.data.elementAt(index).photo,
                                  ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
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
                  })
            ],
          )),
    );
  }
    List<DataRow> getRows(var values) {
    var result = List<DataRow>();
    for (var transaction in values) {
      var row = DataRow(cells: [
        DataCell(
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
}
