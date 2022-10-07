import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subscription_app_web/main.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.repository.dart';
import 'package:subscription_app_web/provider/current_user_notifier.dart';
import 'package:subscription_app_web/widgets/button.dart';
import 'package:subscription_app_web/features/update_subscription_form/update_subscription_form.dart';

class EditSubscription extends ConsumerStatefulWidget {
  const EditSubscription({
    Key? key,
    required this.id,
    required this.name,
    required this.paymentCycle,
    required this.price,
    required this.paymentMethod,
    required this.firstPaymentDate,
    required this.isPaused,
    required this.iconImage,
    required this.remarks,
  }) : super(key: key);

  final int id;
  final String name;
  final PaymentCycle paymentCycle;
  final int price;
  final PaymentMethod paymentMethod;
  final DateTime firstPaymentDate;
  final bool isPaused;
  final String? iconImage;
  final String? remarks;

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
      name = widget.name;
      paymentCycle = widget.paymentCycle;
      price = widget.price;
      paymentMethod = widget.paymentMethod;
      firstPaymentDate = widget.firstPaymentDate;
      isPaused = widget.isPaused;
      iconImage = XFile(widget.iconImage ?? "");
      remarks = widget.remarks;
    });
    super.initState();
  }

  Future _editSubscription() async {
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
      // TODO: グローバルステートの更新処理を記述する
      final res = await SubscriptionRepository.update(postData, widget.id);
    } catch (e) {
      logger.e(e);
    }
  }

  Future _pauseSubscription() async {}

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
            GestureDetector(
              onTap: _pauseSubscription,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
            ),
            const SizedBox(width: 12),
            Button(
              variant: Variant.solid,
              text: "更新",
              size: 90,
              color: Colors.red,
              onPressed: () {
                int count = 0;
                _editSubscription();
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
