import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subscription_app_web/main.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/widgets/input/date_form_field_widget.dart';
import 'package:subscription_app_web/widgets/input/dropdown_button_widget.dart';
import 'package:subscription_app_web/widgets/input/text_field_form_widget.dart';
import 'package:subscription_app_web/widgets/input/upload_icon_image_field.dart';
import 'dart:convert';

class UpdateSubscriptionForm extends StatefulWidget {
  const UpdateSubscriptionForm({
    Key? key,
    required this.name,
    required this.paymentCycle,
    required this.price,
    required this.paymentMethod,
    required this.firstPaymentDate,
    required this.iconImage,
    required this.imageData,
    required this.remarks,
    required this.setName,
    required this.setPaymentCycle,
    required this.setPrice,
    required this.setPaymentMethod,
    required this.setFirstPaymentDate,
    required this.setIconImage,
    required this.setImageData,
    required this.setRemarks,
  }) : super(key: key);

  final String name;
  final PaymentCycle paymentCycle;
  final int price;
  final PaymentMethod paymentMethod;
  final DateTime firstPaymentDate;
  final XFile? iconImage;
  final String? imageData;
  final String? remarks;
  final void Function(String) setName;
  final void Function(PaymentCycle) setPaymentCycle;
  final void Function(int) setPrice;
  final void Function(PaymentMethod) setPaymentMethod;
  final void Function(DateTime) setFirstPaymentDate;
  final void Function(XFile?) setIconImage;
  final void Function(String?) setImageData;
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
          logger.e("No image selected.");
          return;
        }
        widget.setIconImage(pickedFile);
        final imageBytes = await pickedFile.readAsBytes();
        final String base64Image = base64Encode(imageBytes);
        final String imageExtension = pickedFile.name.split('.')[1];
        final String imageData =
            'data:image/$imageExtension;base64,$base64Image';
        widget.setImageData(imageData);
      } catch (e) {
        logger.e(e);
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
              TextFieldFormWidget(
                initialValue: widget.name,
                labelText: "サブスク名",
                hintText: "登録するサブスク名を記入してください",
                onSaved: (String? value) {
                  if (value == null) return;
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
              TextFieldFormWidget(
                initialValue: widget.price.toString(),
                labelText: "月額料金（JPY）",
                hintText: "料金を記入してください",
                onSaved: (String? value) {
                  if (value == null) return;
                  widget.setPrice(int.parse(value));
                },
              ),
              DateFormFieldWidget(
                initialValue: widget.firstPaymentDate,
                labelText: "初回支払い日",
                onSaved: (DateTime value) {
                  logger.d(widget.firstPaymentDate);
                  widget.setFirstPaymentDate(value);
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
              TextFieldFormWidget(
                initialValue: widget.remarks,
                labelText: "メモ",
                hintText: "メモの記入ができます",
                onSaved: (String? value) {
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
