import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'comman/comman.dart';
import 'model/MusicData.dart';
import 'music_details.dart';

class MusicList extends StatefulWidget {
  const MusicList({Key? key}) : super(key: key);

  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  List<MusicData> musicDataList = [];

  @override
  void initState() {
    createMusicList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "Music Player",
          style: TextStyle(fontSize: 17),
        )),
        body: Center(
            child: Container(
          child: ListView.builder(
              itemCount: musicDataList.length,
              itemBuilder: (BuildContext context, int index) {
                MusicData musicData = musicDataList[index];
                // Map data = staticData[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MusicDetails(
                                  musicDataList: musicDataList,
                                  index: index,
                                )));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 40.0,
                      backgroundImage:
                          NetworkImage(musicData.imageUrl.toString()),
                    ),
                    title: Comman.TextComman(
                        musicData.songName!, FontWeight.bold, Colors.black, 13),
                    subtitle: Comman.TextComman(musicData.movieName!,
                        FontWeight.normal, Colors.grey, 13),
                    trailing: Comman.TextComman(musicData.duration!,
                        FontWeight.normal, Colors.grey, 12),
                  ),
                );
              }),
        )));
  }

  void createMusicList() {
    musicDataList.add(MusicData(
        songName: "Seemayen Bulayen Tujhe",
        movieName: "LOC Kargil",
        duration: "07:45",
        url:
            "https://firebasestorage.googleapis.com/v0/b/fluttermusicplayer-2f965.appspot.com/o/01%20%20Seemayen%20Bulayen%20Tujhe%20-%20www.downloadming.com.mp3?alt=media&token=1fcb949b-9f94-4e6b-bbfe-44d5ff38971f",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/fluttermusicplayer-2f965.appspot.com/o/LOC_Kargil_poster.jpg?alt=media&token=1d55ca80-79e4-4d1c-bfd4-7f7ad7a92151"));
    musicDataList.add(MusicData(
        songName: "Chak De India",
        movieName: "Chak De India",
        duration: "04:44",
        url:
            "https://firebasestorage.googleapis.com/v0/b/fluttermusicplayer-2f965.appspot.com/o/Chak%20De%20India(Ghantalele.com).mp3?alt=media&token=802f8673-02fd-4928-8985-500b94bf9fc1",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/fluttermusicplayer-2f965.appspot.com/o/chak_de_india.jpg?alt=media&token=4b03347e-4239-4074-aa7e-9e7b4fba2d52"));
    musicDataList.add(MusicData(
        songName: "Komuram Bheemudo",
        movieName: "RRR",
        duration: "04:14",
        url:
            "https://firebasestorage.googleapis.com/v0/b/fluttermusicplayer-2f965.appspot.com/o/Komuram%20Bheemudo%20-%20Rrr%20Hindi(Ghantalele.com).mp3?alt=media&token=c01b4c37-ca84-493b-830c-611d8649d852",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/fluttermusicplayer-2f965.appspot.com/o/RRR_Poster.jpg?alt=media&token=9dd5a69e-ecf4-45cd-a46e-d28fb6be4181"));
    musicDataList.add(MusicData(
        songName: "Mere Watan",
        movieName: "Mere Watan",
        duration: "03:55",
        url:
            "https://firebasestorage.googleapis.com/v0/b/fluttermusicplayer-2f965.appspot.com/o/Mere%20Watan%20(Sad)(Ghantalele.com).mp3?alt=media&token=a54e944b-8339-4200-8531-e6f58f435a53",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/fluttermusicplayer-2f965.appspot.com/o/Aye-Mere-Watan-Ke-Logo.jpg?alt=media&token=4d6137fe-2ef7-4086-a76f-e104c7d4f0c5"));

    musicDataList.add(MusicData(
        songName: "Soch Na Sake",
        movieName: "Airlift",
        duration: "04:41",
        url:
            "https://firebasestorage.googleapis.com/v0/b/fluttermusicplayer-2f965.appspot.com/o/Soch%20Na%20Sake%20(Male)(Ghantalele.com).mp3?alt=media&token=dfd19d1c-f87d-4e16-b1ab-ddc546c746f1",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/fluttermusicplayer-2f965.appspot.com/o/Airlift.jpg?alt=media&token=a85cb992-02e3-484e-95e6-98c1d8ff839a"));
  }
}
