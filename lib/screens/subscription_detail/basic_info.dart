import 'package:flutter/material.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/widgets/subscription_icon_img.dart';

class BasicInfoArea extends StatefulWidget {
  const BasicInfoArea({
    Key? key,
    required this.subscription,
  }) : super(key: key);

  final Subscription subscription;

  @override
  State<BasicInfoArea> createState() => _BasicInfoAreaState();
}

class _BasicInfoAreaState extends State<BasicInfoArea> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          SubscriptionIconImage(
            subscription: widget.subscription,
            iconSize: 96,
          ),
          const SizedBox(width: 15),
          Text.rich(
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 33,
            ),
            TextSpan(children: [
              TextSpan(text: '¥${widget.subscription.price}'),
              const TextSpan(
                text: ' /月', // TODO: 月/年表示をミュータブルにする
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
