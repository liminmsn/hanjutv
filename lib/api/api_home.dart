import 'package:hanjutv/net/yrequest.dart';
import 'package:html/parser.dart';

class ApiHome {
  List<YCardITem> listycar = [];
  ApiHome(String body) {
    var dom = parse(body);
    var ulArr = dom.getElementsByClassName('fed-list-info');
    for (var ul in ulArr) {
      for (var li in ul.children) {
        var ycard = YCardITem(
          pics: li.children[0].attributes['data-original'] ?? 'null',
          src: li.children[0].attributes['href'] ?? 'nul',
          score:
              // ignore: prefer_is_empty
              li.getElementsByClassName('fed-list-score').length > 0
                  ? li.getElementsByClassName('fed-list-score')[0].text
                  : 'null',
          remarks:
              // ignore: prefer_is_empty
              li.getElementsByClassName('fed-list-remarks').length > 0
                  ? li.getElementsByClassName('fed-list-remarks')[0].text
                  : 'none',
          title: li.getElementsByClassName('fed-list-title')[0].text,
          desc:
              // ignore: prefer_is_empty
              li.getElementsByClassName('fed-list-desc').length > 0
                  ? li.getElementsByClassName('fed-list-desc')[0].text
                  : 'none',
        );
        if (ycard.pics != 'null') {
          listycar.add(ycard);
        }
      }
    }
  }
  static Future<List<YCardITem>> getData() async {
    var res = await Yrequest().then();
    var list = ApiHome(res.body).listycar;
    return list;
  }
}

class YCardITem {
  String pics;
  String score;
  String remarks;
  String title;
  String desc;
  String src;
  YCardITem({
    required this.pics,
    required this.score,
    required this.remarks,
    required this.title,
    required this.desc,
    required this.src,
  });

  static init() {
    return YCardITem(
      pics: '',
      score: '',
      remarks: '--',
      title: '--',
      desc: '',
      src: '',
    );
  }
}
