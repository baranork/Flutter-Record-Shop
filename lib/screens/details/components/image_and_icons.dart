import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/details/components/icon_card.dart';

class ImageAndIcons extends StatelessWidget {
  const ImageAndIcons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding * 1.75),
      child: Container(
        height: size.height / 1.35,
        child: SizedBox(
          height: size.height * 0.74,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding * 3),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          icon: SvgPicture.asset('assets/icons/back_arrow.svg'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Spacer(),
                      IconCard(iconPath: 'assets/icons/sun.svg'),
                      IconCard(iconPath: 'assets/icons/icon_2.svg'),
                      IconCard(iconPath: 'assets/icons/icon_3.svg'),
                      IconCard(iconPath: 'assets/icons/icon_4.svg'),
                    ],
                  ),
                ),
              ),
              Container(
                height: size.height * 0.8,
                width: size.width * 0.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(63),
                    bottomLeft: Radius.circular(63),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      color: kPrimaryColor.withOpacity(0.22),
                      blurRadius: 60,
                    ),
                  ],
                  image: DecorationImage(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/image_4.jpeg'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
