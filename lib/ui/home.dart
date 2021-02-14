import 'package:admin_keja/database/dao.dart';
import 'package:admin_keja/database/databasehelper.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/apartment.dart';
import 'package:admin_keja/views/customAppBar.dart';
import 'package:admin_keja/views/homeText.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  var dao = DatabaseDao(databasehelper);
  int touchedIndex;
  int selected_index = 0;
  var month, year;
  var currDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    month = currDate.month;
    year = currDate.year;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: dao.watchHomeSummary(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.isNotEmpty) {
          return Scaffold(
              backgroundColor: LightColors.kLightYellow,
              appBar: CustomBarWidget(
                height: 150,
                sortMonth: snapshot.data.elementAt(selected_index).month ??
                    currDate.month.toString(),
                year: snapshot.data.elementAt(selected_index).year ??
                    currDate.year.toString(),
                totalDue: snapshot.data.elementAt(selected_index).due ?? '',
                totalExpected:
                    snapshot.data.elementAt(selected_index).expected ?? '',
                totalPaid: snapshot.data.elementAt(selected_index).paid ?? '',
                nextPressed: () {
                  setState(() {
                    if (selected_index < snapshot.data.length-1) {
                      selected_index = selected_index + 1;
                    }
                  });
                },
                prevPressed: () {
                  setState(() {
                    if (selected_index>0) {
                      selected_index = selected_index - 1;
                    }
                  });
                  
                },
              ),
              body: StreamBuilder(
                stream: dao.watchPaymentHistory(
                    snapshot.data.elementAt(selected_index).month,
                    snapshot.data.elementAt(selected_index).year),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.isNotEmpty) {
                    return SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Container(
                        height: size.height - 200,
                        child: ListView.builder(
                            shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.all(8),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return viewCard(snapshot.data.elementAt(index));
                            }),
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
                },
              ));
              } else if (snapshot.hasError) {
                    return Center(
                                    child: Image.asset('assets/images/no_data.jpg'),
                                  );
                  } else if (snapshot.data != null && snapshot.data.isEmpty) {
                    return Center(
                                    child: Image.asset('assets/images/no_data.jpg'),
                                  );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
        });
  }

  GestureDetector viewCard(MyPaymentHistoryTableData myHome) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Apartment(
                  title: myHome.title,
                  month: myHome.month,
                  year: myHome.year,
                  apartmentId: myHome.apartment_id,
                )));
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 15.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
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
                            sections: showingSections(
                              myHome.paid,
                              myHome.due,
                              myHome.expected,
                            )),
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
                            myHome.title,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          HomeTextArea(
                            colorHex: 0xff13d38e,
                            title: 'Expected: ',
                            txt: myHome.expected,
                          ),
                          HomeTextArea(
                            colorHex: 0xff0293ee,
                            title: 'Paid: ',
                            txt: myHome.paid,
                          ),
                          HomeTextArea(
                            colorHex: 0xfff8b250,
                            title: 'Due: ',
                            txt: myHome.due,
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
