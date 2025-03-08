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
  late PlayItem playItem = PlayItem.init();
  late final player = Player();
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    ApiPlay.getData(widget.playJi.url).then((res) {
      if (res != null) {
        setState(() {
          playItem = res;
          player.open(Media(playItem.url));
        });
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
          TopBar(
            showBack: true,
            title: '${playItem.vodData.vodName} ${widget.playJi.name}',
          ),
          Expanded(
            child: Video(
              controller: controller,
              filterQuality: FilterQuality.low,
            ),
          ),
        ],
      ),
    );
  }
}
