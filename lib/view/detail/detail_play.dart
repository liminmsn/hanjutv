import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hanjutv/api/api_detail_one.dart';
import 'package:hanjutv/api/api_play.dart';
import 'package:hanjutv/main.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

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
  // Create a [Player] to control playback.
  late final player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    ApiPlay.getData(widget.playJi.url).then((res) {
      if (res != null) {
        player.open(Media("https://v.cdnlz22.com/20250123/11624_66060547/index.m3u8"));
        // player.open(Media("https://videos.pexels.com/video-files/30284412/12981695_2560_1440_30fps.mp4"));
        // setState(() => playItem = res);
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (Platform.isWindows) TopBar(),
          Expanded(child: Video(controller: controller)),
        ],
      ),
    );
  }
}
