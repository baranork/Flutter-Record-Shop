class Album {
  final Artists artists;
  final MyImage images;
  final String sample;
  final String albumName;
  final String releaseDate;
  final int popularity;
  final int totalTracks;
  final List<Track> trackList;

  Album(
      {this.artists,
      this.totalTracks,
      this.trackList,
      this.images,
      this.sample,
      this.albumName,
      this.popularity,
      this.releaseDate});

  factory Album.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['tracks']['items'] as List;
    List<Track> trackList = list.map((i) => Track.fromJson(i)).toList();

    return Album(
        artists: Artists.fromJson(parsedJson['artists'][0]),
        images: MyImage.fromJson(parsedJson['images'][0]),
        sample: parsedJson['tracks']['items'][0]['preview_url'],
        albumName: parsedJson['name'],
        releaseDate: parsedJson['release_date'],
        popularity: parsedJson['popularity'],
        totalTracks: parsedJson['tracks']['total'],
        trackList: trackList);
  }
}

class TrackList {
  final List<Track> tracks;

  TrackList({
    this.tracks,
  });

  factory TrackList.fromJson(List<dynamic> parsedJson) {
    List<Track> tracks = new List<Track>();
    tracks = parsedJson.map((i) => Track.fromJson(i)).toList();

    return new TrackList(tracks: tracks);
  }
}

class Track {
  final String name;
  final int durationMs;
  final String previewUrl;
  final bool isExplicit;
  final int trackNumber;

  Track({
    this.name,
    this.durationMs,
    this.previewUrl,
    this.isExplicit,
    this.trackNumber,
  });

  Track.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        durationMs = json['duration_ms'],
        previewUrl = json['preview_url'],
        isExplicit = json['explicit'] as bool,
        trackNumber = json['track_number'];
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
