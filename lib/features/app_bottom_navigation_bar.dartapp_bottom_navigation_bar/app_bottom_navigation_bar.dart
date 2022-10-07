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

  final List<BottomNavigationBarItem> _tabItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'ホーム',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "設定",
    ),
  ];

  void _onTap(int index) {
    setState(() {
      currentIndex = index;
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
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 32,
        items: _tabItems,
        currentIndex: currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
