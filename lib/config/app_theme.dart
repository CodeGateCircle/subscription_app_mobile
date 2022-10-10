import 'package:flutter/material.dart';
import 'package:subscription_app_web/config/app_color.dart';

ThemeData appTheme(BuildContext context) {
  final ThemeData theme = ThemeData();

  return ThemeData(
    colorScheme: theme.colorScheme.copyWith(primary: AppColor.black),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: AppColor.white,
      iconTheme: IconThemeData(color: AppColor.black),
      toolbarTextStyle: TextStyle(
        color: AppColor.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    ),
    textTheme: TextTheme(
      headline1: _baseTextStyle.copyWith(
        fontSize: 24,
        letterSpacing: 0.96,
        fontWeight: FontWeight.bold,
        color: AppColor.black,
      ),
      headline2: _baseTextStyle.copyWith(
        fontSize: 20,
        letterSpacing: 0.8,
        fontWeight: FontWeight.bold,
      ),
      headline3: _baseTextStyle.copyWith(
        fontSize: 16,
        letterSpacing: 0.64,
        fontWeight: FontWeight.bold,
        color: AppColor.black,
      ),
      subtitle1: _baseTextStyle.copyWith(
        fontSize: 14,
        letterSpacing: 0.56,
        fontWeight: FontWeight.bold,
        color: AppColor.black,
      ),
      subtitle2: _baseTextStyle.copyWith(
        fontSize: 12,
        letterSpacing: 0.48,
        fontWeight: FontWeight.bold,
        color: AppColor.black,
      ),
      bodyText1: _baseTextStyle.copyWith(
        letterSpacing: 0.56,
        fontSize: 14,
        color: AppColor.black,
      ),
      bodyText2: _baseTextStyle.copyWith(
        letterSpacing: 0.48,
        fontSize: 12,
        color: AppColor.black,
      ),
      caption: _baseTextStyle.copyWith(
        letterSpacing: 0.4,
        fontSize: 10,
      ),
    ),
  );
}

const _baseTextStyle = TextStyle(
  color: AppColor.black,
  fontFamily: 'Metropolis',
  fontFamilyFallback: ['Noto Sans JP'],
);
