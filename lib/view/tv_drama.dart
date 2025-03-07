import 'package:flutter/material.dart';
import 'package:hanjutv/api/api_tv_drama.dart';
import 'package:hanjutv/component/ygrid_view.dart';
import 'package:hanjutv/interface/main_tv_move.dart';

class ViewTvDrama extends StatefulWidget {
  const ViewTvDrama({super.key});

  @override
  State<ViewTvDrama> createState() => _TvDramaState();
}

class _TvDramaState extends State<ViewTvDrama> with MainTvMove {
  @override
  fetchData(url) async {
    setState(() {
      ycardList = [];
      ytags = [];
    });
    var data = await ApiTvDrama.getData(url);
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
    fetchData(null);
  }

  @override
  Widget build(BuildContext context) {
    return YgridView(ycardList, ytags: ytags, fetchData: fetchData);
  }
}
