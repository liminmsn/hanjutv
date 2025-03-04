import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hanjutv/api/api_home.dart';
import 'package:hanjutv/component/ycard.dart';

class ViewHome extends StatefulWidget {
  const ViewHome({super.key});

  @override
  State<ViewHome> createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  List<YCardITem> listycar = [];

  fetchData() async {
    var data = await ApiHome.getData();
    setState(() {
      listycar = data;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double speed = 4;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: EdgeInsets.all(speed + 6),
          height: MediaQuery.of(context).size.height,
          child:
              listycar.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitRotatingCircle(
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        // SpinKitDualRing(
                        //   color: Theme.of(context).colorScheme.primaryContainer,
                        //   size: 40,
                        // ),
                        SizedBox(height: 20),
                        Text("loding..."),
                      ],
                    ),
                  )
                  : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 5,
                      crossAxisCount:
                          constraints.minWidth <= 500
                              ? 2
                              : constraints.maxWidth <= 800
                              ? 3
                              : constraints.maxWidth <= 1500
                              ? 5
                              : 6, // 每行显示的列数
                      crossAxisSpacing: speed,
                      mainAxisSpacing: speed,
                    ),
                    itemCount: listycar.length, // 网格项数量
                    itemBuilder:
                        (context, index) => Ycard(item: listycar[index]),
                  ),
        );
      },
    );
  }
}
