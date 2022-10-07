import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_app_web/provider/subscriptions_notifier.dart';
import 'subscription.repository.dart';

class SubscriptionService {
  static Future loadSubscriptions() async {
    try {
      final res = await SubscriptionRepository.findAll();
      debugPrint("res: ${res.data.subscriptions}");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
