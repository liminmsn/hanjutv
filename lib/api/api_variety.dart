import 'package:hanjutv/api/api_home.dart';
import 'package:hanjutv/api/api_tv_drama.dart';
import 'package:hanjutv/net/yrequest.dart';
import 'package:html/parser.dart';

class ApiTVariety {
  late ApiTVarietyItem apiTVarietyItem;
  ApiTVariety(String body) {
    var dom = parse(body);
    var one = dom.getElementsByClassName('fed-list-info')[0];
    var two = dom.getElementsByClassName('fed-page-info')[0];
    var apiTv = ApiTVarietyItem.init();
    //集数列表
    for (var element in one.getElementsByTagName('li')) {
      apiTv.yCardITem.add(
        YCardITem(
          pics:
              element
                  .getElementsByClassName('fed-list-pics')[0]
                  .attributes['data-original'] ??
              '',
          title: element.getElementsByClassName('fed-list-title')[0].text,
          desc: element.getElementsByClassName('fed-list-desc')[0].text,
          score: element.getElementsByClassName('fed-list-score')[0].text,
          src:
              element
                  .getElementsByClassName('fed-list-pics')[0]
                  .attributes['href'] ??
              '',
          remarks: element.getElementsByClassName('fed-list-remarks')[0].text,
        ),
      );
    }
    //分页列表
    for (var element in two.getElementsByTagName('a')) {
      apiTv.one.add(
        YTags(label: element.text, src: element.attributes['href'] ?? ''),
      );
    }
    apiTVarietyItem = apiTv;
  }
  static Future<ApiTVarietyItem> getData(String? url) async {
    String url_ = 'vodtype/hanguozongyi/';
    if (url != null) {
      url_ = url;
    }
    var res = await Yrequest(url: "${Yrequest.url_}$url_").then();
    return ApiTVariety(res.body).apiTVarietyItem;
  }
}

class ApiTVarietyItem {
  final List<YTags> one; //分页
  final List<YCardITem> yCardITem;

  ApiTVarietyItem({required this.one, required this.yCardITem});
  static ApiTVarietyItem init() {
    return ApiTVarietyItem(one: [], yCardITem: []);
  }
}
