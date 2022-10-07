import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subscription_app_web/screens/home/home_screen.dart';
import 'package:subscription_app_web/screens/settings/settings_screent.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int currentIndex = 0;

  final List<Icon> icons = [const Icon(Icons.home), const Icon(Icons.settings)];

  void _onTap(int index) {
    setState(() {
      currentIndex = index; //インデックスの更新
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          Home(),
          Settings(),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: icons
            .map(
              (icon) => BottomNavigationBarItem(icon: icon),
            )
            .toList(),
        currentIndex: currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
