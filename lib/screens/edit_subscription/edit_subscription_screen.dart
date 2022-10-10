import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subscription_app_web/config/app_color.dart';
import 'package:subscription_app_web/main.dart';
import 'package:subscription_app_web/modules/account/account.store.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.repository.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.store.dart';
import 'package:subscription_app_web/screens/edit_subscription/pause_button.dart';
import 'package:subscription_app_web/widgets/button.dart';
import 'package:subscription_app_web/features/update_subscription_form/update_subscription_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditSubscription extends ConsumerStatefulWidget {
  const EditSubscription({
    Key? key,
    required this.subscription,
  }) : super(key: key);

  final Subscription subscription;

  @override
  EditSubscriptionState createState() => EditSubscriptionState();
}

class EditSubscriptionState extends ConsumerState<EditSubscription> {
  late String name;
  late PaymentCycle paymentCycle;
  late double price;
  late PaymentMethod paymentMethod;
  late DateTime firstPaymentDate;
  late bool isPaused;
  late XFile? iconImage;
  late String? defaultImageUrl;
  late String? imageData;
  late String? remarks;

  @override
  void initState() {
    setState(() {
      name = widget.subscription.name;
      paymentCycle = widget.subscription.paymentCycle;
      price = widget.subscription.price;
      paymentMethod = widget.subscription.paymentMethod;
      firstPaymentDate = widget.subscription.firstPaymentDate;
      isPaused = widget.subscription.isPaused;
      iconImage = null;
      defaultImageUrl = widget.subscription.imageUrl ?? "";
      imageData = null;
      remarks = widget.subscription.remarks;
    });
    super.initState();
  }

  Future _editSubscription() async {
    int count = 0;
    final postData = RequestData(
      userId: ref.watch(currentUserProvider)!.userId,
      subscription: RequestSubscription(
        name: name,
        price: price,
        paymentCycle: paymentCycle,
        firstPaymentDate: firstPaymentDate,
        paymentMethod: paymentMethod,
        isPaused: isPaused,
        image: imageData,
        remarks: remarks,
      ),
    );
    try {
      final res = await SubscriptionRepository.update(
        postData,
        widget.subscription.id,
      );
      ref.read(subscriptionsProvider.notifier).replace(res.data.subscription);
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
    final targetSubscriptionIndex = ref
        .watch(subscriptionsProvider.notifier)
        .getIndex(widget.subscription.id);

    Future _pauseSubscription() async {
      try {
        final res = await SubscriptionRepository.pause(
          widget.subscription,
          ref.watch(subscriptionsProvider)[targetSubscriptionIndex].isPaused,
          ref.watch(currentUserProvider)!.userId,
        );
        ref.read(subscriptionsProvider.notifier).replace(res.data.subscription);
      } catch (e) {
        logger.e(e);
      }
    }

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
            PauseButton(
              onTap: _pauseSubscription,
              isPause: ref
                  .watch(subscriptionsProvider)[targetSubscriptionIndex]
                  .isPaused,
            ),
            const SizedBox(width: 12),
            Button(
              variant: Variant.solid,
              text: AppLocalizations.of(context)!.saveSubscription,
              size: 90,
              color: AppColor.primary,
              onPressed: _editSubscription,
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
          defaultImageUrl: defaultImageUrl,
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
