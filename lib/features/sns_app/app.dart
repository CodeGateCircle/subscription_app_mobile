import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:subscription_app_web/features/app_bottom_navigation_bar.dartapp_bottom_navigation_bar/app_bottom_navigation_bar.dart';
import 'package:subscription_app_web/modules/account/account.repository.dart';
import 'package:subscription_app_web/provider/current_user_notifier.dart';
import 'package:subscription_app_web/screens/signUp/sign_up_screen.dart';

class SnsApp extends ConsumerStatefulWidget {
  const SnsApp({Key? key}) : super(key: key);

  @override
  SnsAppState createState() => SnsAppState();
}

class SnsAppState extends ConsumerState<SnsApp> {
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
      debugPrint("error: ${e.toString()}");
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
          child: CircularProgressIndicator(),
        ),
      );
    }

    return ref.watch(currentUserProvider) == null
        ? const SignUp()
        : const AppBottomNavigationBar();
  }
}
