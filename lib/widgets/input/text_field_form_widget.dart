import 'package:flutter/material.dart';
import 'package:subscription_app_web/config/app_color.dart';

class TextFieldFormWidget extends StatelessWidget {
  const TextFieldFormWidget({
    Key? key,
    required this.initialValue,
    required this.labelText,
    required this.hintText,
    required this.onSaved,
    this.isMultiline = false,
  }) : super(key: key);

  final String? initialValue;
  final String labelText;
  final String hintText;
  final void Function(String?) onSaved;
  final bool? isMultiline;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: initialValue == null ||
                  initialValue == "" ||
                  initialValue == "0" ||
                  initialValue == "0.0"
              ? null
              : initialValue,
          onChanged: (text) {
            onSaved(text);
          },
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
            contentPadding: isMultiline == true
                ? const EdgeInsets.fromLTRB(12, 32, 12, 0)
                : const EdgeInsets.fromLTRB(12, 17, 0, 17),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: AppColor.gray,
                ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: AppColor.border,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: AppColor.border,
              ),
            ),
          ),
          keyboardType: TextInputType.multiline,
          minLines: isMultiline == true ? 3 : 1,
          maxLines: isMultiline == true ? 3 : 1,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
