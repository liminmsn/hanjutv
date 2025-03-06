import 'dart:async';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hanjutv/api/api_detail_one.dart';
import 'package:hanjutv/api/api_play.dart';
import 'package:video_player/video_player.dart';

class DetailPlay extends StatefulWidget {
  final ApiDetailItemTwoTagJishu playJi;
  const DetailPlay({super.key, required this.playJi});

  @override
  State<DetailPlay> createState() => _DetailPlayState();
}

class _DetailPlayState extends State<DetailPlay> {
  //初始化视频对象
  late PlayItem playItem = PlayItem.init();
  //hls视频控制器
  late VideoPlayerController _controller;
  //进度条控制器
  late ValueNotifier<Duration> _videoProgressNotifier;
  //进度条拖动时更新视频的播放进度
  void _onSliderChanged(Duration newPosition) {
    _videoProgressNotifier.value = newPosition;
    _controller.seekTo(newPosition);
  }

  //加载url视频
  playHls(String url) {
    _controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        setState(() {});
        //显示控件
        setState(() => showCont = true);
        // _controller.play();
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
        setState(() => playItem = res);
        playHls(playItem.url);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //是否播放状态
  late bool isPlay = false;
  //是否全屏状态
  late bool isFull = false;
  //是否显示控件
  late bool showCont = false;

  @override
  Widget build(BuildContext context) {
    final iconSize = MediaQuery.of(context).size.height * 0.04;
    final labelSize = MediaQuery.of(context).size.height * 0.018;
    final labelWidth = MediaQuery.of(context).size.height * 0.08;
    final TextStyle textWhite = TextStyle(
      color: Colors.white,
      fontSize: labelSize,
    );
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: Colors.black,
            child: GestureDetector(
              onTap: () {
                setState(() => showCont = !showCont);
              },
              child: Stack(
                children: [
                  FractionallySizedBox(
                    heightFactor: 1,
                    widthFactor: 1,
                    child: Align(
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                  if (showCont)
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
                                    size: iconSize,
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
                          if (_controller.value.isInitialized == false)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SpinKitDualRing(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.primaryContainer,
                                  size: 40,
                                ),
                                SizedBox(height: 20),
                                Text("loding...", style: textWhite),
                              ],
                            ),
                          if (_controller.value.isInitialized &&
                              _controller.value.isBuffering == false &&
                              showCont)
                            IconButton(
                              onPressed: () {
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  _controller.play();
                                }
                                setState(() => isPlay = !isPlay);
                              },
                              icon: Icon(
                                isPlay ? Icons.pause_circle : Icons.play_circle,
                                color: Colors.white,
                                size: iconSize * 3,
                              ),
                            ),
                          Spacer(),
                          // 显示进度条
                          if (showCont)
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
                                  padding: EdgeInsets.all(10),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      SizedBox(
                                        width: labelWidth,
                                        child: Text(
                                          currentPosition
                                              .toString()
                                              .split('.')
                                              .first,
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
                                        width: labelWidth,
                                        child: Text(
                                          duration.toString().split('.').first,
                                          style: textWhite,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (isFull) {
                                            appWindow.restore(); // 最小化窗口
                                          } else {
                                            appWindow.maximize();
                                          }
                                          setState(() => isFull = !isFull);
                                        },
                                        icon: Icon(
                                          isFull
                                              ? Icons.fullscreen_exit
                                              : Icons.fullscreen,
                                          size: iconSize,
                                          color: Colors.white,
                                        ),
                                      ),
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
          );
        },
      ),
    );
  }
}
