import 'package:admin_keja/database/dao.dart';
import 'package:admin_keja/database/databasehelper.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/apartdetails.dart';
import 'package:admin_keja/views/apartmentCard.dart';
import 'package:flutter/material.dart';

class Company extends StatefulWidget {
  Company({Key key})
      : super(key: key);

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
                                    apartment: snapshot.data.elementAt(index),
                                  )));
                        },
                      ));
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
  }
}
