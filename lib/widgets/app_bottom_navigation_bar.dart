import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  AppBottomNavigationBar({Key? key}) : super(key: key);
  final List<Icon> icons = [const Icon(Icons.home), const Icon(Icons.settings)];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      items: icons.map((icon) => BottomNavigationBarItem(icon: icon)).toList(),
    );
  }
}
