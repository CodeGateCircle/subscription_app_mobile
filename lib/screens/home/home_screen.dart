import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_app_web/main.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.repository.dart';
import 'package:subscription_app_web/provider/current_user_notifier.dart';
import 'package:subscription_app_web/provider/subscriptions_notifier.dart';
import 'package:subscription_app_web/screens/home/subscription_list.dart';
import 'package:subscription_app_web/screens/home/total_amount.dart';
import 'package:subscription_app_web/screens/search_subscription/search_subscription_screen.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends ConsumerState<Home> {
  static const double floatingActionButtonSize = 64;
  int totalAmount = 0;

  int calculateTotalsAmount() {
    for (final subscription in ref.watch(subscriptionsProvider)) {
      setState(() {
        totalAmount = totalAmount + subscription.price;
      });
    }
    return totalAmount;
  }

  Future<void> initializeData() async {
    try {
      final userId = ref.watch(currentUserProvider)!.userId;
      final res = await SubscriptionRepository.findAll(userId);
      ref.read(subscriptionsProvider.notifier).state = res.data.subscriptions;
    } catch (e) {
      logger.e("error: $e");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TotalAmount(totalAmount: calculateTotalsAmount()),
            Expanded(
              child: SubscriptionList(
                subscriptions: ref.watch(subscriptionsProvider),
              ),
            )
          ],
        ),
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
      ),
    );
  }
}
