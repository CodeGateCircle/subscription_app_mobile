import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_app_web/main.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/screens/subscription_detail/subscription_detail_screen.dart';
import 'package:subscription_app_web/widgets/subscription_icon_img.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubscriptionCard extends ConsumerStatefulWidget {
  const SubscriptionCard({
    Key? key,
    required this.subscription,
  }) : super(key: key);

  final Subscription subscription;

  @override
  SubscriptionCardState createState() => SubscriptionCardState();
}

class SubscriptionCardState extends ConsumerState<SubscriptionCard> {
  final double imgSize = 56;
  double progressValue = 0.2;

  Widget _buildPaymentCycle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        widget.subscription.formatPaymentCycle(context),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildNameAndPrice(BuildContext context) {
    final monthlyFee = widget.subscription.convertMonthlyFee();

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 140,
              child: Text(
                overflow: TextOverflow.ellipsis,
                widget.subscription.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(text: '¥$monthlyFee'),
                  TextSpan(
                    text:
                        ' / ${AppLocalizations.of(context)!.shortMonthly}', // TODO: 月/年表示をミュータブルにする
                    style: const TextStyle(
                      fontSize: 12,
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

  Widget _buildRemainingDaysProgressBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          ref.watch(localeProvider) == const Locale("en")
              ? "17 ${AppLocalizations.of(context)!.daysRemaining}"
              : "${AppLocalizations.of(context)!.daysRemaining}17日",
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ), // TODO: 期日の計算
        const SizedBox(width: 4),
        Expanded(
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey,
            value: progressValue,
          ),
        ),
      ],
    );
  }

  Widget _buildPauseDisplay(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(51, 51, 51, 0.4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.pause_circle,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Text(
              AppLocalizations.of(context)!.stopSubscription,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
    ;
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
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(238, 242, 244, 1.0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SubscriptionIconImage(
                  iconImageUrl: widget.subscription.imageUrl,
                  iconSize: 72,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNameAndPrice(context),
                      const SizedBox(height: 4),
                      _buildPaymentCycle(context),
                      const SizedBox(height: 4),
                      _buildRemainingDaysProgressBar(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
          widget.subscription.isPaused
              ? _buildPauseDisplay(context)
              : Container(),
        ],
      ),
    );
  }
}
