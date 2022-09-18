import 'package:flutter/material.dart';

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
    this.color = Colors.blue,
    this.textColor = Colors.black,
  }) : super(key: key);

  final Variant variant;
  final String text;
  final void Function() onPressed;
  final double? size;
  final Color? color;
  final Color? textColor;

  Widget _buildButtonText(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (variant == Variant.outline) {
      return SizedBox(
        width: size,
        child: OutlinedButton(
          onPressed: () => {},
          style: OutlinedButton.styleFrom(
            primary: color,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            side: BorderSide(color: color!),
          ),
          child: _buildButtonText(context),
        ),
      );
    } else {
      return SizedBox(
        width: size,
        child: ElevatedButton(
          onPressed: () => {},
          style: ElevatedButton.styleFrom(
            primary: color,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            side: BorderSide(color: color!),
          ),
          child: _buildButtonText(context),
        ),
      );
    }
  }
}
