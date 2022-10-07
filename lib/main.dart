import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_app_web/lib/checkAccountExists.dart';
import 'package:subscription_app_web/modules/account/account.entity.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';
import 'check_account_exists.dart';

final subscriptionsProvider = StateProvider<List<Subscription>>((ref) => []);
final currentUserProvider = StateProvider<Account?>((ref) => null);

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  bool isCurrentUserExists = false;

  _setCurrentUser(Account? account) {
    ref.read(currentUserProvider.notifier).state = account;
  }

  @override
  void initState() {
    checkAccountExists(_setCurrentUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'subscription_app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CheckAccountExists(),
    );
  }
}
