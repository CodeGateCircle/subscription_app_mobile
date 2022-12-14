import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/widgets/subscription_icon_img.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            iconImageUrl: widget.subscription.imageUrl,
            iconSize: 80,
          ),
          const SizedBox(width: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '¥${NumberFormat().format(widget.subscription.price)}',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 33,
                    ),
              ),
              const SizedBox(width: 4),
              Text(
                "/ ${AppLocalizations.of(context)!.shortMonthly}",
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
