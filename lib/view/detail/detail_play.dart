import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hanjutv/api/api_detail_one.dart';
import 'package:hanjutv/api/api_play.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_control_panel/video_player_control_panel.dart';
import 'package:video_player_win/video_player_win_plugin.dart';

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
  playHls(String url) async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(url));
    await _controller.initialize();
    //显示控件
    setState(() => showCont = true);
    // _controller.play();
    // 定期更新视频播放进度
    _controller.addListener(() {
      if (_controller.value.isInitialized && _controller.value.isPlaying) {
        _videoProgressNotifier.value = _controller.value.position;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _videoProgressNotifier = ValueNotifier(Duration.zero);
    if (!kIsWeb && Platform.isWindows) WindowsVideoPlayer.registerWith();
    playHls(
      "https://videos.pexels.com/video-files/30284412/12981695_2560_1440_30fps.mp4",
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
    return Scaffold(
      body: JkVideoControlPanel(
        _controller,
        showClosedCaptionButton: true,
        showFullscreenButton: true,
        showVolumeButton: true,

        // // onPrevClicked: optional. If provided, a [previous] button will shown
        // onPrevClicked:
        //     (nowPlayIndex <= 0)
        //         ? null
        //         : () {
        //           playPrevVideo();
        //         },

        // // onNextClicked: optional. If provided, a [next] button will shown
        // onNextClicked:
        //     (nowPlayIndex >= g_playlist.length - 1)
        //         ? null
        //         : () {
        //           playNextVideo();
        //         },

        // // onPlayEnded: optional, called when the current media is play to end.
        // onPlayEnded: () {
        //   playNextVideo();
        // },
      ),
      // child: Align(
      //   child: AspectRatio(
      //     aspectRatio: _controller.value.aspectRatio,
      //     child: VideoPlayer(_controller),
      //   ),
      // ),
    );
  }
}
