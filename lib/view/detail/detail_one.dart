import 'package:flutter/material.dart';
import 'package:hanjutv/api/api_home.dart';

class DetailOne extends StatefulWidget {
  final YCardITem yCardITem;
  const DetailOne({super.key, required this.yCardITem});

  @override
  State<DetailOne> createState() => _DetailOneState();
}

class _DetailOneState extends State<DetailOne> {
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
                              Image.network(widget.yCardITem.pics, height: 200),
                              SizedBox(width: 10),
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
                                    Text('主演：${widget.yCardITem.src}'),
                                    SizedBox(height: 4),
                                    Text('导演：${widget.yCardITem.desc}'),
                                    SizedBox(height: 4),
                                    Text('分类：${widget.yCardITem.desc}'),
                                    SizedBox(height: 4),
                                    Text('年份：${widget.yCardITem.desc}'),
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
                              Expanded(child: Column(children: [Text("地区")])),
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
                                widgetArr: [YAnalecta(), YDescribes()],
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
                      ListTile(
                        leading: Icon(Icons.star),
                        title: Text('Item 2'),
                      ),
                      ListTile(
                        leading: Icon(Icons.star),
                        title: Text('Item 3'),
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

//选集播放
class YDescribes extends StatelessWidget {
  const YDescribes({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("介绍");
  }
}

//影片介绍
class YAnalecta extends StatelessWidget {
  const YAnalecta({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("选集");
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
