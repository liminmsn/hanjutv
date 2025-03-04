import 'package:http/http.dart' as http;

class Yrequest {
  late String url;
  Yrequest({this.url = "https://www.hanju5.com/"});
  Future then([Function(http.Response res)? call]) async {
    var res = await http.get(Uri.parse(url));
    return res;
  }
}
