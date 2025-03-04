import 'package:hanjutv/net/yrequest.dart';
import 'package:html/parser.dart';

class ApiHome {
  List<YCard> listycar = [];
  ApiHome(String body) {
    var dom = parse(body);
    var ulArr = dom.getElementsByClassName('fed-list-info');
    for (var ul in ulArr) {
      for (var li in ul.children) {
        var ycard = YCard(
          pics: li.children[0].attributes['data-original']?[0] ?? '',
          score: li.children[0].children[1].text,
          remarks: li.children[0].children[2].text,
          title: li.children[1].text,
          desc: li.children[2].text,
          src: li.children[1].attributes['href']?[0] ?? '',
        );
        listycar.add(ycard);
      }
    }
  }
  static Future<List<YCard>> getData() async {
    var res = await Yrequest().then();
    return res;
  }
}

class YCard {
  String pics;
  String score;
  String remarks;
  String title;
  String desc;
  String src;
  YCard({
    required this.pics,
    required this.score,
    required this.remarks,
    required this.title,
    required this.desc,
    required this.src,
  });
}
