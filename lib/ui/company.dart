import 'dart:convert';

import 'package:admin_keja/connection/networkapi.dart';
import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/database/dao.dart';
import 'package:admin_keja/database/databasehelper.dart';
import 'package:admin_keja/models/status.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/apartdetails.dart';
import 'package:admin_keja/views/apartmentCard.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

class Company extends StatefulWidget {
  Company({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Company> {
  var dao = DatabaseDao(databasehelper);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: LightColors.kLightYellow,
        appBar: AppBar(
          backgroundColor: LightColors.kDarkYellow,
          title: Text('My company'),
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder(
          stream: dao.watchApartments(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) =>
                      ApartmentCard(
                        itemIndex: index,
                        apartment: snapshot.data.elementAt(index),
                        press: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ApartmentDetails(
                                    apartmentId:
                                        snapshot.data.elementAt(index).onlineid,
                                  )));
                        },
                        vacant: (value) {
                          updateVacant(
                              value, snapshot.data.elementAt(index).onlineid);
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
          },
        ));
  }

  Future<void> updateVacant(bool enabled, var apartmentId) async {
    var result = await NetworkApi().updateVacant(enabled, apartmentId);
    print(result);
    var Map = json.decode(result);
    Status status = Status.fromJson(Map);
    if (status.code == Constants.success) {
      dao.updateVacant(enabled, apartmentId);
      successDialog(context, status.message);
    } else {
      errorDialog(context, status.message);
    }
  }
}
