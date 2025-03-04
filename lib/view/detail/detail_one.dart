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
        child: Icon(Icons.reply), // Icon displayed on the button
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
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
                                    Text('主演：${widget.yCardITem.desc}'),
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
                          child: Text("hello"),
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
