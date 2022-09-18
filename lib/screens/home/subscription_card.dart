import 'package:flutter/material.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/screens/subscription_detail/subscription_detail_screen.dart';
import 'package:subscription_app_web/widgets/subscription_icon_img.dart';

class SubscriptionCard extends StatefulWidget {
  const SubscriptionCard({
    Key? key,
    required this.subscription,
  }) : super(key: key);

  final Subscription subscription;

  @override
  State<SubscriptionCard> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  final double imgSize = 56;
  double progressValue = 0.2;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildNameAndPrice(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.subscription.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                children: [
                  TextSpan(text: '¥${widget.subscription.price}'),
                  const TextSpan(
                    text: ' /月', // TODO: 月/年表示をミュータブルにする
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SubscriptionDetail(subscription: widget.subscription),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(238, 242, 244, 1.0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SubscriptionIconImage(subscription: widget.subscription),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildNameAndPrice(context),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                    value: progressValue,
                  ),
                  const SizedBox(height: 4),
                  const Text("支払いまで17日"), // TODO: 期日の計算
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
