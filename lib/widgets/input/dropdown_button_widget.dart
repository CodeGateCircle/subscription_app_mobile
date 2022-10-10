import 'package:flutter/material.dart';
import 'package:subscription_app_web/config/app_color.dart';

class DropdownButtonWidget<T> extends StatelessWidget {
  const DropdownButtonWidget({
    Key? key,
    required this.labelText,
    required this.dropdownValue,
    required this.dropdownMenuItems,
    required this.onChanged,
  }) : super(key: key);

  final String labelText;
  final T dropdownValue;
  final List<DropdownMenuItem<T>> dropdownMenuItems;
  final void Function(T) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          labelText,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(height: 10),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: AppColor.border,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            child: DropdownButton(
              isExpanded: true,
              underline: Container(),
              items: dropdownMenuItems,
              onChanged: (T? value) {
                if (value == null) return;
                onChanged(value);
              },
              value: dropdownValue,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
