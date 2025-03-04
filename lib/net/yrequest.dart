import 'package:http/http.dart' as http;

class Yrequest {
  static const url_ = "https://www.hanju5.com/";
  late String url;
  Yrequest({this.url = url_});
  Future<http.Response> then([Function(http.Response res_)? call]) async {
    var res = await http.get(Uri.parse(url));
    return res;
  }
}
