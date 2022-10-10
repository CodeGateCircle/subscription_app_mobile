import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:subscription_app_web/config/app_color.dart';

class DeleteModal extends StatelessWidget {
  const DeleteModal({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          AppLocalizations.of(context)!.deletionAlertMessage,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      titlePadding: const EdgeInsets.only(top: 28, bottom: 12),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ActionButton(
              buttonText: AppLocalizations.of(context)!.cancelButtonText,
              textColor: AppColor.black,
              primaryColor: AppColor.white,
              borderColor: AppColor.border,
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 10),
            _ActionButton(
              buttonText: AppLocalizations.of(context)!.deleteButtonText,
              textColor: AppColor.white,
              primaryColor: AppColor.primary,
              onPressed: onPressed,
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    required this.textColor,
    required this.primaryColor,
    this.borderColor,
  }) : super(key: key);

  final Function onPressed;
  final String buttonText;
  final Color textColor;
  final Color primaryColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 104,
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: borderColor != null ? BorderSide(color: borderColor!) : null,
        ),
        child: Text(
          buttonText,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: textColor,
              ),
        ),
        onPressed: () => onPressed(),
      ),
    );
  }
}
