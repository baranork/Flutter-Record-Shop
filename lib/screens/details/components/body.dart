import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/details/components/image_and_icons.dart';
import 'package:shop_app/screens/details/components/title_and_price.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            ImageAndIcons(),
            TitleAndPrice(title: "Monica", country: 'Brazil', price: 520),
            SizedBox(height: kDefaultPadding),
            BuyAndInfoBtn(),
          ],
        ),
      ),
    );
  }
}

class BuyAndInfoBtn extends StatelessWidget {
  BuyAndInfoBtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.bottomCenter,
      height: size.height / 12,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: size.width / 2,
            height: 84,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                ),
              ),
              onPressed: () {},
              child: Text(
                'Buy Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              color: kPrimaryColor,
            ),
          ),
          Expanded(
            child: Container(
              height: 84,
              child: FlatButton(
                onPressed: () {},
                child: Text("Description"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
