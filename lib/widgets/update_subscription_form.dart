import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/widgets/text_field_widget.dart';
import 'package:subscription_app_web/widgets/upload_icon_image_field.dart';

import 'dropdown_button_widget.dart';

class UpdateSubscriptionForm extends StatefulWidget {
  const UpdateSubscriptionForm({
    Key? key,
    required this.name,
    required this.paymentCycle,
    required this.price,
    required this.paymentMethod,
    required this.firstPaymentDate,
    required this.iconImage,
    required this.remarks,
    required this.setName,
    required this.setPaymentCycle,
    required this.setPrice,
    required this.setPaymentMethod,
    required this.setFirstPaymentDate,
    required this.setIconImage,
    required this.setRemarks,
  }) : super(key: key);

  final String name;
  final PaymentCycle paymentCycle;
  final int price;
  final PaymentMethod paymentMethod;
  final DateTime firstPaymentDate;
  final XFile? iconImage;
  final String? remarks;
  final void Function(String) setName;
  final void Function(PaymentCycle) setPaymentCycle;
  final void Function(int) setPrice;
  final void Function(PaymentMethod) setPaymentMethod;
  final void Function(DateTime) setFirstPaymentDate;
  final void Function(XFile?) setIconImage;
  final void Function(String?) setRemarks;

  @override
  State<UpdateSubscriptionForm> createState() => _UpdateSubscriptionFormState();
}

class _UpdateSubscriptionFormState extends State<UpdateSubscriptionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildOptionText(BuildContext context, String textValue) {
    return Text(
      textValue,
      style: const TextStyle(
        fontSize: 13,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    Future onTapIconImage() async {
      try {
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile == null) {
          debugPrint("No image selected.");
          return;
        }
        widget.setIconImage(pickedFile);
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    final paymentCycleOptions = [
      DropdownMenuItem(
        value: PaymentCycle.oneMonth,
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
        value: PaymentMethod.cash,
        child: _buildOptionText(context, "現金"),
      ),
      DropdownMenuItem(
        value: PaymentMethod.card,
        child: _buildOptionText(context, "クレジットカード"),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UploadIconImageField(
                iconImage: widget.iconImage,
                onTapIconImage: onTapIconImage,
              ),
              TextFieldWidget(
                initialValue: widget.name,
                labelText: "サブスク名",
                hintText: "登録するサブスク名を記入してください",
                onChanged: (String value) {
                  widget.setName(value);
                },
              ),
              DropdownButtonWidget<PaymentCycle>(
                labelText: "支払い周期",
                dropdownValue: widget.paymentCycle,
                dropdownMenuItems: paymentCycleOptions,
                onChanged: (PaymentCycle value) {
                  widget.setPaymentCycle(value);
                },
              ),
              TextFieldWidget(
                initialValue: widget.price.toString(),
                labelText: "月額料金（JPY）",
                hintText: "料金を記入してください",
                onChanged: (String value) {
                  widget.setPrice(int.parse(value));
                },
              ),
              DropdownButtonWidget(
                labelText: "支払い方法",
                dropdownValue: widget.paymentMethod,
                dropdownMenuItems: paymentMethodOptions,
                onChanged: (PaymentMethod value) {
                  widget.setPaymentMethod(value);
                },
              ),
              TextFieldWidget(
                initialValue: widget.remarks,
                labelText: "メモ",
                hintText: "メモの記入ができます",
                onChanged: (String value) {
                  widget.setRemarks(value);
                },
                isMultiline: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
