import 'package:hanjutv/api/api_home.dart';
import 'package:hanjutv/net/yrequest.dart';
import 'package:html/parser.dart';

class ApiDetailOne {
  late ApiDetailItemOne apiDetailItemOne;
  late ApiDetailItemTwo apiDetailItemTwo;
  late List<ApiDetailItemThree> apiDetailItemThree = [];
  ApiDetailOne(String body) {
    var dom = parse(body);
    //取详情
    var rows = dom.getElementsByClassName('fed-deta-content')[0];
    rows = rows.getElementsByClassName('fed-part-rows')[0];

    var imgInfo = dom.getElementsByClassName('fed-deta-images')[0];
    apiDetailItemOne = ApiDetailItemOne(
      yCardITem: YCardITem(
        pics:
            imgInfo.getElementsByTagName('a')[0].attributes['data-original'] ??
            '',
        score: '',
        remarks: imgInfo.getElementsByClassName('fed-list-remarks')[0].text,
        title:
            rows
                .getElementsByClassName('fed-part-eone')[0]
                .getElementsByTagName('a')[0]
                .text,
        desc: '',
        src: '',
      ),
      starring: rows.children[0]
          .getElementsByTagName('a')
          .map((a) {
            return a.text;
          })
          .join('\t'),
      director:
          rows.children[1].getElementsByTagName('a').isNotEmpty
              ? rows.children[1].children[1].text
              : rows.children[1].nodes[1].toString().replaceAll('"', ''),
      classify: rows.children[2].children[1].text,
      region: rows.children[3].children[1].text,
      year: rows.children[4].children[1].text,
    );
    //取选集，剧情介绍
    var deta = dom.getElementsByClassName('fed-conv-deta')[0];
    apiDetailItemTwo = ApiDetailItemTwo(
      describes: deta.getElementsByClassName('fed-conv-text')[0].text,
      tags: [],
    );
    //------选集
    var tagArr = deta.children[0].children[0].getElementsByTagName('a');
    var tagUrlArr =
        deta.children[0].children[1].getElementsByClassName('fed-tabs-foot')[0];
    //------tag
    for (var i = 0; i < tagArr.length; i++) {
      var val = ApiDetailItemTwoTag(tag: tagArr[i].text, jishu: []);
      //----tag包含的集数
      var aArr = tagUrlArr.children[i].getElementsByTagName('a');
      for (var a in aArr) {
        var jishu = ApiDetailItemTwoTagJishu(
          name: a.text,
          url: a.attributes['href'] ?? '--',
        );
        val.jishu.add(jishu);
      }
      apiDetailItemTwo.tags.add(val);
    }
    //取推荐列表
    var aArr = dom
        .getElementsByClassName('fed-side-list')[0]
        .getElementsByTagName('ul')[0]
        .getElementsByTagName('a');
    for (var element in aArr) {
      var item = ApiDetailItemThree(
        name: element.nodes.last.toString().replaceAll('"', ''),
        idx: element.children[0].text,
        url: element.attributes['href'] ?? 'null',
      );
      apiDetailItemThree.add(item);
    }
  }
  static Future<ApiDetailOne> getData(String url) async {
    var res = await Yrequest(url: "${Yrequest.url_}$url").then();
    return ApiDetailOne(res.body);
  }
}

class ApiDetailItemOne {
  final YCardITem yCardITem;
  final String starring;
  final String director;
  final String classify;
  final String year;
  final String region;

  ApiDetailItemOne({
    required this.yCardITem,
    required this.director,
    required this.classify,
    required this.year,
    required this.starring,
    required this.region,
  });

  static init() {
    return ApiDetailItemOne(
      yCardITem: YCardITem.init(),
      director: '--',
      classify: '--',
      year: '--',
      starring: '--',
      region: '--',
    );
  }
}

class ApiDetailItemThree {
  final String name;
  final String idx;
  final String url;

  ApiDetailItemThree({
    required this.name,
    required this.idx,
    required this.url,
  });
}

//0包含1、2
class ApiDetailItemTwo {
  final String describes;
  final List<ApiDetailItemTwoTag> tags;

  ApiDetailItemTwo({required this.describes, required this.tags});

  static init() {
    return ApiDetailItemTwo(describes: '--', tags: []);
  }
}

//1包含2
class ApiDetailItemTwoTag {
  final String tag;
  final List<ApiDetailItemTwoTagJishu> jishu;

  ApiDetailItemTwoTag({required this.tag, required this.jishu});
}

//2
class ApiDetailItemTwoTagJishu {
  final String name;
  final String url;
  ApiDetailItemTwoTagJishu({required this.name, required this.url});
}
