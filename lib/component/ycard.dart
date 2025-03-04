import 'package:flutter/material.dart';
import 'package:hanjutv/api/api_home.dart';

class Ycard extends StatelessWidget {
  final YCardITem item;
  const Ycard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
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
                      color: Theme.of(context).colorScheme.onPrimary,
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              SizedBox(
                height: 30,
                child: Text(
                  item.desc,
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: '',
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              Text(item.src),
            ],
          ),
        ),
      ],
    );
  }
}
