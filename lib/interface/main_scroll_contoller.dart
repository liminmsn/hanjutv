import 'package:flutter/material.dart';

abstract class MainScrollContoller extends StatefulWidget {
  final ScrollController scrollController;
  const MainScrollContoller({super.key, required this.scrollController});
}
