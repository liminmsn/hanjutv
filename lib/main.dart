import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanjutv/view/home.dart';
import 'package:hanjutv/view/like.dart';

void main() {
  runApp(const MyApp());

  doWhenWindowReady(() {
    final win = appWindow;
    win.minSize = const Size(400, 300);
    win.size = const Size(800, 600);
    win.alignment = Alignment.center;
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "韩剧tv",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        fontFamily: GoogleFonts.sigmar().fontFamily,
      ),
      home: MyAppCenter(),
    );
  }
}

//主程序
class MyAppCenter extends StatefulWidget {
  const MyAppCenter({super.key});

  @override
  State<MyAppCenter> createState() => _MyAppCenterState();
}

class _MyAppCenterState extends State<MyAppCenter> {
  late int selectIdx = 0;

  final List<Widget> viewList = [ViewHome(), ViewLike()];

  @override
  Widget build(BuildContext context) {
    final Color selectColor = Theme.of(context).colorScheme.primary;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              Container(
                width: constraints.minWidth >= 600 ? 180 : null,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1, 1),
                      color: Theme.of(
                        context,
                      ).colorScheme.primaryContainer.withAlpha(100),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: NavigationRail(
                  extended: constraints.minWidth >= 600,
                  destinations: [
                    NavigBtn(
                      active: selectIdx == 0,
                      icon: Icon(Icons.home_outlined, size: 20),
                      selectedIcon: Icon(
                        Icons.home,
                        color: selectColor,
                        size: 20,
                      ),
                      selectColor: selectColor,
                      label: '精选推荐',
                    ),
                    NavigBtn(
                      active: selectIdx == 1,
                      icon: Icon(Icons.favorite_outline, size: 20),
                      selectedIcon: Icon(
                        Icons.favorite,
                        color: selectColor,
                        size: 20,
                      ),
                      label: '喜欢列表',
                      selectColor: selectColor,
                    ),
                  ],
                  selectedIndex: selectIdx,
                  onDestinationSelected: (value) {
                    setState(() => selectIdx = value);
                  },
                ),
              ),
              Expanded(child: viewList[selectIdx]),
            ],
          ),
        );
      },
    );
  }
}

class NavigBtn extends NavigationRailDestination {
  late bool active = false;
  NavigBtn({
    required this.active,
    required super.icon,
    required super.selectedIcon,
    required String label,
    required Color selectColor,
  }) : super(
         label: Text(
           label,
           style: TextStyle(color: active ? selectColor : null),
         ),
       );
}
