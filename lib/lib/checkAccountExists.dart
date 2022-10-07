import 'package:flutter/foundation.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:subscription_app_web/modules/account/account.entity.dart';
import 'package:subscription_app_web/modules/account/account.repository.dart';

Future checkAccountExists(Function(Account?) setAccount) async {
  try {
    String? deviceId = await PlatformDeviceId.getDeviceId;

    if (deviceId == null) return;
    final res = await AccountRepository.fetch(deviceId);
    setAccount(res.data);
  } catch (e) {
    debugPrint(e.toString());
  }
}
