import 'dart:math';

import 'package:flutter/material.dart';
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
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return PhotoView(
                      url: snapshot.data.images.url,
                      name: snapshot.data.artists.name,
                      albumName: snapshot.data.albumName,
                    );
                  }));
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

class PhotoView extends StatelessWidget {
  const PhotoView({
    Key key,
    this.url,
    this.name,
    this.albumName,
  }) : super(key: key);

  final String url;
  final String name;
  final String albumName;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: GestureDetector(
        child: Container(
          child: Center(
            child: Hero(
              tag: '$albumName cover',
              child: Image.network(
                url,
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      bottomSheet: Row(
        children: [
          Spacer(),
          Container(
            margin: EdgeInsets.only(bottom: 50),
            height: size.height / 9,
            width: size.width / 1.25,
            alignment: Alignment.center,
            child: Row(
              children: [
                GestureDetector(
                  child: Image.network(
                    'https://www.nmvinc.com/proofs/mckesson/skin/img/play_black@x2.png',
                    scale: 7,
                  ),
                  onTap: () {},
                ),
                Expanded(
                  child: Text(
                    '$name - $albumName',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ],
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
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
