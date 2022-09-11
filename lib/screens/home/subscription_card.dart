import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';

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

  Widget _buildIconImage(BuildContext context) {
    return widget.subscription.image_url != null &&
            widget.subscription.image_url!.startsWith('http')
        ? CircleAvatar(
            radius: imgSize,
            backgroundImage: NetworkImage(widget.subscription.image_url!),
          )
        : Container(
            width: imgSize,
            height: imgSize,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(999),
            ),
            child: SvgPicture.asset(
              'images/device_mobile.svg',
              semanticsLabel: 'subscription_default_icon',
              width: 36,
              height: 36,
              color: Colors.grey,
            ),
          );
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(238, 242, 244, 1.0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildIconImage(context),
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
    );
  }
}
