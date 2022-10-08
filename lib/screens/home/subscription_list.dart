import 'package:flutter/material.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/screens/home/subscription_card.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.store.dart';

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

  final List<DropdownMenuItem<SortKey>> sortMenu = const [
    DropdownMenuItem(
      value: SortKey.nameAsc,
      child: Text("名前(昇順)"),
    ),
    DropdownMenuItem(
      value: SortKey.nameDesc,
      child: Text("名前（降順）"),
    ),
    DropdownMenuItem(
      value: SortKey.priceAsc,
      child: Text("料金(昇順)"),
    ),
    DropdownMenuItem(
      value: SortKey.priceDesc,
      child: Text("料金（降順）"),
    ),
    DropdownMenuItem(
      value: SortKey.paymentDayAsc,
      child: Text("支払い日数(昇順)"),
    ),
    DropdownMenuItem(
      value: SortKey.paymentDayDesc,
      child: Text("支払い日数（降順）"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                "Subscriptions",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton(
                hint: const Text("並び替え"),
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
