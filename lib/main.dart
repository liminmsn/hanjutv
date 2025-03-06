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
      win.minSize = const Size(1000, 800);
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.limeAccent),
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
class _MyAppCenterState extends State<MyAppCenter>
    with SingleTickerProviderStateMixin {
  late int selectIdx = 0;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Widget> viewList = [ViewHome(), ViewLike(), ViewLike()];
  final List<NavIcon> iconList = [
    NavIcon(
      '热播推荐',
      icon: Icons.smart_display_outlined,
      selectIcon: Icons.new_releases,
    ),
    NavIcon(
      '连续剧',
      icon: Icons.smart_display_outlined,
      selectIcon: Icons.smart_display,
    ),
    NavIcon(
      '电影',
      icon: Icons.movie_filter_outlined,
      selectIcon: Icons.movie_filter,
    ),
  ];

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
                          for (var i = 0; i < iconList.length; i++)
                            NavigBtn(
                              active: selectIdx == i,
                              icon: Icon(iconList[i].icon),
                              selectedIcon: Icon(
                                iconList[i].selectIcon,
                                color: selectColor,
                              ),
                              selectColor: selectColor,
                              label: iconList[i].label,
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

class NavIcon {
  final IconData icon;
  final IconData selectIcon;
  final String label;
  NavIcon(this.label, {required this.icon, required this.selectIcon});
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
