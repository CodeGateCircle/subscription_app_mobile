import 'package:flutter/material.dart';
import 'package:subscription_app_web/config/app_color.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/screens/home/subscription_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubscriptionList extends StatefulWidget {
  const SubscriptionList({
    Key? key,
    required this.subscriptions,
    required this.sortSubscriptionList,
  }) : super(key: key);

  final List<Subscription> subscriptions;
  final void Function(SortKey?) sortSubscriptionList;

  @override
  State<SubscriptionList> createState() => _SubscriptionListState();
}

class _SubscriptionListState extends State<SubscriptionList> {
  SortKey? selectedDropdownItem;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<SortKey>> sortMenu = [
      DropdownMenuItem(
        value: SortKey.nameAsc,
        child: Text(AppLocalizations.of(context)!.sortAscendingByName),
      ),
      DropdownMenuItem(
        value: SortKey.nameDesc,
        child: Text(AppLocalizations.of(context)!.sortDescendingByName),
      ),
      DropdownMenuItem(
        value: SortKey.priceAsc,
        child: Text(AppLocalizations.of(context)!.sortAscendingByPrice),
      ),
      DropdownMenuItem(
        value: SortKey.priceDesc,
        child: Text(AppLocalizations.of(context)!.sortDescendingByPrice),
      ),
      DropdownMenuItem(
        value: SortKey.paymentDayAsc,
        child: Text(AppLocalizations.of(context)!.sortAscendingByPaymentDue),
      ),
      DropdownMenuItem(
        value: SortKey.paymentDayDesc,
        child: Text(AppLocalizations.of(context)!.sortDescendingByPaymentDue),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.subscriptions,
                style: Theme.of(context).textTheme.headline1,
              ),
              DropdownButton(
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColor.black,
                    ),
                hint: Text(AppLocalizations.of(context)!.sortSubscription),
                items: sortMenu,
                value: selectedDropdownItem,
                onChanged: (SortKey? value) {
                  setState(() {
                    selectedDropdownItem = value;
                    widget.sortSubscriptionList(value);
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.subscriptions.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 12),
                    SubscriptionCard(
                      subscription: widget.subscriptions[index],
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
