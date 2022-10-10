import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:subscription_app_web/config/app_color.dart';
import 'package:subscription_app_web/main.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.repository.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.store.dart';
import 'package:subscription_app_web/screens/edit_subscription/edit_subscription_screen.dart';
import 'package:subscription_app_web/screens/subscription_detail/basic_info.dart';
import 'package:subscription_app_web/screens/subscription_detail/delete_modal.dart';
import 'package:subscription_app_web/widgets/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubscriptionDetail extends ConsumerStatefulWidget {
  const SubscriptionDetail({
    Key? key,
    required this.subscription,
  }) : super(key: key);

  final Subscription subscription;

  @override
  SubscriptionDetailState createState() => SubscriptionDetailState();
}

class SubscriptionDetailState extends ConsumerState<SubscriptionDetail> {
  double progressValue = 0.2;

  Future _deleteSubscription(int id) async {
    int count = 0;

    try {
      await SubscriptionRepository.delete(id);
      ref.read(subscriptionsProvider.notifier).delete(id);
    } catch (e) {
      logger.e(e);
    } finally {
      Navigator.popUntil(context, (_) => count++ >= 2);
    }
  }

  Future _showAlertDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteModal(
          onPressed: () {
            _deleteSubscription(widget.subscription.id);
          },
        );
      },
    );
  }

  void moveToEditScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSubscription(
          subscription: widget.subscription,
        ),
      ),
    );
  }

  Widget _buildRemarks(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.remarksLabel,
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: 8),
              Text(
                widget.subscription.remarks!,
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.black,
        ),
        title: Text(
          widget.subscription.name,
          style: Theme.of(context).textTheme.headline2,
        ),
        backgroundColor: Colors.transparent,
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
                    Text(
                      "${AppLocalizations.of(context)!.startDateOfUse}: ${DateFormat.yMMMMd(ref.watch(localeProvider).toString()).format(widget.subscription.firstPaymentDate)}",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppColor.gray,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      ref.watch(localeProvider) == const Locale("en")
                          ? "${widget.subscription.daysUntilNextBill().toString()} ${AppLocalizations.of(context)!.daysRemaining}"
                          : "${AppLocalizations.of(context)!.daysRemaining}${widget.subscription.daysUntilNextBill().toString()}日",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      backgroundColor: AppColor.gray,
                      value: progressValue,
                    ),
                  ],
                ),
                widget.subscription.remarks == null
                    ? Container()
                    : _buildRemarks(context),
                const SizedBox(height: 28),
                Button(
                  variant: Variant.outline,
                  text: AppLocalizations.of(context)!.editSubscription,
                  onPressed: moveToEditScreen,
                  color: AppColor.black,
                ),
                const SizedBox(height: 12),
                Button(
                  variant: Variant.solid,
                  text: AppLocalizations.of(context)!.deleteSubscription,
                  onPressed: _showAlertDialog,
                  color: AppColor.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
