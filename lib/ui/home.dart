import 'dart:convert';
import 'package:admin_keja/common/styles.dart';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/database/dboperations.dart';
import 'package:admin_keja/models/home.dart';
import 'package:admin_keja/ui/apartment.dart';
import 'package:admin_keja/utility/utility.dart';
import 'package:admin_keja/views/customAppBar.dart';
import 'package:admin_keja/views/richtext.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key, this.companyId, this.myHomeSummary}) : super(key: key);
  List<MyHomeSummary> myHomeSummary;
  var companyId;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  final dbHelper = DbOperations.instance;
  bool show;
  bool hasMore = true;
  bool homelistInitialized = false;
  var companyId;
  var month, sortMonth, year, sortYear;
  var totalExpected = 0, totalPaid = 0, totalDue = 0;
  MyHomeSummary summary = MyHomeSummary();
  List<MyHome> sorted = List<MyHome>();
  List<MyHomeSummary> summarys = List<MyHomeSummary>();
  MyHomeResponse myHomeResponse = MyHomeResponse();
  var currDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    companyId = widget.companyId;
    month = currDate.month;
    year = currDate.year;
    sortYear = year;
    sortMonth = month;
    summarys = widget.myHomeSummary;
    show = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    companyId = widget.companyId;
    if (!homelistInitialized) {
      summarys = widget.myHomeSummary;
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomBarWidget(
        height: 150,
        sortMonth: summary.month,
        year: summary.year,
        totalDue: summary.due,
        totalExpected: summary.expected,
        totalPaid: summary.paid,
        nextPressed: () {
          if (month <= currDate.month) {
            if (month == Constants.dec) {
              sort(summarys, '01', year+1);
            } else {
              sort(summarys, month + 1, year);
            }
          }
        },
        prevPressed: () {
          if (month == Constants.jan) {
              sort(summarys, '12', year-1);
            } else {
              sort(summarys, month - 1, year);
            }
        },
      ),
      body: summary != null
          ? SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: size.height - 200,
                    child: ListView.builder(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(8),
                        itemCount: sorted.length,
                        itemBuilder: (BuildContext context, int index) {
                          return viewCard(index);
                        }),
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  GestureDetector viewCard(var index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Apartment(
                  month: summary.month,
                  apartmentId: sorted.elementAt(index).apartment_id,
                  passedList:
                      passList(sorted, sorted.elementAt(index).apartment_id),
                )));
      },
      child: Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                blurRadius: 4,
                offset: Offset(0, 4))
          ]),
          child: Stack(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  sorted.elementAt(index).banner != null &&
                          sorted.elementAt(index).banner.isNotEmpty
                      ? Container(
                          height: 150.0,
                          width: 150.0,
                          color: Colors.black87,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ))
                      : Image.memory(
                          Utility.dataFromBase64String(
                              sorted.elementAt(index).banner),
                          height: 150.0,
                          width: 150.0,
                          fit: BoxFit.cover,
                        ),
                  Expanded(
                    child: Container(
                      height: 150.0,
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            sorted.elementAt(index).title,
                            style: TextStyle(
                                color: Styles.primaryFontColor,
                                fontSize: Styles.h3,
                                fontWeight: Styles.lightFont),
                          ),
                          RichTextArea(
                            title: 'Expected: ',
                            txt: sorted.elementAt(index).expected,
                          ),
                          RichTextArea(
                            title: 'Paid: ',
                            txt: sorted.elementAt(index).paid,
                          ),
                          RichTextArea(
                            title: 'Due: ',
                            txt: sorted.elementAt(index).due,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }

  void sort(List<MyHomeSummary> summarys, var mnth, var year) {
    setState(() {
      month = mnth;
      year = year;
      if (summarys != null && summarys.isNotEmpty) {
        for (int i = 0; i < summarys.length; i++) {
          if (summarys.elementAt(i).month == mnth &&
              summarys.elementAt(i).year == year) {
            summary = summarys.elementAt(i);
          }
        }
      }
    });
    fetchDbHome();
  }

  List<MyHome> passList(List<MyHome> values, var selectedId) {
    List<MyHome> pass = List<MyHome>();
    for (var i = 0; i < values.length; i++) {
      if (values.elementAt(i).apartment_id == selectedId) {
        pass.add(values.elementAt(i));
      }
    }
    return pass;
  }

  Future<void> fetchDbHome() async {
    var res = await dbHelper.fetchHome(month, year);
    setState(() {
      sorted = res;
    });
    sort(summarys, month, year);
  }
}
