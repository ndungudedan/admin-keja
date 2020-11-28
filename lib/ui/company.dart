import 'package:admin_keja/common/styles.dart';
import 'package:admin_keja/models/apartment.dart';
import 'package:admin_keja/models/company.dart';
import 'package:admin_keja/models/status.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:admin_keja/ui/apartdetails.dart';
import 'package:admin_keja/ui/apartment.dart';
import 'package:admin_keja/views/apartmentCard.dart';
import 'package:admin_keja/views/richtext.dart';
import 'package:flutter/material.dart';

class Company extends StatefulWidget {
  Company({Key key, this.title, this.apartments,this.status}) : super(key: key);
  List<MyApartment> apartments;
  final String title;
  Status status;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Company> {
  List<MyApartment> apartments = List<MyApartment>();
  MyCompany company = MyCompany();
  Status status = Status();

  @override
  void initState() {
    super.initState();
    apartments = widget.apartments;
    status = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    apartments = widget.apartments;
    status = widget.status;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: LightColors.kLightYellow,
        appBar: AppBar(
          backgroundColor: LightColors.kDarkYellow,
          title: Text('My company'),
          automaticallyImplyLeading: false,
        ),
        body: status != null && apartments != null
            ? ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(8),
                itemCount: apartments.length,
                itemBuilder: (BuildContext context, int index) => ApartmentCard(
                      itemIndex: index,
                      apartment: apartments.elementAt(index),
                      press: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ApartmentDetails(
                                  apartment:
                                      apartments.elementAt(index),
                                )));
                      },
                    ))
            : Center(child: CircularProgressIndicator()));
  }
}
