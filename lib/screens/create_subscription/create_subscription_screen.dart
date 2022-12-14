import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subscription_app_web/config/app_color.dart';
import 'package:subscription_app_web/main.dart';
import 'package:subscription_app_web/modules/account/account.store.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.repository.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.store.dart';
import 'package:subscription_app_web/widgets/button.dart';
import 'package:subscription_app_web/features/update_subscription_form/update_subscription_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateSubscription extends ConsumerStatefulWidget {
  const CreateSubscription({
    Key? key,
    this.initializeName,
    this.initializePrice,
    this.initialImageUrl,
  }) : super(key: key);

  final String? initializeName;
  final double? initializePrice;
  final String? initialImageUrl;

  @override
  CreateSubscriptionState createState() => CreateSubscriptionState();
}

class CreateSubscriptionState extends ConsumerState<CreateSubscription> {
  String name = "";
  PaymentCycle paymentCycle = PaymentCycle.oneMonth;
  double price = 0;
  PaymentMethod paymentMethod = PaymentMethod.cash;
  DateTime firstPaymentDate = DateTime.now();
  XFile? iconImage;
  String? imageData;
  String? imageUrl;
  String? remarks;
  Subscription? subscription;

  @override
  void initState() {
    super.initState();

    if (widget.initializeName == null) return;
    if (widget.initializePrice == null) return;

    setState(() {
      name = widget.initializeName!;
      price = widget.initializePrice!;
      imageUrl = widget.initialImageUrl;
    });
  }

  Future _createSubscription() async {
    int count = 0;
    final postData = RequestData(
      userId: ref.watch(currentUserProvider)!.userId,
      subscription: RequestSubscription(
        name: name,
        price: price,
        paymentCycle: paymentCycle,
        firstPaymentDate: firstPaymentDate,
        paymentMethod: paymentMethod,
        isPaused: false,
        imageUrl: imageUrl,
        image: imageData,
        remarks: remarks,
      ),
    );

    try {
      final res = await SubscriptionRepository.create(postData);
      ref.read(subscriptionsProvider.notifier).add(res.data.subscription);
    } catch (e) {
      logger.e(e);
    } finally {
      Navigator.popUntil(context, (_) => count++ >= 2);
    }
  }

  void setName(String value) {
    setState(() {
      name = value;
    });
  }

  void setPaymentCycle(PaymentCycle value) {
    setState(() {
      paymentCycle = value;
    });
  }

  void setPrice(double value) {
    setState(() {
      price = value;
    });
  }

  void setPaymentMethod(PaymentMethod value) {
    setState(() {
      paymentMethod = value;
    });
  }

  void setFirstPaymentDate(DateTime value) {
    setState(() {
      firstPaymentDate = value;
    });
  }

  void setIconImage(XFile? value) {
    setState(() {
      iconImage = value;
    });
  }

  void setImageData(String? value) {
    setState(() {
      imageData = value;
    });
  }

  void setRemarks(String? value) {
    setState(() {
      remarks = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
            color: AppColor.black,
          ),
          actions: [
            Button(
              variant: Variant.solid,
              text: AppLocalizations.of(context)!.addSubscription,
              size: 90,
              color: AppColor.primary,
              onPressed: _createSubscription,
            ),
            const SizedBox(width: 12),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: UpdateSubscriptionForm(
          name: name,
          paymentCycle: paymentCycle,
          price: price,
          paymentMethod: paymentMethod,
          firstPaymentDate: firstPaymentDate,
          iconImage: iconImage,
          imageData: imageData,
          imageUrl: imageUrl,
          remarks: remarks,
          setName: setName,
          setPaymentCycle: setPaymentCycle,
          setPrice: setPrice,
          setPaymentMethod: setPaymentMethod,
          setFirstPaymentDate: setFirstPaymentDate,
          setIconImage: setIconImage,
          setImageData: setImageData,
          setRemarks: setRemarks,
        ),
      ),
    );
  }
}
