import 'package:flutter/material.dart';
import 'package:hanjutv/api/api_home.dart';
import 'package:hanjutv/component/ygrid_view.dart';
import 'package:hanjutv/interface/main_scroll_contoller.dart';

class ViewHome extends MainScrollContoller {
  const ViewHome({super.key, required super.scrollController});

  @override
  State<ViewHome> createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  late List<YCardITem> ycardList = [];
  fetchData() async {
    var data = await ApiHome.getData();
    setState(() {
      ycardList = data;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return YgridView(ycardList, scrollController: widget.scrollController);
  }
}
