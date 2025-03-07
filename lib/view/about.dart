import 'package:flutter/material.dart';

class ViewAbout extends StatelessWidget {
  const ViewAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  width: MediaQuery.of(context).size.height * 0.4,
                  height: MediaQuery.of(context).size.height * 0.4,
                  "https://mp-00fbb6fa-0b8f-41d8-ac0c-122a477de70e.cdn.bspapp.com/8.jpg",
                ),
              ),
              Text(
                "请我喝奶茶",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                ),
              ),
            ],
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.height * 0.4,
                  height: MediaQuery.of(context).size.height * 0.6,
                  "https://mp-00fbb6fa-0b8f-41d8-ac0c-122a477de70e.cdn.bspapp.com/9.jpg",
                ),
              ),
              Text(
                "和我交朋友",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
