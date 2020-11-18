import 'dart:convert';
import 'package:admin_keja/common/styles.dart';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/database/dboperations.dart';
import 'package:admin_keja/models/home.dart';
import 'package:admin_keja/ui/apartment.dart';
import 'package:admin_keja/utility/utility.dart';
import 'package:admin_keja/views/customAppBar.dart';
import 'package:admin_keja/views/richtext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Home({Key key, this.myHomeList, this.companyId}) : super(key: key);
  List<MyHome> myHomeList;
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
  List<MyHome> summary = List<MyHome>();
  List<MyHome> sorted = List<MyHome>();
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
    populateSummary(widget.myHomeList);
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
      populateSummary(widget.myHomeList);
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomBarWidget(
        height: 150,
        sortMonth: sortMonth,
        summary: summary,
        year: year,
        totalDue: totalDue,
        totalExpected: totalExpected,
        totalPaid: totalPaid,
        nextPressed: () {
          sort(summary, sortMonth + 1);
        },
        prevPressed: () {
          if(sortMonth==1){
            fetchMore(summary, sortMonth - 1, year-1);
          sort(summary, sortMonth - 1);
          }else{
            fetchMore(summary, sortMonth - 1, year);
          sort(summary, sortMonth - 1);
          }        },
      ),
      body: summary != null && summary.isNotEmpty
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
                  month: summary.elementAt(index).month,
                  apartmentId: summary.elementAt(index).apartment_id,
                  passedList:
                      passList(summary, summary.elementAt(index).apartment_id),
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

  Future<void> fetchHome(var companyId, var month, var year) async {
    var result = await NetworkApi().fetchHome(companyId, month, year.toString());
    print(result);
    var Map = json.decode(result);
    myHomeResponse = MyHomeResponse.fromJson(Map);
    insertHome(myHomeResponse.data.myhomes);
    fetchDbHome();
  }

  void populateSummary(List<MyHome> myHomeList) {
    if (myHomeList != null) {
      if (myHomeList.isNotEmpty) {
        homelistInitialized = true;
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
    sort(summary, sortMonth);
  }

  void sort(List<MyHome> values, var mnth) {
    setState(() {
      var due = 0;
      var expected = 0;
      var paid = 0;
      if (values != null && values.isNotEmpty) {
        if (mnth <= month) {
          sorted.clear();
          sortMonth = mnth;
          for (int i = 0; i < values.length; i++) {
            var c = values.elementAt(i).month;
            if (values.elementAt(i).month == '0' + mnth.toString()) {
              year =int.parse(values.elementAt(i).year);
              dbHelper
                  .fetchSingleImage('image0', values.elementAt(i).apartment_id)
                  .then((value) => {updateState(i, value, values)});
              due = due + int.parse(values.elementAt(i).due);
              expected = expected + int.parse(values.elementAt(i).expected);
              paid = paid + int.parse(values.elementAt(i).paid);
            }
          }
          totalDue = due;
          totalExpected = expected;
          totalPaid = paid;
        } else {}
      }
    });
  }

  void updateState(var index, var value, var values) {
    setState(() {
      values.elementAt(index).banner = value;
      sorted.add(values.elementAt(index));
    });
  }

  void fetchMore(List<MyHome> values, var month, var year) {
    if (hasMore) {
      for (int i = 0; i < values.length; i++) {
        if (values.elementAt(i).month == '0' + month.toString()) {
          if (i == values.length - 1) {
            fetchHome(companyId, month - 1, year);
          }
        }
      }
    }
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
}
