import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shop_app/constants.dart';

class SocialButtonBar extends StatelessWidget {
  const SocialButtonBar({
    Key key,
    @required this.colorPalette,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final List<PaletteColor> colorPalette;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlatButton(
            color: colorPalette.isNotEmpty &&
                    colorPalette[0].color.computeLuminance() < 0.75
                ? colorPalette[0].color
                : CupertinoColors.darkBackgroundGray,
            splashColor: Colors.grey,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(63)),
            child: Row(
              children: [
                Text('Like', style: TextStyle(color: kBackgroundColor)),
                Icon(
                  Icons.favorite,
                  color: kBackgroundColor,
                ),
              ],
            ),
            onPressed: () {},
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 9, horizontal: 6),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(63)),
            child: Row(
              children: [
                Text('Save'),
                Icon(Icons.bookmark),
              ],
            ),
            onPressed: () {
              final snackBar = SnackBar(
                content: Text('Album Saved!'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );

              // Find the Scaffold in the widget tree and use
              // it to show a SnackBar.
              _scaffoldKey.currentState.showSnackBar(snackBar);
            },
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 9, horizontal: 6),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(63)),
            child: Row(
              children: [
                Text('Share'),
                Icon(Icons.reply),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
