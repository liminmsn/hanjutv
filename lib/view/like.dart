import 'package:flutter/material.dart';

class ViewLike extends StatefulWidget {
  const ViewLike({super.key});

  @override
  State<ViewLike> createState() => _ViewLikeState();
}

class _ViewLikeState extends State<ViewLike> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Align(child: Text("打赏过30人开发此功能")));
  }
}
