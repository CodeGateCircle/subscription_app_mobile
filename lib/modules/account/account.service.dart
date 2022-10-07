import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:subscription_app_web/modules/account/account.repository.dart';
import 'account.entity.dart';

class AccountService {
  static Future<Account?> login(Language language, Currency currency) async {
    try {
      String? deviceId = await PlatformDeviceId.getDeviceId;
      if (deviceId == null) return null;

      final postData = Account(
        userId: deviceId,
        currency: currency,
        language: language,
      );
      final res = await AccountRepository.create(postData);
      return res.data;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
