import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/widgets/button.dart';
import 'package:subscription_app_web/features/update_subscription_form/update_subscription_form.dart';

class CreateSubscription extends StatefulWidget {
  const CreateSubscription({Key? key}) : super(key: key);

  @override
  State<CreateSubscription> createState() => _CreateSubscriptionState();
}

class _CreateSubscriptionState extends State<CreateSubscription> {
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
      userId: 0,
      subscriptions: RequestSubscription(
        name: name,
        price: price,
        paymentCycle: paymentCycle,
        firstPaymentDate: firstPaymentDate,
        paymentMethod: paymentMethod,
        // image: iconImage,
        remarks: remarks,
      ),
    );
    try {
      // final res = await SubscriptionRepository.create(postData);
    } catch (e) {
      debugPrint(e.toString());
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
