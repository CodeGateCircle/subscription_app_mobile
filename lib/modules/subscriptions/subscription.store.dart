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

  int getIndex(int id) {
    final index = state.indexWhere((subscription) => subscription.id == id);
    return index;
  }

  void sort(SortKey? key) {
    switch (key) {
      case SortKey.nameAsc:
        state.sort((v1, v2) {
          return (v1.isPaused != v2.isPaused)
              ? (v2.isPaused ? -1 : 1)
              : v1.name.compareTo(v2.name);
        });
        break;
      case SortKey.nameDesc:
        state.sort((v1, v2) {
          return (v1.isPaused != v2.isPaused)
              ? (v2.isPaused ? -1 : 1)
              : v2.name.compareTo(v1.name);
        });
        break;
      case SortKey.priceAsc:
        state.sort((v1, v2) {
          return (v1.isPaused != v2.isPaused)
              ? (v2.isPaused ? -1 : 1)
              : v1.price.compareTo(v2.price);
        });
        break;
      case SortKey.priceDesc:
        state.sort((v1, v2) {
          return (v1.isPaused != v2.isPaused)
              ? (v2.isPaused ? -1 : 1)
              : v2.price.compareTo(v1.price);
        });
        break;
      case SortKey.paymentDayAsc:
        // TODO 計算して表示する
        state.sort((v1, v2) {
          return (v1.isPaused != v2.isPaused)
              ? (v2.isPaused ? -1 : 1)
              : v1.name.compareTo(v2.name);
        });
        break;
      case SortKey.paymentDayDesc:
        state.sort((v1, v2) {
          return (v1.isPaused != v2.isPaused)
              ? (v2.isPaused ? -1 : 1)
              : v1.name.compareTo(v2.name);
        });
        break;
      case null:
        state.sort((v1, v2) {
          return (v1.isPaused != v2.isPaused)
              ? (v2.isPaused ? -1 : 1)
              : v1.name.compareTo(v2.name);
        });
        break;
    }
  }
}

final subscriptionsProvider =
    StateNotifierProvider<SubscriptionsNotifier, List<Subscription>>((ref) {
  return SubscriptionsNotifier();
});
