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

  fetchData() {
    ApiDetailOne.getData(widget.yCardITem.src).then((res) {
      setState(() {
        apiDetailItemOne = res.apiDetailItemOne;
        apiDetailItemTwo = res.apiDetailItemTwo;
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.reply),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Expanded(
                  child: Column(
                    children: [
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Image.network(
                                    widget.yCardITem.pics,
                                    height: 200,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        top: 2,
                                        bottom: 2,
                                      ),
                                      color: Colors.black.withAlpha(100),
                                      child: Text(
                                        widget.yCardITem.remarks,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.yCardITem.title,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text('主演：${apiDetailItemOne.starring}'),
                                    SizedBox(height: 4),
                                    Text('导演：${apiDetailItemOne.director}'),
                                    SizedBox(height: 4),
                                    Text('分类：${apiDetailItemOne.classify}'),
                                    SizedBox(height: 4),
                                    Text('年份：${apiDetailItemOne.year}'),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: Text("立即播放"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text("地区: ${apiDetailItemOne.region}"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              YToggleLabel(
                                labelArr: ['选集播放', '剧情介绍'],
                                widgetArr: [
                                  YAnalecta(apiDetailItemTwo: apiDetailItemTwo),
                                  YDescribes(
                                    apiDetailItemTwo: apiDetailItemTwo,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.9,
                child: Card(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.star),
                        title: Text('Item 1'),
                      ),
                      // Add more ListTiles as needed
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//影片介绍
class YDescribes extends StatelessWidget {
  final ApiDetailItemTwo apiDetailItemTwo;
  const YDescribes({super.key, required this.apiDetailItemTwo});

  @override
  Widget build(BuildContext context) {
    return Text(apiDetailItemTwo.describes);
  }
}

//选集播放
class YAnalecta extends StatefulWidget {
  final ApiDetailItemTwo apiDetailItemTwo;
  const YAnalecta({super.key, required this.apiDetailItemTwo});

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
                  padding: EdgeInsets.only(right: 2),
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
        SizedBox(height: 10),
        SizedBox(
          // width: 200,
          height: 300,
          child: GridView.count(
            childAspectRatio: 5 / 2.3,
            crossAxisCount: 8,
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
                  child: Chip(
                    side:
                        selectIdx_two == idx
                            ? BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            )
                            : null,
                    label: Text(
                      widget.apiDetailItemTwo.tags[selectIdx_].jishu[idx].name,
                      // style: TextStyle(fontSize: 10),
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
  const YToggleLabel({
    super.key,
    required this.labelArr,
    required this.widgetArr,
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
                      fontSize: 16,
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
