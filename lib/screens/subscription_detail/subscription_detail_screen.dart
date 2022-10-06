import 'package:flutter/material.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.repository.dart';
import 'package:subscription_app_web/screens/subscription_detail/basic_info.dart';
import 'package:subscription_app_web/screens/subscription_detail/delete_modal.dart';
import 'package:subscription_app_web/widgets/button.dart';

class SubscriptionDetail extends StatefulWidget {
  const SubscriptionDetail({
    Key? key,
    required this.subscription,
  }) : super(key: key);

  final Subscription subscription;

  @override
  State<SubscriptionDetail> createState() => _SubscriptionDetailState();
}

class _SubscriptionDetailState extends State<SubscriptionDetail> {
  double progressValue = 0.2;

  Future _deleteSubscription(int id) async {
    try {
      await SubscriptionRepository.delete(id);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future _showAlertDialog() async {
    int count = 0;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteModal(
          onPressed: () {
            _deleteSubscription(widget.subscription.subscriptionId);
            Navigator.popUntil(context, (_) => count++ >= 2);
          },
        );
      },
    );
  }

  Widget _buildPaymentMethodCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(238, 242, 244, 1.0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "支払い方法",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "下4桁番号：1234",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.black,
        ),
        title: Text(
          widget.subscription.name,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          BasicInfoArea(subscription: widget.subscription),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "2022/04/12 利用開始",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ), // TODO: 変数に変更
                    const SizedBox(height: 6),
                    const Text(
                      "支払いまでの残り日数: 17日",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                      value: progressValue,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildPaymentMethodCard(context),
                const SizedBox(height: 28),
                Button(
                  variant: Variant.outline,
                  text: "編集",
                  onPressed: () {},
                  color: Colors.black,
                ),
                const SizedBox(height: 12),
                Button(
                  variant: Variant.solid,
                  text: "削除",
                  onPressed: _showAlertDialog,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
