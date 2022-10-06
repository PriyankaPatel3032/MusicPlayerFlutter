import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_player_flutter/comman/comman.dart';
import 'package:music_player_flutter/page_manager.dart';
import 'dart:math' as math;
import 'model/MusicData.dart';

class MusicDetails extends StatefulWidget {
  List<MusicData>? musicDataList;

  int? index;

  MusicDetails({Key? key, this.musicDataList, this.index}) : super(key: key);

  @override
  _MusicDetailsState createState() => _MusicDetailsState();
}

class _MusicDetailsState extends State<MusicDetails>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 5))
        ..repeat();

  late final PageManager _pageManager;
  late MusicData musicData;
  int currentIndex = 0;

  @override
  void initState() {
    _pageManager = PageManager();

    currentIndex = widget.index!;
    musicData = widget.musicDataList![widget.index!];
    _pageManager.setAudioData(widget.musicDataList![widget.index!].url!);
    super.initState();
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_drop_down_circle_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    Comman.TextComman(
                        "Now Playing", FontWeight.bold, Colors.white, 18),
                    Text("")
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimatedBuilder(
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * math.pi,
                    child: child,
                  );
                },
                animation: _controller,
                child: Stack(
                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage:
                            NetworkImage(musicData.imageUrl.toString()),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Comman.TextComman(
                musicData.songName!, FontWeight.bold, Colors.white, 17),

            SizedBox(
              height: 15,
            ),

            Comman.TextComman(
                musicData.movieName!, FontWeight.normal, Colors.grey, 15),

            SizedBox(height: 15),

            //AudioProgressBar
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: ValueListenableBuilder<ProgressBarState>(
                  valueListenable: _pageManager.progressNotifier,
                  builder: (_, value, __) {
                    return Column(
                      children: [
                        ProgressBar(
                          thumbColor: Colors.white,
                          thumbGlowColor: Colors.white,
                          bufferedBarColor: Colors.grey,
                          progressBarColor: Colors.white,
                          baseBarColor: Colors.grey,
                          timeLabelLocation: TimeLabelLocation.none,
                          progress: value.current,
                          buffered: value.buffered,
                          total: value.total,
                          onSeek: _pageManager.seek,
                        ),
                        Row(
                          children: [
                            Text(
                              _getTimeString(value.current, value.total),
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              _getTimeString(value.total, value.total),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        )
                      ],
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 15),

            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //PreviousSongButton
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _pageManager.isFirstSongNotifier,
                      builder: (_, isFirst, __) {
                        return IconButton(
                            icon: Icon(Icons.skip_previous,
                                color: Colors.white, size: 30),
                            onPressed: () {
                              setState(() {
                                currentIndex = currentIndex - 1;

                                if (currentIndex >= 0) {
                                  musicData =
                                      widget.musicDataList![currentIndex];
                                  _pageManager.setAudioData(musicData.url!);
                                }
                              });
                            });
                      },
                    ),
                  ),

                  //PlayButton
                  ValueListenableBuilder<ButtonState>(
                    valueListenable: _pageManager.playButtonNotifier,
                    builder: (_, value, __) {
                      switch (value) {
                        case ButtonState.loading:
                          return Container(
                            margin: EdgeInsets.all(8.0),
                            width: 32.0,
                            height: 32.0,
                            child: CircularProgressIndicator(),
                          );
                        case ButtonState.paused:
                          return IconButton(
                            icon: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            iconSize: 50.0,
                            onPressed: _pageManager.play,
                          );
                        case ButtonState.playing:
                          return IconButton(
                            icon: Icon(Icons.pause, color: Colors.white),
                            iconSize: 50.0,
                            onPressed: _pageManager.pause,
                          );
                      }
                    },
                  ),

                  //NextSongButton
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _pageManager.isLastSongNotifier,
                      builder: (_, isLast, __) {
                        return IconButton(
                            icon: Icon(
                              Icons.skip_next,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                currentIndex = currentIndex + 1;

                                if (currentIndex <=
                                    widget.musicDataList!.length - 1) {
                                  musicData =
                                      widget.musicDataList![currentIndex];
                                  _pageManager.setAudioData(musicData.url!);
                                }
                              });
                            });
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getTimeString(Duration time, Duration total) {
    final minutes = time.inMinutes
        .remainder(Duration.minutesPerHour)
        .toString()
        .padLeft(2, '0');
    final seconds = time.inSeconds
        .remainder(Duration.secondsPerMinute)
        .toString()
        .padLeft(2, '0');
    final hours = total.inHours > 0 ? '${time.inHours}:' : '';
    return "$hours$minutes:$seconds";
  }
}
