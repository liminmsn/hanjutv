import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hanjutv/api/api_detail_one.dart';
import 'package:hanjutv/api/api_home.dart';

class DetailOne extends StatefulWidget {
  final YCardITem yCardITem;
  const DetailOne({super.key, required this.yCardITem});

  @override
  State<DetailOne> createState() => _DetailOneState();
}

class _DetailOneState extends State<DetailOne> {
  late ApiDetailItemOne apiDetailItemOne = ApiDetailItemOne(
    director: '--',
    classify: '--',
    year: '--',
    starring: '--',
    region: '--',
  );
  late ApiDetailItemTwo apiDetailItemTwo = ApiDetailItemTwo(
    describes: '--',
    tags: [],
  );
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

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final titleSize = MediaQuery.of(context).size.height * 0.05;
    final h3Size = MediaQuery.of(context).size.height * 0.022;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.reply),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                                  Image.network(widget.yCardITem.pics),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.all(h3Size),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.yCardITem.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: titleSize,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '演员：${apiDetailItemOne.starring}',
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: h3Size),
                                          ),
                                          Text(
                                            '导演：${apiDetailItemOne.director}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: h3Size),
                                          ),
                                          Text(
                                            '类型：${apiDetailItemOne.classify}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: h3Size),
                                          ),
                                          Text(
                                            '年份：${apiDetailItemOne.year}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: h3Size),
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
                              title: Row(
                                children: [
                                  Transform.rotate(
                                    angle: 0,
                                    // Random().nextDouble() > 0.5
                                    //     ? 0.1
                                    //     : -0.1,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getColor(index),
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
  const YAnalecta({
    super.key,
    required this.apiDetailItemTwo,
    required this.h3Size,
  });

  @override
  State<YAnalecta> createState() => _YAnalectaState();
}

class _YAnalectaState extends State<YAnalecta> {
  late int selectIdx_ = 0;
  late int selectIdx_two = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal, // 设置滚动方向为水平
            children: <Widget>[
              for (var i = 0; i < widget.apiDetailItemTwo.tags.length; i++)
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: InkWell(
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
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.44,
          child: Expanded(
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
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectIdx_two = idx;
                      });
                    },
                    child: Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: Center(
                        child: Align(
                          child: Text(
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
                child: InkWell(
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
