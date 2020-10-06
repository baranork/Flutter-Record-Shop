import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constants.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
      ),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: SvgPicture.asset('assets/icons/flower.svg'),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset('assets/icons/heart-icon.svg'),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset('assets/icons/user-icon.svg'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
