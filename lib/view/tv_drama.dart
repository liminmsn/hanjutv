import 'package:flutter/material.dart';
import 'package:hanjutv/api/api_home.dart';
import 'package:hanjutv/api/api_tv_drama.dart';
import 'package:hanjutv/component/ygrid_view.dart';

class TvDrama extends StatefulWidget {
  const TvDrama({super.key});

  @override
  State<TvDrama> createState() => _TvDramaState();
}

class _TvDramaState extends State<TvDrama> {
  late List<YCardITem> ycardList = [];
  late List<YTags> ytags = [];
  fetchData() async {
    var data = await ApiTvDrama.getData();
    if (mounted) {
      setState(() {
        ycardList = data.yCardITem;
        ytags = data.one;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return YgridView(ycardList, ytags: ytags);
  }
}
