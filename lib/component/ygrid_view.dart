import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hanjutv/api/api_home.dart';
import 'package:hanjutv/component/ycard.dart';
import 'package:hanjutv/view/detail/detail_one.dart';

class YgridView extends StatelessWidget {
  final List<YCardITem> ycardList;
  final ScrollController? scrollController;
  const YgridView(this.ycardList, {super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    const double speed = 4;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: EdgeInsets.only(left: speed, right: speed),
          height: MediaQuery.of(context).size.height,
          child:
              ycardList.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SpinKitRotatingCircle(
                        //   color: Theme.of(context).colorScheme.primaryContainer,
                        // ),
                        SpinKitDualRing(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          size: 40,
                        ),
                        SizedBox(height: 20),
                        Text("loding..."),
                      ],
                    ),
                  )
                  : Column(
                    children: [
                      SizedBox(height: speed),
                      Expanded(
                        child: GridView.builder(
                          controller: scrollController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 3 / 5,
                                crossAxisCount:
                                    constraints.minWidth <= 500
                                        ? 2
                                        : constraints.maxWidth <= 800
                                        ? 4
                                        : constraints.maxWidth <= 1500
                                        ? 5
                                        : 6, // 每行显示的列数
                                crossAxisSpacing: speed,
                                mainAxisSpacing: speed,
                              ),
                          itemCount: ycardList.length, // 网格项数量
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => DetailOne(
                                          yCardITem: ycardList[index],
                                        ),
                                  ),
                                );
                              },
                              child: Ycard(item: ycardList[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
        );
      },
    );
  }
}
