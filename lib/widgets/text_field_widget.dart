import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.initialValue,
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    this.isMultiline = false,
  }) : super(key: key);

  final String? initialValue;
  final String labelText;
  final String hintText;
  final void Function(String) onChanged;
  final bool? isMultiline;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: TextEditingController(
            text: initialValue == null ||
                    initialValue == "" ||
                    initialValue == "0"
                ? null
                : initialValue,
          ),
          onChanged: (text) {
            onChanged(text);
          },
          decoration: InputDecoration(
            contentPadding: isMultiline == true
                ? const EdgeInsets.fromLTRB(12, 32, 12, 0)
                : const EdgeInsets.fromLTRB(12, 17, 0, 17),
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 13),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: Color.fromRGBO(240, 237, 235, 1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: Color.fromRGBO(240, 237, 235, 1),
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
