import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({
    Key? key,
    required this.onTap,
    required this.isPause,
  }) : super(key: key);

  final void Function() onTap;
  final bool isPause;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: isPause
            ? [
                const Icon(
                  Icons.pause_circle_outline,
                  color: Colors.red,
                ),
                Text(
                  AppLocalizations.of(context)!.resumeSubscription,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                )
              ]
            : [
                const Icon(
                  Icons.pause_circle_outline,
                  color: Colors.black,
                ),
                Text(
                  AppLocalizations.of(context)!.pauseSubscription,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                )
              ],
      ),
    );
  }
}
