import 'dart:io';
import 'package:dart_vlc_ffi/dart_vlc_ffi.dart';
import 'package:flutter/material.dart';
import 'package:hanjutv/api/api_detail_one.dart';
import 'package:hanjutv/api/api_play.dart';
import 'package:hanjutv/main.dart';

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
  final _player1 = Player(id: 1);

  @override
  void initState() {
    super.initState();
    // ApiPlay.getData(widget.playJi.url).then((res) {
    //   if (res != null) {
    //     // setState(() => playItem = res);
    //     // playHls(playItem.url);
    //     // playHls(
    //     //   "https://videos.pexels.com/video-files/30284412/12981695_2560_1440_30fps.mp4",
    //     // );
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [if (Platform.isWindows) TopBar(), Expanded(child: Text(""))],
      ),
    );
  }
}
