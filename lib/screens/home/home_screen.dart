import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_app_web/config/app_color.dart';
import 'package:subscription_app_web/main.dart';
import 'package:subscription_app_web/modules/account/account.store.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.repository.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.store.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
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
  double totalAmount = 0;

  double calculateTotalAmount() {
    setState(() => totalAmount = 0);
    for (final subscription in ref.watch(subscriptionsProvider)) {
      final monthlyFee = subscription.convertMonthlyFee();
      setState(() => totalAmount = totalAmount + monthlyFee);
    }
    return totalAmount;
  }

  void sortSubscriptionList(SortKey? key) {
    ref.read(subscriptionsProvider.notifier).sort(key);
  }

  Future<void> initializeData() async {
    try {
      final userId = ref.watch(currentUserProvider)!.userId;
      final res = await SubscriptionRepository.findAll(userId);
      ref.read(subscriptionsProvider.notifier).state = res.data.subscriptions;
      ref.read(subscriptionsProvider.notifier).sort(null);
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
            TotalAmount(totalAmount: calculateTotalAmount()),
            Expanded(
              child: SubscriptionList(
                subscriptions: ref.watch(subscriptionsProvider),
                sortSubscriptionList: sortSubscriptionList,
              ),
            )
          ],
        ),
        floatingActionButton: SizedBox(
          width: floatingActionButtonSize,
          height: floatingActionButtonSize,
          child: FloatingActionButton(
            backgroundColor: AppColor.black,
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
