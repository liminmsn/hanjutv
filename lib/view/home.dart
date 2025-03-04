import 'package:flutter/material.dart';
import 'package:hanjutv/api/api_home.dart';

class ViewHome extends StatefulWidget {
  const ViewHome({super.key});

  @override
  State<ViewHome> createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  List<YCard> listycar = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.minWidth >= 600 ? 3 : 2, // 每行显示的列数
                crossAxisSpacing: 2, // 列之间的水平间距
                mainAxisSpacing: 2, // 行之间的垂直间距
              ),
              itemCount: 20, // 网格项数量
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.blue[100 * (index % 9)], // 每个网格项颜色
                  child: Center(child: Text('Item $index')),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
