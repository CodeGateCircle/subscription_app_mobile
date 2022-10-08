import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';

class SubscriptionsNotifier extends StateNotifier<List<Subscription>> {
  SubscriptionsNotifier() : super([]);

  void add(Subscription subscription) {
    state = [...state, subscription];
  }

  void delete(int subscriptionId) {
    state = state
        .where((subscription) => subscription.id != subscriptionId)
        .toList();
  }

  void replace(Subscription updatedSubscription) {
    state = [
      for (final subscription in state)
        if (subscription.id == updatedSubscription.id)
          updatedSubscription
        else
          subscription,
    ];
  }

  void sort(String? key) {
    switch (key) {
      case 'name_asc':
        state.sort((v1, v2) => v1.name.compareTo(v2.name));
        break;
      case 'name_desc':
        state.sort((v1, v2) => v2.name.compareTo(v1.name));
        break;
      case 'price_asc':
        state.sort((v1, v2) => v1.price.compareTo(v2.price));
        break;
      case 'price_desc':
        state.sort((v1, v2) => v2.price.compareTo(v1.price));
        break;
      case 'payment_day_asc':
        // TODO 計算して表示する
        state.sort((v1, v2) => v1.price.compareTo(v2.price));
        break;
      case 'payment_day_desc':
        state.sort((v1, v2) => v1.price.compareTo(v2.price));
        break;
    }
  }
}

final subscriptionsProvider =
    StateNotifierProvider<SubscriptionsNotifier, List<Subscription>>((ref) {
  return SubscriptionsNotifier();
});
