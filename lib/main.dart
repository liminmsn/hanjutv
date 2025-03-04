import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:hanjutv/view/home.dart';
import 'package:hanjutv/view/like.dart';

void main() {
  runApp(const MyApp());

  //windows平台
  if (Platform.isWindows) {
    doWhenWindowReady(() {
      final win = appWindow;
      win.minSize = const Size(400, 600);
      win.size = const Size(1200, 800);
      win.alignment = Alignment.center;
      win.show();
    });
  }
  //macos平台
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
        fontFamily: GoogleFonts.sigmar().fontFamily,
      ),
      darkTheme: ThemeData.dark(), // 深色主题（黑色主题）
      themeMode: ThemeMode.light,
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

//主程序state
class _MyAppCenterState extends State<MyAppCenter> {
  late int selectIdx = 0;

  final List<Widget> viewList = [ViewHome(), ViewLike()];

  @override
  Widget build(BuildContext context) {
    final Color selectColor = Theme.of(context).colorScheme.primary;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Column(
            children: [
              if (Platform.isWindows) TopBar(),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: constraints.minWidth >= 600 ? 150 : null,
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
                            label: '首页',
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
              ),
            ],
          ),
        );
      },
    );
  }
}

//顶部标题栏
class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: MoveWindow(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                // flex: 6,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(children: [Text("韩剧tv")]),
                ),
              ),
              Row(
                children: [
                  MinimizeWindowButton(),
                  MaximizeWindowButton(),
                  CloseWindowButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//左侧bar按钮
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
