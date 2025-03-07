import 'package:hanjutv/api/api_home.dart';
import 'package:hanjutv/api/api_tv_drama.dart';

mixin MainTvMove {
  late List<YCardITem> ycardList = [];
  late List<YTags> ytags = [];
  Future<void> fetchData(String? url);
}
