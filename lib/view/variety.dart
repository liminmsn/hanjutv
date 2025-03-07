import 'package:flutter/material.dart';
import 'package:hanjutv/api/api_Variety.dart';
import 'package:hanjutv/component/ygrid_view.dart';
import 'package:hanjutv/interface/main_tv_move.dart';

class ViewVariety extends StatefulWidget {
  const ViewVariety({super.key});

  @override
  State<ViewVariety> createState() => _VarietyState();
}

class _VarietyState extends State<ViewVariety> with MainTvMove {
  @override
  fetchData(url) async {
    setState(() {
      ycardList = [];
      ytags = [];
    });
    var data = await ApiTVariety.getData(url);
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
