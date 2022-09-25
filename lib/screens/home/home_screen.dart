import 'package:flutter/material.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.repository.dart';
import 'package:subscription_app_web/screens/home/subscription_list.dart';
import 'package:subscription_app_web/screens/home/total_amount.dart';
import 'package:subscription_app_web/screens/search_subscription/search_subscription_screen.dart';
import 'package:subscription_app_web/widgets/app_bottom_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const double floatingActionButtonSize = 64;
  List<Subscription> subscriptions = [];
  int totalAmount = 0;

  Future fetchSubscriptions() async {
    try {
      final res = await SubscriptionRepository.findAll();
      setState(() {
        subscriptions = res.data.subscriptions;
      });
      calculateTotalsAmount();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  int calculateTotalsAmount() {
    for (final subscription in subscriptions) {
      setState(() {
        totalAmount = totalAmount + subscription.price;
      });
    }
    return totalAmount;
  }

  @override
  void initState() {
    fetchSubscriptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TotalAmount(totalAmount: totalAmount),
          Expanded(
            child: SubscriptionList(subscriptions: subscriptions),
          )
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
      floatingActionButton: SizedBox(
        width: floatingActionButtonSize,
        height: floatingActionButtonSize,
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          child: const Icon(Icons.add, size: 32),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchSubscription(),
              ),
            );
          },
        ),
      ),
    );
  }
}
