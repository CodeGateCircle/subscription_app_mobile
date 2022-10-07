import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subscription_app_web/main.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.repository.dart';
import 'package:subscription_app_web/provider/current_user_notifier.dart';
import 'package:subscription_app_web/provider/subscriptions_notifier.dart';
import 'package:subscription_app_web/widgets/button.dart';
import 'package:subscription_app_web/features/update_subscription_form/update_subscription_form.dart';

class CreateSubscription extends ConsumerStatefulWidget {
  const CreateSubscription({Key? key}) : super(key: key);

  @override
  CreateSubscriptionState createState() => CreateSubscriptionState();
}

class CreateSubscriptionState extends ConsumerState<CreateSubscription> {
  String name = "";
  PaymentCycle paymentCycle = PaymentCycle.oneMonth;
  int price = 0;
  PaymentMethod paymentMethod = PaymentMethod.cash;
  DateTime firstPaymentDate = DateTime.now();
  XFile? iconImage;
  String? remarks;

  // TODO: globalStateにサブスクを追加する処理を追加
  Future _createSubscription() async {
    final postData = RequestData(
      userId: ref.watch(currentUserProvider)!.userId,
      subscription: RequestSubscription(
        name: name,
        price: price,
        paymentCycle: paymentCycle,
        firstPaymentDate: firstPaymentDate,
        paymentMethod: paymentMethod,
        isPause: false,
        // image: null,
        remarks: remarks,
      ),
    );

    try {
      final res = await SubscriptionRepository.create(postData);
      ref.read(subscriptionsProvider.notifier).addSubscription(res.data);
    } catch (e) {
      logger.e(e);
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
            Button(
              variant: Variant.solid,
              text: "登録",
              size: 90,
              color: Colors.red,
              onPressed: () {
                int count = 0;
                _createSubscription();
                Navigator.popUntil(context, (_) => count++ >= 2);
              },
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
