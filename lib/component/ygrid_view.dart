import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hanjutv/api/api_home.dart';
import 'package:hanjutv/api/api_tv_drama.dart';
import 'package:hanjutv/component/ycard.dart';
import 'package:hanjutv/view/detail/detail_one.dart';

class YgridView extends StatelessWidget {
  final List<YCardITem> ycardList;
  final ScrollController? scrollController;
  final List<YTags>? ytags;
  final Function(String url)? fetchData;
  const YgridView(
    this.ycardList, {
    super.key,
    this.scrollController,
    this.ytags,
    this.fetchData,
  });

  bool isDis(YTags ytags) {
    if (ytags.label == '...') return true;
    if (num.tryParse(ytags.label) != null && ytags.src == 'javascript:;') {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double speed = MediaQuery.of(context).size.height * 0.01;
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
                        Text("加载中..."),
                      ],
                    ),
                  )
                  : Column(
                    children: [
                      if (ytags != null)
                        Flex(
                          direction: Axis.horizontal,
                          spacing: 2,
                          children: [
                            for (var item in ytags!.where((e) {
                              return e.src != 'javascript:;' ||
                                  num.tryParse(e.label) != null ||
                                  e.label == '...';
                            }))
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap:
                                      isDis(item)
                                          ? null
                                          : () {
                                            fetchData!(item.src);
                                          },
                                  child: Container(
                                    padding: EdgeInsets.all(speed * 0.2),
                                    color:
                                        item.label == '...'
                                            ? Theme.of(
                                              context,
                                            ).colorScheme.inversePrimary
                                            : isDis(item)
                                            ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                            : Theme.of(
                                              context,
                                            ).colorScheme.primaryContainer,
                                    child: Text(
                                      item.label,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      // if (ytags == null) SizedBox(height: speed),
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
