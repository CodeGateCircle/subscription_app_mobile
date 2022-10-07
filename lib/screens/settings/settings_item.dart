import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
