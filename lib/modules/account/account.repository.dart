import 'package:flutter/material.dart';
import 'package:subscription_app_web/lib/api.dart';
import 'package:subscription_app_web/main.dart';
import 'package:subscription_app_web/modules/account/account.entity.dart';

class AccountRepository {
  static Future<ResponseData> fetch(String id) async {
    final res = await api().get("/account/$id");
    logger.d("res: $res");
    return ResponseData.fromJson(res.data);
  }

  static Future<ResponseData> create(RequestData postData) async {
    final res = await api().post("/account", data: postData);
    debugPrint(res.data);
    return ResponseData.fromJson(res.data);
  }
}
