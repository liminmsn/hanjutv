import 'package:flutter/material.dart';
import 'package:hanjutv/api/api_movie.dart';
import 'package:hanjutv/component/ygrid_view.dart';
import 'package:hanjutv/interface/main_tv_move.dart';

class ViewMovie extends StatefulWidget {
  const ViewMovie({super.key});

  @override
  State<ViewMovie> createState() => _MovieState();
}

class _MovieState extends State<ViewMovie> with MainTvMove {
  @override
  fetchData(url) async {
    setState(() {
      ycardList = [];
      ytags = [];
    });
    var data = await ApiTMovie.getData(url);
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
