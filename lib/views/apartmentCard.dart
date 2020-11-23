import 'package:admin_keja/common/styles.dart';
import 'package:admin_keja/models/apartment.dart';
import 'package:admin_keja/utility/utility.dart';
import 'package:admin_keja/views/richtext.dart';
import 'package:flutter/material.dart';
import 'package:admin_keja/constants/constant.dart';

class ApartmentCard extends StatelessWidget {
  const ApartmentCard({
    Key key,
    this.itemIndex,
    this.apartment,
    this.press,
  }) : super(key: key);

  final int itemIndex;
  final MyApartment apartment;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      height: 160,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              height: 136,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: itemIndex.isEven ? kBlueColor : kSecondaryColor,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 160,
                width: 200,
                child:apartment.banner==null || apartment.banner.isEmpty ?
                Image.asset('assets/images/pin7.jpg',
                  fit: BoxFit.cover,
                )
                 : Image.memory(
                    Utility.dataFromBase64String(apartment.banner),
                    height: 150.0,
                    width: 150.0,
                    fit: BoxFit.cover,
                  ), 
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 140,
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                       //Spacer(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                            child: Text(
                              apartment.title,
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Styles.primaryFontColor,fontSize: 16.0,
              fontWeight: FontWeight.w700,),
                            ),
                          ),
                          RichTextArea(
                            title: '',
                            txt: apartment.category,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.mode_comment,
                                size: Styles.h4,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                apartment.comments,
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
                                apartment.likes,
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
                                apartment.rating,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Styles.h4,
                                    fontWeight: Styles.lightFont),
                              )
                            ],
                          ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5, // 30 padding
                        vertical: kDefaultPadding / 4, // 5 top and bottom
                      ),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text('KSh '+apartment.price,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}