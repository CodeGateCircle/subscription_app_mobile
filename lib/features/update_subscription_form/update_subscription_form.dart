import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subscription_app_web/config/app_color.dart';
import 'package:subscription_app_web/main.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/widgets/input/date_form_field_widget.dart';
import 'package:subscription_app_web/widgets/input/dropdown_button_widget.dart';
import 'package:subscription_app_web/widgets/input/text_field_form_widget.dart';
import 'package:subscription_app_web/widgets/input/upload_icon_image_field.dart';
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateSubscriptionForm extends StatefulWidget {
  const UpdateSubscriptionForm({
    Key? key,
    required this.name,
    required this.paymentCycle,
    required this.price,
    required this.paymentMethod,
    required this.firstPaymentDate,
    required this.iconImage,
    required this.defaultImageUrl,
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
  final double price;
  final PaymentMethod paymentMethod;
  final DateTime firstPaymentDate;
  final XFile? iconImage;
  final String? defaultImageUrl;
  final String? imageData;
  final String? remarks;
  final void Function(String) setName;
  final void Function(PaymentCycle) setPaymentCycle;
  final void Function(double) setPrice;
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
        color: AppColor.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    Future onTapIconImage() async {
      try {
        final pickedFile = await picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
        );
        if (pickedFile == null) {
          logger.e("No image selected.");
          return;
        }
        widget.setIconImage(pickedFile);
        final List<int> imageBytes = await pickedFile.readAsBytes();
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
        child: _buildOptionText(
          context,
          AppLocalizations.of(context)!.month,
        ),
      ),
      DropdownMenuItem(
        value: PaymentCycle.twoMonths,
        child: _buildOptionText(
          context,
          AppLocalizations.of(context)!.twoMonths,
        ),
      ),
      DropdownMenuItem(
        value: PaymentCycle.threeMonths,
        child: _buildOptionText(
          context,
          AppLocalizations.of(context)!.threeMonths,
        ),
      ),
      DropdownMenuItem(
        value: PaymentCycle.sixMonths,
        child: _buildOptionText(
          context,
          AppLocalizations.of(context)!.sixMonths,
        ),
      ),
      DropdownMenuItem(
        value: PaymentCycle.year,
        child: _buildOptionText(
          context,
          AppLocalizations.of(context)!.year,
        ),
      ),
    ];

    final paymentMethodOptions = [
      DropdownMenuItem(
        value: PaymentMethod.cash,
        child: _buildOptionText(
          context,
          AppLocalizations.of(context)!.cash,
        ),
      ),
      DropdownMenuItem(
        value: PaymentMethod.card,
        child: _buildOptionText(
          context,
          AppLocalizations.of(context)!.creditCards,
        ),
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
                defaultImageUrl: widget.defaultImageUrl,
                onTapIconImage: onTapIconImage,
              ),
              TextFieldFormWidget(
                initialValue: widget.name,
                labelText: AppLocalizations.of(context)!.nameLabel,
                hintText: AppLocalizations.of(context)!.namePlaceHolder,
                onSaved: (String? value) {
                  if (value == null) return;
                  widget.setName(value);
                },
              ),
              DropdownButtonWidget<PaymentCycle>(
                labelText: AppLocalizations.of(context)!.cycleLabel,
                dropdownValue: widget.paymentCycle,
                dropdownMenuItems: paymentCycleOptions,
                onChanged: (PaymentCycle value) {
                  widget.setPaymentCycle(value);
                },
              ),
              TextFieldFormWidget(
                initialValue: widget.price.toString(),
                labelText: AppLocalizations.of(context)!.priceLabel,
                hintText: AppLocalizations.of(context)!.pricePlaceHolder,
                onSaved: (String? value) {
                  if (value == null) return;
                  widget.setPrice(double.parse(value));
                },
              ),
              DateFormFieldWidget(
                initialValue: widget.firstPaymentDate,
                labelText: AppLocalizations.of(context)!.firstBillLabel,
                onSaved: (DateTime value) {
                  widget.setFirstPaymentDate(value);
                },
              ),
              DropdownButtonWidget(
                labelText: AppLocalizations.of(context)!.paymentMethodsLabel,
                dropdownValue: widget.paymentMethod,
                dropdownMenuItems: paymentMethodOptions,
                onChanged: (PaymentMethod value) {
                  widget.setPaymentMethod(value);
                },
              ),
              TextFieldFormWidget(
                initialValue: widget.remarks,
                labelText: AppLocalizations.of(context)!.remarksLabel,
                hintText: AppLocalizations.of(context)!.remarksPlaceHolder,
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
