class Album {
  final Artists artists;
  final MyImage images;
  final String sample;
  final String albumName;

  Album({this.artists, this.images, this.sample, this.albumName});

  Album.fromJson(Map<String, dynamic> json)
      : artists = Artists.fromJson(json['artists'][0]),
        images = MyImage.fromJson(json['images'][0]),
        sample = json['tracks']['items'][0]['preview_url'],
        albumName = json['name'];
}

class MyImage {
  final String url;

  MyImage({this.url});

  MyImage.fromJson(Map<String, dynamic> json) : url = json['url'];
}

class Artists {
  final String name;

  Artists({this.name});

  Artists.fromJson(Map<String, dynamic> json) : name = json['name'];
}
