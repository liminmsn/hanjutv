import 'dart:convert';
import 'package:html/parser.dart';
import 'package:hanjutv/net/yrequest.dart';

class ApiPlay {
  late PlayItem playItem;
  ApiPlay(String body) {
    var scriptArr = parse(body).getElementsByTagName('script');

    for (var element in scriptArr) {
      if (element.text.contains('var player_aaaa=')) {
        Map<String, dynamic> jsonMap = jsonDecode(
          element.text.replaceAll('var player_aaaa=', ''),
        );
        var item = PlayItem(
          flag: jsonMap['flag'],
          encrypt: jsonMap['encrypt'],
          trysee: jsonMap['trysee'],
          points: jsonMap['points'],
          link: jsonMap['link'],
          linkNext: jsonMap['link_next'],
          vodData: VodData(
            vodName: jsonMap['vod_data']['vod_name'],
            vodActor: jsonMap['vod_data']['vod_actor'],
            vodDirector: jsonMap['vod_data']['vod_director'],
            vodClass: jsonMap['vod_data']['vod_class'],
          ),
          url: Uri.decodeFull(jsonMap['url']),
          urlNext: Uri.decodeFull(jsonMap['url_next']),
          from: jsonMap['from'],
          server: jsonMap['server'],
          note: jsonMap['note'],
          id: jsonMap['id'],
          sid: jsonMap['sid'],
          nid: jsonMap['nid'],
        );
        playItem = item;
      }
    }
  }
  static Future<PlayItem?> getData(url) async {
    var res = await Yrequest(url: '${Yrequest.url_}/$url').then();
    ApiPlay(res.body).playItem;
    return null;
  }
}

class PlayItem {
  String flag;
  int encrypt;
  int trysee;
  int points;
  String link;
  String linkNext;
  VodData vodData;
  String url;
  String urlNext;
  String from;
  String server;
  String note;
  String id;
  int sid;
  int nid;

  // 构造函数
  PlayItem({
    required this.flag,
    required this.encrypt,
    required this.trysee,
    required this.points,
    required this.link,
    required this.linkNext,
    required this.vodData,
    required this.url,
    required this.urlNext,
    required this.from,
    required this.server,
    required this.note,
    required this.id,
    required this.sid,
    required this.nid,
  });
}

class VodData {
  String vodName;
  String vodActor;
  String vodDirector;
  String vodClass;

  VodData({
    required this.vodName,
    required this.vodActor,
    required this.vodDirector,
    required this.vodClass,
  });
}
