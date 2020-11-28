import 'dart:convert';
import 'package:admin_keja/common/styles.dart';
import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/database/dboperations.dart';
import 'package:admin_keja/models/home.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/apartment.dart';
import 'package:admin_keja/utility/utility.dart';
import 'package:admin_keja/views/customAppBar.dart';
import 'package:admin_keja/views/homeText.dart';
import 'package:admin_keja/views/richtext.dart';
import 'package:fl_chart/fl_chart.dart';
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
  bool homelistInitialized = false;
  var companyId;
  int touchedIndex;
  int selected_index = 0;
  var month, year;
  MyHomeSummary summary = MyHomeSummary();
  List<MyHome> sorted = List<MyHome>();
  List<MyHomeSummary> summarys = List<MyHomeSummary>();
  var currDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    companyId = widget.companyId;
    month = currDate.month;
    year = currDate.year;
    summarys = widget.myHomeSummary;
    show = false;
    sort(selected_index);
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
      if(summarys!=null && summarys.isNotEmpty){
        summary = summarys.elementAt(selected_index);
        sort(selected_index);
      }
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:LightColors.kLightYellow,
      appBar: CustomBarWidget(
        height: 150,
        sortMonth: summary.month ?? currDate.month.toString(),
        year: summary.year ?? currDate.year.toString(),
        totalDue: summary.due ?? '',
        totalExpected: summary.expected ?? '',
        totalPaid: 
        summary.paid ?? '',
        nextPressed: () {
          sort(selected_index + 1);
        },
        prevPressed: () {
          sort(selected_index - 1);
        },
      ),
      body: sorted != null &&sorted.isNotEmpty
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
              title: sorted.elementAt(index).title,
                  month: summary.month,
                  year: summary.year,
                  apartmentId: sorted.elementAt(index).apartment_id,
                )));
      },
      child: Container(
margin: EdgeInsets.symmetric(vertical: 15.0),         
decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0)),
          child: Stack(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                            pieTouchData:
                                PieTouchData(touchCallback: (pieTouchResponse) {
                              setState(() {
                                if (pieTouchResponse.touchInput
                                        is FlLongPressEnd ||
                                    pieTouchResponse.touchInput is FlPanEnd) {
                                  touchedIndex = -1;
                                } else {
                                  touchedIndex =
                                      pieTouchResponse.touchedSectionIndex;
                                }
                              });
                            }),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 20,
                            sections: showingSections(sorted.elementAt(index).paid,
                            sorted.elementAt(index).due,sorted.elementAt(index).expected,)),
                      ),
                    ),
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
                            style: TextStyle(fontSize: 16.0,
              fontWeight: FontWeight.w700,),
                          ),
                          HomeTextArea(
                            colorHex: 0xff13d38e,
                            title: 'Expected: ',
                            txt: sorted.elementAt(index).expected,
                          ),
                          HomeTextArea(
                            colorHex: 0xff0293ee,
                            title: 'Paid: ',
                            txt: sorted.elementAt(index).paid,
                          ),
                          HomeTextArea(
                            colorHex: 0xfff8b250,
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

  void sort(int index) {
    setState(() {
      if (index < summarys.length && index >= 0) {
        selected_index = index;
        summary = summarys.elementAt(index);
      }
    });
    if (summary.month == null) {
      fetchDbHome(month, year);
    } else {
      fetchDbHome(summary.month, summary.year);
    }
  }

  Future<void> fetchDbHome(var month, var year) async {
    var res = await dbHelper.fetchHome(month, year);
    setState(() {
      sorted = res;
    });
  }

  List<PieChartSectionData> showingSections(var paid, var due, var expected) {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      final double paid_perc =
          (double.parse(paid) * 100) / double.parse(expected).round();
          final double due_perc =
          (double.parse(due) * 100) / double.parse(expected).round();
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: paid_perc,
            title: paid_perc.roundToDouble().toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: due_perc,
            title: due_perc.roundToDouble().toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
