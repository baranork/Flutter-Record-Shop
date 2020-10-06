import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/components/my_bottom_navbar.dart';
import 'package:shop_app/components/my_drawer_header.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: buildAppBar(_key),
      drawer: drawer(),
      body: Body(),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }

  AppBar buildAppBar(GlobalKey<ScaffoldState> globalKey) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {
          globalKey.currentState.openDrawer();
        },
      ),
    );
  }

  Drawer drawer() {
    return Drawer(
      child: Container(
        color: kBackgroundColor,
        child: ListView(
          children: [
            MyDrawerHeader(),
            ListTile(
              leading: Icon(
                Icons.home,
                color: kPrimaryColor.withOpacity(0.5),
              ),
              title: Text("Home"),
            ),
            ListTile(
              leading: Icon(Icons.apps),
              title: Text("All plats"),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Liked"),
            ),
            ListTile(
              leading: Icon(Icons.local_shipping),
              title: Text("Shippment"),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("About"),
            ),
          ],
        ),
      ),
    );
  }
}
