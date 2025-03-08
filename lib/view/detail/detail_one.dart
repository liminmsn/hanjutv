import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hanjutv/api/api_detail_one.dart';
import 'package:hanjutv/api/api_home.dart';
import 'package:hanjutv/main.dart';
import 'package:hanjutv/view/detail/detail_play.dart';

class DetailOne extends StatefulWidget {
  final YCardITem yCardITem;
  const DetailOne({super.key, required this.yCardITem});

  @override
  State<DetailOne> createState() => _DetailOneState();
}

class _DetailOneState extends State<DetailOne> {
  late ApiDetailItemOne apiDetailItemOne = ApiDetailItemOne.init();
  late ApiDetailItemTwo apiDetailItemTwo = ApiDetailItemTwo.init();
  late List<ApiDetailItemThree> apiDetailItemThree = [];

  fetchData() {
    ApiDetailOne.getData(widget.yCardITem.src).then((res) {
      setState(() {
        apiDetailItemOne = res.apiDetailItemOne;
        apiDetailItemTwo = res.apiDetailItemTwo;
        apiDetailItemThree = res.apiDetailItemThree;
      });
    });
  }

  openPlay(ApiDetailItemTwoTagJishu ji) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPlay(playJi: ji)),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final titleSize = MediaQuery.of(context).size.height * 0.05;
    final h3Size = MediaQuery.of(context).size.height * 0.02;
    final maxWidth = MediaQuery.of(context).size.width * 0.15;
    return Scaffold(
      body: Column(
        children: [
          TopBar(showBack: true, title: widget.yCardITem.title),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.96,
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Expanded(
                          flex: 2,
                          child: FractionallySizedBox(
                            widthFactor: 1,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(h3Size),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 300),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      SizedBox(
                                        width: maxWidth,
                                        height: maxWidth * 1.5,
                                        child:
                                            apiDetailItemOne.yCardITem.pics !=
                                                    ''
                                                ? Image.network(
                                                  apiDetailItemOne
                                                      .yCardITem
                                                      .pics,
                                                )
                                                : Container(
                                                  color:
                                                      Theme.of(
                                                        context,
                                                      ).colorScheme.primary,
                                                ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: EdgeInsets.all(h3Size),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                apiDetailItemOne
                                                    .yCardITem
                                                    .title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: titleSize,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '演员：${apiDetailItemOne.starring}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: h3Size,
                                                ),
                                              ),
                                              Text(
                                                '导演：${apiDetailItemOne.director}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: h3Size,
                                                ),
                                              ),
                                              Text(
                                                '类型：${apiDetailItemOne.classify}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: h3Size,
                                                ),
                                              ),
                                              Text(
                                                '年份：${apiDetailItemOne.year}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: h3Size,
                                                ),
                                              ),
                                              Spacer(),
                                              if (apiDetailItemTwo
                                                  .tags
                                                  .isNotEmpty)
                                                Card(
                                                  clipBehavior: Clip.antiAlias,
                                                  color:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .primaryContainer,
                                                  child: InkWell(
                                                    onTap: () {
                                                      openPlay(
                                                        apiDetailItemTwo
                                                            .tags[0]
                                                            .jishu[0],
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                        MediaQuery.of(
                                                              context,
                                                            ).size.height *
                                                            0.01,
                                                      ),
                                                      child: Text("立即播放"),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Text(
                                            '区域：${apiDetailItemOne.region}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: h3Size * 1.2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: FractionallySizedBox(
                            widthFactor: 1,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(h3Size),
                                child: Column(
                                  children: [
                                    YToggleLabel(
                                      h3Size: h3Size,
                                      labelArr: ["选集播放", "视频介绍"],
                                      widgetArr: [
                                        YAnalecta(
                                          h3Size: h3Size,
                                          apiDetailItemTwo: apiDetailItemTwo,
                                          openPlay: openPlay,
                                        ),
                                        YDescribes(
                                          h3Size: h3Size,
                                          apiDetailItemTwo: apiDetailItemTwo,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FractionallySizedBox(
                      heightFactor: 1,
                      child: Card(
                        child: ListView.builder(
                          itemCount: apiDetailItemThree.length,
                          itemBuilder: (context, index) {
                            return ListBody(
                              children: [
                                ListTile(
                                  title: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            var ycard = YCardITem.init();
                                            ycard.src =
                                                apiDetailItemThree[index].url;
                                            return DetailOne(yCardITem: ycard);
                                          },
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        MouseRegion(
                                          child: Transform.rotate(
                                            angle:
                                                Random().nextDouble() > 0.5
                                                    ? 0.1
                                                    : -0.1,
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                color: getColor(
                                                  int.parse(
                                                    apiDetailItemThree[index]
                                                        .idx,
                                                  ),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(h3Size * 0.1),
                                                ),
                                              ),
                                              child: Text(
                                                apiDetailItemThree[index].idx,
                                                style: TextStyle(
                                                  color:
                                                      Theme.of(
                                                        context,
                                                      ).colorScheme.onPrimary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            apiDetailItemThree[index].name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: h3Size),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getColor(int val) {
    if (val == 1) return Colors.red;
    if (val == 2) return Colors.orange;
    if (val == 3) return Colors.yellow;
    return Colors.grey;
  }
}

//影片介绍
class YDescribes extends StatelessWidget {
  final ApiDetailItemTwo apiDetailItemTwo;
  final double h3Size;
  const YDescribes({
    super.key,
    required this.apiDetailItemTwo,
    required this.h3Size,
  });

  @override
  Widget build(BuildContext context) {
    // context.widget.
    return Text(apiDetailItemTwo.describes, style: TextStyle(fontSize: h3Size));
  }
}

//选集播放
class YAnalecta extends StatefulWidget {
  final ApiDetailItemTwo apiDetailItemTwo;
  final double h3Size;
  final Function(ApiDetailItemTwoTagJishu ji) openPlay;
  const YAnalecta({
    super.key,
    required this.apiDetailItemTwo,
    required this.h3Size,
    required this.openPlay,
  });

  @override
  State<YAnalecta> createState() => _YAnalectaState();
}

class _YAnalectaState extends State<YAnalecta> {
  late int selectIdx_ = 0;
  late int selectIdxTwo = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          // height: 40,
          height: MediaQuery.of(context).size.height * 0.05,
          child: ListView(
            scrollDirection: Axis.horizontal, // 设置滚动方向为水平
            children: <Widget>[
              for (var i = 0; i < widget.apiDetailItemTwo.tags.length; i++)
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectIdx_ = i;
                      });
                    },
                    child: Chip(
                      side:
                          selectIdx_ == i
                              ? BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              )
                              : null,
                      label: Text(widget.apiDetailItemTwo.tags[i].tag),
                    ),
                  ),
                ),
            ],
          ),
        ),
        ConstrainedBox(
          // height: MediaQuery.of(context).size.height * 0.4,
          constraints: BoxConstraints(
            maxHeight:
                MediaQuery.of(context).size.height * 0.5 -
                MediaQuery.of(context).size.height * 0.08,
          ),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 4 / 2,
            ),
            children: List.generate(
              widget.apiDetailItemTwo.tags.isNotEmpty
                  ? widget.apiDetailItemTwo.tags[selectIdx_].jishu.length
                  : 0,
              (idx) {
                return Card(
                  color:
                      selectIdxTwo == idx
                          ? Theme.of(context).colorScheme.primaryContainer
                          : null,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectIdxTwo = idx;
                        widget.openPlay(
                          widget
                              .apiDetailItemTwo
                              .tags[selectIdx_]
                              .jishu[selectIdxTwo],
                        );
                      });
                    },
                    child: Center(
                      child: Align(
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          widget
                              .apiDetailItemTwo
                              .tags[selectIdx_]
                              .jishu[idx]
                              .name,
                          style: TextStyle(fontSize: widget.h3Size),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

//label切换
class YToggleLabel extends StatefulWidget {
  final List<String> labelArr;
  final List<Widget> widgetArr;
  final double h3Size;
  const YToggleLabel({
    super.key,
    required this.labelArr,
    required this.widgetArr,
    required this.h3Size,
  });

  @override
  State<YToggleLabel> createState() => _ToggleLabelState();
}

class _ToggleLabelState extends State<YToggleLabel> {
  int selectIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (var i = 0; i < widget.labelArr.length; i++)
              Padding(
                padding: EdgeInsets.only(bottom: 10, right: 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectIdx = i;
                    });
                  },
                  child: Text(
                    widget.labelArr[i],
                    style: TextStyle(
                      fontSize: widget.h3Size,
                      fontWeight: FontWeight.bold,
                      color:
                          selectIdx == i
                              ? Theme.of(context).colorScheme.primary
                              : null,
                    ),
                  ),
                ),
              ),
            // Text('$selectIdx'),
          ],
        ),
        widget.widgetArr[selectIdx],
      ],
    );
  }
}
