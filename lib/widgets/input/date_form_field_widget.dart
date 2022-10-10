import 'package:flutter/material.dart';
import 'package:subscription_app_web/config/app_color.dart';

class DateFormFieldWidget extends StatelessWidget {
  const DateFormFieldWidget({
    Key? key,
    required this.initialValue,
    required this.labelText,
    required this.onSaved,
  }) : super(key: key);

  final DateTime initialValue;
  final String labelText;
  final void Function(DateTime) onSaved;

  Future _pickDate(BuildContext context) async {
    //DatePickerの初期値
    final initialDate = initialValue;
    //DatePickerを表示し、選択されたら変数に格納する
    final newDate = await showDatePicker(
        context: context,
        //初期値を設定
        initialDate: initialDate,
        //選択できる日付の上限
        firstDate: DateTime(DateTime.now().year - 2),
        lastDate: DateTime(DateTime.now().year + 2));

    //nullチェック
    if (newDate != null) {
      //選択された日付を変数に格納
      onSaved(newDate);
    } else {
      //nullならば何もしない
      return;
    }
  }

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
        GestureDetector(
          onTap: () {
            _pickDate(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.border),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  initialValue.toString().split(" ")[0],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const Icon(
                  Icons.event_note,
                  color: AppColor.black,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
