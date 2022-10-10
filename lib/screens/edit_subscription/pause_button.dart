import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:subscription_app_web/config/app_color.dart';

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
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: isPause
              ? [
                  const Icon(
                    Icons.pause_circle_outline,
                    color: AppColor.primary,
                  ),
                  Text(
                    AppLocalizations.of(context)!.resumeSubscription,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: AppColor.primary,
                        ),
                  )
                ]
              : [
                  const Icon(
                    Icons.pause_circle_outline,
                    color: AppColor.black,
                  ),
                  Text(
                    AppLocalizations.of(context)!.pauseSubscription,
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
        ),
      ),
    );
  }
}
