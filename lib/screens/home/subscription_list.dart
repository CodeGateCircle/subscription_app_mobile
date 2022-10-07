import 'package:flutter/material.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/screens/home/subscription_card.dart';

class SubscriptionList extends StatefulWidget {
  const SubscriptionList({
    Key? key,
    required this.subscriptions,
  }) : super(key: key);

  final List<Subscription> subscriptions;

  @override
  State<SubscriptionList> createState() => _SubscriptionListState();
}

class _SubscriptionListState extends State<SubscriptionList> {
  String? selectedDropdownItem;

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
                items: const [
                  DropdownMenuItem(
                    value: "作成日",
                    child: Text("作成日"),
                  ),
                  DropdownMenuItem(
                    value: "名前",
                    child: Text("名前"),
                  ),
                ],
                value: selectedDropdownItem,
                onChanged: (String? value) {
                  setState(() {
                    selectedDropdownItem = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 17),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.subscriptions.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SubscriptionCard(
                      subscription: widget.subscriptions[index],
                    ),
                    const SizedBox(height: 12),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
