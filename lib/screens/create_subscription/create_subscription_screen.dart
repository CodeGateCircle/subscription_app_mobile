import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/screens/create_subscription/dropdown_button_widget.dart';
import 'package:subscription_app_web/screens/create_subscription/text_field_widget.dart';

class CreateSubscription extends StatefulWidget {
  const CreateSubscription({Key? key}) : super(key: key);

  @override
  State<CreateSubscription> createState() => _CreateSubscriptionState();
}

class _CreateSubscriptionState extends State<CreateSubscription> {
  XFile iconImage = XFile("");
  String? name;
  PaymentCycle paymentCycle = PaymentCycle.month;
  int? price;
  DateTime? firstPaymentDate;
  String paymentMethod = "現金";
  String? remarks;

  Widget _buildOptionText(BuildContext context, String textValue) {
    return Text(
      textValue,
      style: const TextStyle(
        fontSize: 13,
        color: Colors.black,
      ),
    );
  }

  void _createSubscription() {}

  void updateValue<T>(T value, T? state) {
    setState(() {
      state = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final paymentCycleOptions = [
      DropdownMenuItem(
        value: PaymentCycle.month,
        child: _buildOptionText(context, "1ヶ月"),
      ),
      DropdownMenuItem(
        value: PaymentCycle.twoMonths,
        child: _buildOptionText(context, "2ヶ月"),
      ),
      DropdownMenuItem(
        value: PaymentCycle.threeMonths,
        child: _buildOptionText(context, "3ヶ月"),
      ),
      DropdownMenuItem(
        value: PaymentCycle.sixMonths,
        child: _buildOptionText(context, "半年"),
      ),
      DropdownMenuItem(
        value: PaymentCycle.year,
        child: _buildOptionText(context, "1年"),
      ),
    ];

    final paymentMethodOptions = [
      DropdownMenuItem(
        value: "現金",
        child: _buildOptionText(context, "現金"),
      ),
      DropdownMenuItem(
        value: "Paypay",
        child: _buildOptionText(context, "Paypay"),
      ),
      DropdownMenuItem(
        value: "クレジットカード（下4桁番号：1234）",
        child: _buildOptionText(context, "クレジットカード（下4桁番号：1234）"),
      ),
      DropdownMenuItem(
        value: "クレジットカード（下4桁番号：5678）",
        child: _buildOptionText(context, "クレジットカード（下4桁番号：5678）"),
      ),
    ];

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
            color: Colors.black,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              iconSize: 32,
              tooltip: '登録',
              color: Colors.blue,
              onPressed: () {
                _createSubscription();
              },
            ),
            const SizedBox(width: 10),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldWidget(
                  labelText: "サブスク名",
                  hintText: "登録するサブスク名を記入してください",
                  onChanged: (String value) {
                    updateValue<String>(value, name);
                  },
                ),
                DropdownButtonWidget<PaymentCycle>(
                  labelText: "支払い周期",
                  dropdownValue: paymentCycle,
                  dropdownMenuItems: paymentCycleOptions,
                  onChanged: (PaymentCycle value) {
                    updateValue<PaymentCycle>(value, paymentCycle);
                  },
                ),
                TextFieldWidget(
                  labelText: "月額料金（JPY）",
                  hintText: "料金を記入してください",
                  onChanged: (String value) {
                    updateValue<int>(int.parse(value), price);
                  },
                ),
                DropdownButtonWidget(
                  labelText: "支払い方法",
                  dropdownValue: paymentMethod,
                  dropdownMenuItems: paymentMethodOptions,
                  onChanged: (String value) {
                    updateValue<String>(value, paymentMethod);
                  },
                ),
                TextFieldWidget(
                  labelText: "メモ",
                  hintText: "メモの記入ができます",
                  onChanged: (String value) {
                    updateValue<String>(value, remarks);
                  },
                  isMultiline: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
