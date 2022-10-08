import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subscription_app_web/main.dart';
import 'package:subscription_app_web/modules/account/account.store.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.repository.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.store.dart';
import 'package:subscription_app_web/widgets/button.dart';
import 'package:subscription_app_web/features/update_subscription_form/update_subscription_form.dart';

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
  late int price;
  late PaymentMethod paymentMethod;
  late DateTime firstPaymentDate;
  late bool isPaused;
  late XFile? iconImage;
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
      iconImage = XFile(widget.subscription.imageUrl ?? "");
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
        // image: iconImage,
        remarks: remarks,
      ),
    );
    try {
      final res = await SubscriptionRepository.update(
        postData,
        widget.subscription.id,
      );
      ref.read(subscriptionsProvider.notifier).replace(res.data);
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

  void setPrice(int value) {
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

  void setRemarks(String? value) {
    setState(() {
      remarks = value;
    });
  }

  Widget _buildPauseButton(BuildContext context) {
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
        ref.read(subscriptionsProvider.notifier).replace(res.data);
      } catch (e) {
        logger.e(e);
      }
    }

    return GestureDetector(
      onTap: _pauseSubscription,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            ref.watch(subscriptionsProvider)[targetSubscriptionIndex].isPaused
                ? const [
                    Icon(
                      Icons.pause_circle_outline,
                      color: Colors.red,
                    ),
                    Text(
                      "停止中",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )
                  ]
                : const [
                    Icon(
                      Icons.pause_circle_outline,
                      color: Colors.black,
                    ),
                    Text(
                      "一時停止",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ],
      ),
    );
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
            color: Colors.black,
          ),
          actions: [
            _buildPauseButton(context),
            const SizedBox(width: 12),
            Button(
              variant: Variant.solid,
              text: "更新",
              size: 90,
              color: Colors.red,
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
          remarks: remarks,
          setName: setName,
          setPaymentCycle: setPaymentCycle,
          setPrice: setPrice,
          setPaymentMethod: setPaymentMethod,
          setFirstPaymentDate: setFirstPaymentDate,
          setIconImage: setIconImage,
          setRemarks: setRemarks,
        ),
      ),
    );
  }
}
