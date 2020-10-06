import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/home/components/featured_records.dart';
import 'package:shop_app/screens/home/components/header_with_searchbox.dart';
import 'package:shop_app/screens/home/components/title_with_more_btn.dart';

import 'recomended_plants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //It will provide us total heigth and width of our screen
    Size size = MediaQuery.of(context).size;
    //Enables scrolling on small devices
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          TitleWithMoreBtn(title: 'Recomended', press: () {}),
          RecomendedPlants(),
          TitleWithMoreBtn(title: 'Featured Records', press: () {}),
          FeaturedRecords(),
          SizedBox(height: kDefaultPadding)
        ],
      ),
    );
  }
}
