import 'package:flutter/material.dart';

class DeleteModal extends StatelessWidget {
  const DeleteModal({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("本当に削除しますか？"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ActionButton(
              buttonText: "キャンセル",
              textColor: Colors.black,
              primaryColor: Colors.white,
              borderColor: Colors.grey.shade300,
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 10),
            _ActionButton(
              buttonText: "削除",
              textColor: Colors.white,
              primaryColor: Colors.red,
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
          style: TextStyle(
            color: textColor,
          ),
        ),
        onPressed: () => onPressed(),
      ),
    );
  }
}
