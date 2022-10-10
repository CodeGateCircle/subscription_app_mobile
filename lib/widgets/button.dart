import 'package:flutter/material.dart';
import 'package:subscription_app_web/config/app_color.dart';

enum Variant {
  solid,
  outline,
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.variant,
    required this.text,
    required this.onPressed,
    this.size = 210,
    this.color = AppColor.black,
    this.textColor = AppColor.white,
  }) : super(key: key);

  final Variant variant;
  final String text;
  final void Function() onPressed;
  final double? size;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    if (variant == Variant.outline) {
      return SizedBox(
        width: size,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            primary: color,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            side: BorderSide(color: color!),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      );
    } else {
      return SizedBox(
        width: size,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: color,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            side: BorderSide(color: color!),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: textColor,
                ),
          ),
        ),
      );
    }
  }
}
