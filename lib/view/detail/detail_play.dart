import 'package:flutter/material.dart';
import 'package:hanjutv/api/api_detail_one.dart';
import 'package:hanjutv/api/api_play.dart';
import 'package:video_player/video_player.dart';

class DetailPlay extends StatefulWidget {
  final ApiDetailItemTwoTagJishu playJi;
  const DetailPlay({super.key, required this.playJi});

  @override
  State<DetailPlay> createState() => _DetailPlayState();
}

const TextStyle textWhite = TextStyle(color: Colors.white);

class _DetailPlayState extends State<DetailPlay> {
  late PlayItem playItem = PlayItem(
    flag: '',
    encrypt: 0,
    trysee: 0,
    points: 0,
    link: '',
    linkNext: '',
    vodData: VodData(vodName: '', vodActor: '', vodDirector: '', vodClass: ''),
    url: '',
    urlNext: '',
    from: '',
    server: '',
    note: '',
    id: '',
    sid: 0,
    nid: 0,
  );
  late VideoPlayerController _controller;
  late ValueNotifier<Duration> _videoProgressNotifier;

  // 进度条拖动时更新视频的播放进度
  void _onSliderChanged(Duration newPosition) {
    _videoProgressNotifier.value = newPosition;
    _controller.seekTo(newPosition);
  }

  playHls(String url) {
    _controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        setState(() {});
        // 初始化完成后自动播放
        _controller.play();
        // 定期更新视频播放进度
        _controller.addListener(() {
          if (_controller.value.isInitialized && _controller.value.isPlaying) {
            _videoProgressNotifier.value = _controller.value.position;
          }
        });
      });
  }

  @override
  void initState() {
    super.initState();
    _videoProgressNotifier = ValueNotifier(Duration.zero);
    playHls(
      "https://videos.pexels.com/video-files/30417137/13034832_1440_2560_30fps.mp4",
    );

    ApiPlay.getData(widget.playJi.url).then((res) {
      if (res != null) {
        setState(() {
          playItem = res;
        });
        playHls(playItem.url);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Align(
          child: Container(
            color: Colors.black,
            child: Stack(
              children: [
                Center(
                  child:
                      _controller.value.isInitialized
                          ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          )
                          : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 10),
                              Text("奋力加载中...", style: textWhite),
                            ],
                          ),
                ),
                Positioned(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                                //返回就销毁视频、进度条控制器
                                _controller.dispose();
                                _videoProgressNotifier.dispose();
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                // size: 40,
                              ),
                            ),
                            if (playItem.vodData.vodName != '')
                              Text(
                                '${playItem.vodData.vodName} ${widget.playJi.name}',
                                style: textWhite,
                              ),
                          ],
                        ),
                      ),
                      Spacer(),
                      // 显示进度条
                      ValueListenableBuilder<Duration>(
                        valueListenable: _videoProgressNotifier,
                        builder: (context, currentPosition, _) {
                          final duration = _controller.value.duration;
                          final progress =
                              duration == Duration.zero
                                  ? 0.0
                                  : currentPosition.inSeconds /
                                      duration.inSeconds;
                          return Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: Text(
                                    currentPosition.toString().split('.').first,
                                    style: textWhite,
                                  ),
                                ),
                                Expanded(
                                  child: Slider(
                                    value: progress,
                                    min: 0.0,
                                    max: 1.0,
                                    onChanged: (value) {
                                      var newPosition = Duration(
                                        seconds:
                                            (value * duration.inSeconds)
                                                .toInt(),
                                      );
                                      _onSliderChanged(newPosition);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                  child: Text(
                                    duration.toString().split('.').first,
                                    style: textWhite,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.scale, color: Colors.white),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
