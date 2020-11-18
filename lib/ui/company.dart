import 'package:admin_keja/common/styles.dart';
import 'package:admin_keja/models/apartment.dart';
import 'package:admin_keja/models/company.dart';
import 'package:admin_keja/models/status.dart';
import 'package:admin_keja/ui/apartdetails.dart';
import 'package:admin_keja/ui/apartment.dart';
import 'package:admin_keja/utility/utility.dart';
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
        appBar: AppBar(
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

  GestureDetector viewCard(var index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Apartment()));
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
                  /* Image.memory(
                    Utility.dataFromBase64String(apartments.elementAt(index).),
                    height: 150.0,
                    width: 150.0,
                    fit: BoxFit.cover,
                  ), */
                  Expanded(
                    child: Container(
                      height: 150.0,
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            apartments.elementAt(index).title,
                            style: TextStyle(
                                color: Styles.primaryFontColor,
                                fontSize: Styles.h3,
                                fontWeight: Styles.lightFont),
                          ),
                          RichTextArea(
                            title: 'category: ',
                            txt: apartments
                                .elementAt(index)
                                .category,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.mode_comment,
                                size: Styles.h4,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                apartments
                                    .elementAt(index)
                                    .comments,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Styles.h4,
                                    fontWeight: Styles.lightFont),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.favorite_border,
                                size: Styles.h4,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                apartments.elementAt(index).likes,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Styles.h4,
                                    fontWeight: Styles.lightFont),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.star_border,
                                size: Styles.h4,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                apartments
                                    .elementAt(index)
                                    .rating,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Styles.h4,
                                    fontWeight: Styles.lightFont),
                              )
                            ],
                          )
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
}
