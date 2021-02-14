import 'package:admin_keja/common/styles.dart';
import 'package:admin_keja/database/databasehelper.dart';
import 'package:admin_keja/management/management.dart';
import 'package:admin_keja/views/richtext.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:admin_keja/constants/constant.dart';

class ApartmentCard extends StatelessWidget {
  ApartmentCard({
    Key key,
    this.itemIndex,
    this.apartment,
    this.press,
    this.vacant,
  }) : super(key: key);

  final int itemIndex;
  final MyApartmentTableData apartment;
  final Function press;
  final Function vacant;
  Constants constants = Constants();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      height: 180,
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
                  height: 180,
                  width: 200,
                  child: CachedNetworkImage(
                    imageUrl: constants.path +
                        sharedPreferences.getCompanyId() +
                        constants.folder +
                        apartment.banner,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                        alignment: Alignment(0.0, 2.0),
                        child: Center(child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) => Container(
                        alignment: Alignment(0.0, 2.0),
                        child: Image.asset(
                          'assets/images/placeholder.png',
                          fit: BoxFit.fitWidth,
                        )),
                  )),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 160,
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Text(
                      apartment.title,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Styles.primaryFontColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        RichTextArea(
                          title: '',
                          txt: apartment.category,
                        ),
                      ],
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
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5.0,0,5,0),
                          child: SizedBox(
                            height: 10,
                            width: 10,
                            child: Checkbox(
                                value: apartment.vacant,
                                onChanged: vacant
                                ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'vacant',
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
                      child: Text(
                        'KSh ' + apartment.price,
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
