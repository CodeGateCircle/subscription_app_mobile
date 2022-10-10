import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subscription_app_web/config/app_color.dart';
import 'package:subscription_app_web/screens/home/home_screen.dart';
import 'package:subscription_app_web/screens/settings/settings_screent.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> tabItems = [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "images/icons/home-outline.svg",
          semanticsLabel: 'Home icon',
          color: AppColor.gray,
        ),
        activeIcon: SvgPicture.asset(
          "images/icons/home-outline.svg",
          semanticsLabel: 'Home icon',
          width: 32,
          height: 32,
          color: AppColor.black,
        ),
        label: AppLocalizations.of(context)!.home,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "images/icons/cog-outline.svg",
          semanticsLabel: 'Settings icon',
          color: AppColor.gray,
        ),
        activeIcon: SvgPicture.asset(
          "images/icons/cog-outline.svg",
          semanticsLabel: 'Settings icon',
          color: AppColor.black,
        ),
        label: AppLocalizations.of(context)!.settings,
      ),
    ];

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
        items: tabItems,
        currentIndex: currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
