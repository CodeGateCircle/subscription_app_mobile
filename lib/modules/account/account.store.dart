import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_app_web/modules/account/account.entity.dart';

class CurrentUserNotifier extends StateNotifier<Account?> {
  CurrentUserNotifier() : super(null);
}

final currentUserProvider =
    StateNotifierProvider<CurrentUserNotifier, Account?>((ref) {
  return CurrentUserNotifier();
});
