/// songName : "Agar Tum Saath Ho"
/// movieName : "Tamasha (2015)"
/// duration : "05:41"
/// url : "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3"
/// imageUrl : ""

class MusicData {
  MusicData({
      String? songName, 
      String? movieName, 
      String? duration, 
      String? url, 
      String? imageUrl,}){
    _songName = songName;
    _movieName = movieName;
    _duration = duration;
    _url = url;
    _imageUrl = imageUrl;
}

  MusicData.fromJson(dynamic json) {
    _songName = json['songName'];
    _movieName = json['movieName'];
    _duration = json['duration'];
    _url = json['url'];
    _imageUrl = json['imageUrl'];
  }
  String? _songName;
  String? _movieName;
  String? _duration;
  String? _url;
  String? _imageUrl;
MusicData copyWith({  String? songName,
  String? movieName,
  String? duration,
  String? url,
  String? imageUrl,
}) => MusicData(  songName: songName ?? _songName,
  movieName: movieName ?? _movieName,
  duration: duration ?? _duration,
  url: url ?? _url,
  imageUrl: imageUrl ?? _imageUrl,
);
  String? get songName => _songName;
  String? get movieName => _movieName;
  String? get duration => _duration;
  String? get url => _url;
  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['songName'] = _songName;
    map['movieName'] = _movieName;
    map['duration'] = _duration;
    map['url'] = _url;
    map['imageUrl'] = _imageUrl;
    return map;
  }

}