import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

class MyDrawerHeader extends StatelessWidget {
  const MyDrawerHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: DrawerHeader(
        decoration: BoxDecoration(
          color: kPrimaryColor,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/user.jpg'),
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Facundo Seib",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 30,
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
