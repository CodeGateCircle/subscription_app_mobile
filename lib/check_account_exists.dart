import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:subscription_app_web/main.dart';
import 'package:subscription_app_web/screens/home/home_screen.dart';
import 'package:subscription_app_web/screens/login/login_screen.dart';

import 'modules/account/account.repository.dart';

class CheckAccountExists extends ConsumerStatefulWidget {
  const CheckAccountExists({Key? key}) : super(key: key);

  @override
  CheckAccountExistsState createState() => CheckAccountExistsState();
}

class CheckAccountExistsState extends ConsumerState<CheckAccountExists> {
  bool _isLoading = false;

  Future<void> fetchUserInfo() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String? deviceId = await PlatformDeviceId.getDeviceId;

      if (deviceId == null) return;
      final res = await AccountRepository.fetch(deviceId);
      ref.read(currentUserProvider.notifier).state = res.data;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: Text("Loading..."),
        ),
      );
    }

    return ref.watch(currentUserProvider) == null
        ? const Login()
        : const Home();
  }
}
