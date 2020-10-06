import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import '../../../constants.dart';

class RecomendedPlants extends StatelessWidget {
  const RecomendedPlants({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Function press = () {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => DetailsScreen(),
        ),
      );
    };
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          RecomendedPlantCard(
            title: 'Samantha',
            imagePath: 'assets/images/image_1.png',
            country: 'Russia',
            price: 440,
            press: press,
          ),
          RecomendedPlantCard(
            title: 'Monica',
            imagePath: 'assets/images/image_4.jpeg',
            country: 'Brazil',
            price: 520,
            press: press,
          ),
          RecomendedPlantCard(
            title: 'Angelica',
            imagePath: 'assets/images/image_2.png',
            country: 'Ethiopia',
            price: 499,
            press: () {},
          ),
          RecomendedPlantCard(
            title: 'Julia',
            imagePath: 'assets/images/image_3.png',
            country: 'Malasya',
            price: 350,
            press: () {},
          ),
          RecomendedPlantCard(
            title: 'Aglaonema',
            imagePath: 'assets/images/image_5.jpg',
            country: 'Italy',
            price: 350,
            press: () {},
          ),
        ],
      ),
    );
  }
}

class RecomendedPlantCard extends StatelessWidget {
  const RecomendedPlantCard({
    Key key,
    this.title,
    this.imagePath,
    this.country,
    this.price,
    this.press,
  }) : super(key: key);

  final String title;
  final String imagePath;
  final String country;
  final int price;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      //Covers 40% of the total width
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.asset(
                  imagePath,
                  width: 160,
                  height: 170,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.25))
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "$title\n".toUpperCase(),
                          style: Theme.of(context).textTheme.button,
                        ),
                        TextSpan(
                          text: country.toUpperCase(),
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    "\$$price",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: kPrimaryColor),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
