import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shop_app/components/social_button_bar.dart';
import 'package:shop_app/components/star_rating.dart';
import 'package:shop_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/bb_model.dart';
import 'dart:convert';
import 'dart:async';

class FeaturedRecords extends StatefulWidget {
  const FeaturedRecords({
    Key key,
  }) : super(key: key);

  @override
  _FeaturedRecordsState createState() => _FeaturedRecordsState();
}

class _FeaturedRecordsState extends State<FeaturedRecords> {
  List<Future<Album>> records = new List<Future<Album>>();

  @override
  void initState() {
    super.initState();

    records.add(getRecord());
    records.add(getRecord());
    records.add(getRecord());
    records.add(getRecord());
    records.add(getRecord());
    records.add(getRecord());
    records.add(getRecord());
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var record in records) RecordWidget(record: record),
        ],
      ),
    );
  }
}

String getRandomSearch() {
  // A list of all characters that can be chosen.
  const characters = 'abcdefghijklmnopqrstuvwxyz';
  Random random = new Random();
  // Gets a random character from the characters string.
  var randomCharacter = characters[random.nextInt(characters.length)];
  var randomSearch = '';

  // Places the wildcard character at the beginning, or both beginning and end, randomly.
  switch (random.nextInt(1)) {
    case 0:
      randomSearch = randomCharacter + '%';
      break;
    case 1:
      randomSearch = '%' + randomCharacter + '%';
      break;
  }

  return randomSearch;
}

int getRandomOffset() {
  Random random = new Random();

  return random.nextInt(500);
}

Future<Album> getRecord() async {
  String clientId = "98580eabbb11402aadb9190a07c1e5ad";
  String clientSecret = '0947c8f97fbd4031a21158aee5cb0541';
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  String token;
  String id;
  String randomSearch = getRandomSearch();
  int randomOffset = getRandomOffset();

  try {
    final futureToken = await http.post(
      Uri.encodeFull('https://accounts.spotify.com/api/token'),
      body: {'grant_type': 'client_credentials'},
      headers: {
        'Authorization':
            'Basic ' + stringToBase64.encode('$clientId:$clientSecret')
      },
    );
    token = jsonDecode(futureToken.body)['access_token'] as String;
  } on Exception catch (e) {
    print(e);
  }

  final randomResponse = await http.get(
    Uri.encodeFull(
        'https://api.spotify.com/v1/search?q=$randomSearch&type=album&market=us&limit=1&offset=$randomOffset'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (randomResponse.statusCode == 200) {
    id = json.decode(randomResponse.body)['albums']['items'][0]['id'] as String;
  } else {
    print(randomResponse.statusCode);
  }

  final response = await http.get(
    Uri.encodeFull('https://api.spotify.com/v1/albums/$id/'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw new Exception('Error: ' + response.statusCode.toString());
  }
}

class RecordWidget extends StatelessWidget {
  const RecordWidget({
    Key key,
    this.record,
  }) : super(key: key);

  final Future<Album> record;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FutureBuilder<Album>(
          future: record,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FeaturedRecordCard(
                imagePath: snapshot.data.images.url,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return PhotoView(
                          url: snapshot.data.images.url,
                          name: snapshot.data.artists.name,
                          albumName: snapshot.data.albumName,
                          previewUrl: snapshot.data.sample,
                          releaseDate: snapshot.data.releaseDate,
                          popularity: (snapshot.data.popularity / 20).round(),
                          trackList: snapshot.data.trackList,
                        );
                      },
                    ),
                  );
                },
              );
            } else {
              return Container(
                child: Text('No data'),
              );
            }
          },
        ),
      ],
    );
  }
}

class _PhotoViewState extends State<PhotoView> {
  AssetsAudioPlayer _assetsAudioPlayer;
  List<PaletteColor> colorPalette;
  var isPreviewNull = true;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    colorPalette = [];
    updatePalette();
    _assetsAudioPlayer = AssetsAudioPlayer();

    if (widget.previewUrl != null) {
      _assetsAudioPlayer.open(
        Audio.network(widget.previewUrl),
        autoStart: false,
      );
      isPreviewNull = false;
    }
  }

  updatePalette() async {
    final PaletteGenerator generator =
        await PaletteGenerator.fromImageProvider(NetworkImage(widget.url));
    colorPalette.add(generator.dominantColor != null
        ? generator.dominantColor
        : generator.vibrantColor);
    setState(() {});
  }

  bool isNull() {
    if (widget.previewUrl == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _assetsAudioPlayer.stop();
    _assetsAudioPlayer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: kBackgroundColor,
            shape: BoxShape.rectangle,
          ),
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  height: size.width + 35,
                  child: Stack(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 20,
                        left: 10,
                        right: 10,
                      ),
                      height: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(63),
                          bottomRight: Radius.circular(63),
                        ),
                        image: DecorationImage(
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.url),
                        ),
                      ),
                    ),
                    !isNull()
                        ? Container(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: kBackgroundColor,
                                    borderRadius: BorderRadius.circular(100)),
                                child: GestureDetector(
                                  child: _assetsAudioPlayer.builderIsPlaying(
                                      builder: (context, isPlaying) {
                                    return Icon(
                                        isPlaying
                                            ? Icons.pause_circle_filled
                                            : Icons.play_circle_filled,
                                        size: 65,
                                        color: colorPalette.isNotEmpty &&
                                                colorPalette[0]
                                                        .color
                                                        .computeLuminance() <
                                                    0.75
                                            ? colorPalette[0].color
                                            : Colors.black);
                                  }),
                                  onTap: () {
                                    _assetsAudioPlayer.playOrPause();
                                  },
                                ),
                              ),
                            ),
                          )
                        : Container()
                  ]),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                width: size.width,
                margin: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.albumName,
                      style: GoogleFonts.nobile(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 5),
                      child: Row(
                        children: [
                          Container(
                            width: size.width / 2,
                            child: Text(
                              widget.name,
                              style: GoogleFonts.nobile(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "(" + widget.releaseDate.substring(0, 4) + ")",
                            style: GoogleFonts.nobile(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: Colors.black38,
                            ),
                          )
                        ],
                      ),
                    ),
                    StarDisplay(
                      value: widget.popularity,
                      size: 18,
                    )
                  ],
                ),
              ),
              SocialButtonBar(
                colorPalette: colorPalette,
                scaffoldKey: _scaffoldKey,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red.shade200,
                  ),
                  child: Row(
                    children: [
                      Text(
                        widget.trackList[2].name,
                      ),
                      Spacer(),
                      Text(milisecondsToTimeStamp(
                          widget.trackList[2].durationMs))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String milisecondsToTimeStamp(int duration) {
  var minutes = (duration / 60000).floor();
  var seconds = ((duration % 60000) / 1000).toStringAsFixed(0);

  return '$minutes:$seconds';
}

class PhotoView extends StatefulWidget {
  final String url;
  final String name;
  final String albumName;
  final String previewUrl;
  final String releaseDate;
  final int popularity;
  final List<Track> trackList;

  const PhotoView({
    Key key,
    this.url,
    this.name,
    this.albumName,
    this.previewUrl,
    this.releaseDate,
    this.popularity,
    this.trackList,
  }) : super(key: key);

  @override
  _PhotoViewState createState() => _PhotoViewState();
}

class FeaturedRecordCard extends StatelessWidget {
  const FeaturedRecordCard({
    Key key,
    this.imagePath,
    this.press,
  }) : super(key: key);

  final String imagePath;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
        ),
        width: size.width * 0.8,
        height: 185,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.network(imagePath).image,
            )),
      ),
    );
  }
}
