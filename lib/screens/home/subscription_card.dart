import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_app_web/config/app_color.dart';
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
        border: Border.all(color: AppColor.gray),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        widget.subscription.formatPaymentCycle(context),
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: AppColor.gray,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 130,
              child: Text(
                widget.subscription.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.headline3,
                children: [
                  TextSpan(text: '¥$monthlyFee'),
                  TextSpan(
                    text:
                        ' / ${AppLocalizations.of(context)!.shortMonthly}', // TODO: 月/年表示をミュータブルにする
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.bold,
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
              ? "${widget.subscription.daysUntilNextBill().toString()} ${AppLocalizations.of(context)!.daysRemaining}"
              : "${AppLocalizations.of(context)!.daysRemaining}${widget.subscription.daysUntilNextBill().toString()}日",
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: LinearProgressIndicator(
            backgroundColor: AppColor.gray,
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
        color: AppColor.lightBlack,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.pause_circle,
              color: AppColor.white,
            ),
            const SizedBox(width: 4),
            Text(
              AppLocalizations.of(context)!.stopSubscription,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: AppColor.white,
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
              color: AppColor.backgroundColor,
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildNameAndPrice(context),
                      const SizedBox(height: 6),
                      _buildRemainingDaysProgressBar(context),
                      const SizedBox(height: 6),
                      _buildPaymentCycle(context),
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
