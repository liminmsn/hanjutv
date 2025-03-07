import 'package:flutter/material.dart';
import 'package:hanjutv/api/api_home.dart';

class Ycard extends StatelessWidget {
  final YCardITem item;
  const Ycard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double titleSize = MediaQuery.of(context).size.height * 0.03;
        double labelSize = MediaQuery.of(context).size.height * 0.02;
        double labelHeight = MediaQuery.of(context).size.height * 0.06;
        double label2Size = MediaQuery.of(context).size.height * 0.02;
        double label3Size = MediaQuery.of(context).size.height * 0.02;

        return Column(
          children: [
            Expanded(
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Image.network(
                      item.pics,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.only(top: 2, bottom: 2),
                        color: Colors.black.withAlpha(100),
                        child: Text(
                          item.remarks,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: label2Size,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 5,
                      child: Text(
                        item.score != 'null' ? item.score : '',
                        style: TextStyle(
                          fontSize: label3Size,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    Positioned(
                      top: -18,
                      right: -8,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.bookmark,
                          size: label3Size * 3,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  SizedBox(
                    height: labelHeight,
                    child: Text(
                      item.desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: labelSize,
                        fontFamily: '',
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
