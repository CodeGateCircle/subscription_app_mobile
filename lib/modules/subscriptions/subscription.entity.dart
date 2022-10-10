import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'subscription.entity.g.dart';

enum PaymentCycle {
  oneMonth,
  twoMonths,
  threeMonths,
  sixMonths,
  year,
}

enum PaymentMethod {
  cash,
  card,
}

enum SortKey {
  nameAsc,
  nameDesc,
  priceAsc,
  priceDesc,
  paymentDayAsc,
  paymentDayDesc
}

extension PaymentMethodeExt on PaymentMethod {
  String paymentMethod(BuildContext context) {
    switch (this) {
      case PaymentMethod.cash:
        return AppLocalizations.of(context)!.cash;
      case PaymentMethod.card:
        return AppLocalizations.of(context)!.creditCards;
    }
  }
}

@JsonSerializable()
class Subscription {
  late int id;
  late String name;
  late double price;
  late PaymentCycle paymentCycle;
  late DateTime firstPaymentDate;
  late PaymentMethod paymentMethod;
  late bool isPaused;
  late String? remarks;
  late String? imageUrl;

  Subscription({
    required this.id,
    required this.name,
    required this.price,
    required this.paymentCycle,
    required this.firstPaymentDate,
    required this.paymentMethod,
    required this.isPaused,
    this.remarks,
    this.imageUrl,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);

  int getPaymentCycleDays() {
    switch (paymentCycle) {
      case PaymentCycle.oneMonth:
        return 31;
      case PaymentCycle.twoMonths:
        return 62;
      case PaymentCycle.threeMonths:
        return 93;
      case PaymentCycle.sixMonths:
        return 183;
      case PaymentCycle.year:
        return 365;
    }
  }

  int daysUntilNextBill() {
    int calcDays(DateTime dt, int month) {
      final now = DateTime.now();
      int m = month;
      DateTime afterDt = DateTime(dt.year, dt.month, dt.day);
      while (now.isAfter(afterDt) && now.difference(afterDt).inDays != 0) {
        afterDt = DateTime(dt.year, dt.month + m, dt.day);
        if (dt.day > 28 && afterDt.day < 4) {
          int lastDay = DateTime(afterDt.year, afterDt.month, 0).day;
          afterDt = DateTime(afterDt.year, afterDt.month - 1, lastDay);
        }
        m += month;
      }
      return afterDt.difference(now).inDays;
    }

    switch (paymentCycle) {
      case PaymentCycle.oneMonth:
        return calcDays(firstPaymentDate, 1);
      case PaymentCycle.twoMonths:
        return calcDays(firstPaymentDate, 2);
      case PaymentCycle.threeMonths:
        return calcDays(firstPaymentDate, 3);
      case PaymentCycle.sixMonths:
        return calcDays(firstPaymentDate, 6);
      case PaymentCycle.year:
        return calcDays(firstPaymentDate, 12);
    }
  }

  String formatPaymentCycle(BuildContext context) {
    switch (paymentCycle) {
      case PaymentCycle.oneMonth:
        return AppLocalizations.of(context)!.monthlyContract;
      case PaymentCycle.twoMonths:
        return AppLocalizations.of(context)!.twoMonthContract;
      case PaymentCycle.threeMonths:
        return AppLocalizations.of(context)!.threeMonthContract;
      case PaymentCycle.sixMonths:
        return AppLocalizations.of(context)!.semiannualContract;
      case PaymentCycle.year:
        return AppLocalizations.of(context)!.yearContract;
    }
  }

  double convertMonthlyFee() {
    const double baseNumber = 10;
    double monthlyFee = 0;
    switch (paymentCycle) {
      case PaymentCycle.oneMonth:
        monthlyFee = price;
        break;
      case PaymentCycle.twoMonths:
        monthlyFee = (price / 2 * baseNumber).round() / baseNumber;
        break;
      case PaymentCycle.threeMonths:
        monthlyFee = (price / 3 * baseNumber).round() / baseNumber;
        break;
      case PaymentCycle.sixMonths:
        monthlyFee = (price / 6 * baseNumber).round() / baseNumber;
        break;
      case PaymentCycle.year:
        monthlyFee = (price / 12 * baseNumber).round() / baseNumber;
        break;
    }
    return monthlyFee;
  }
}

@JsonSerializable()
class FindAllResponseData {
  late ResponseSubscriptions data;

  FindAllResponseData({
    required this.data,
  });

  factory FindAllResponseData.fromJson(Map<String, dynamic> json) =>
      _$FindAllResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$FindAllResponseDataToJson(this);
}

@JsonSerializable()
class CreateResponseData {
  late CreateResponseSubscription data;

  CreateResponseData({
    required this.data,
  });

  factory CreateResponseData.fromJson(Map<String, dynamic> json) =>
      _$CreateResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$CreateResponseDataToJson(this);
}

@JsonSerializable()
class CreateResponseSubscription {
  late Subscription subscription;

  CreateResponseSubscription({
    required this.subscription,
  });

  factory CreateResponseSubscription.fromJson(Map<String, dynamic> json) =>
      _$CreateResponseSubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$CreateResponseSubscriptionToJson(this);
}

@JsonSerializable()
class UpdateResponseData {
  late UpdateResponseSubscription data;

  UpdateResponseData({
    required this.data,
  });

  factory UpdateResponseData.fromJson(Map<String, dynamic> json) =>
      _$UpdateResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateResponseDataToJson(this);
}

@JsonSerializable()
class UpdateResponseSubscription {
  late Subscription subscription;

  UpdateResponseSubscription({
    required this.subscription,
  });

  factory UpdateResponseSubscription.fromJson(Map<String, dynamic> json) =>
      _$UpdateResponseSubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateResponseSubscriptionToJson(this);
}

@JsonSerializable()
class ResponseSubscriptions {
  late List<Subscription> subscriptions;

  ResponseSubscriptions({
    required this.subscriptions,
  });

  factory ResponseSubscriptions.fromJson(Map<String, dynamic> json) =>
      _$ResponseSubscriptionsFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseSubscriptionsToJson(this);
}

@JsonSerializable()
class RequestData {
  late String userId;
  late RequestSubscription subscription;

  RequestData({
    required this.userId,
    required this.subscription,
  });

  factory RequestData.fromJson(Map<String, dynamic> json) =>
      _$RequestDataFromJson(json);
  Map<String, dynamic> toJson() => _$RequestDataToJson(this);
}

@JsonSerializable()
class RequestSubscription {
  late String name;
  late double price;
  late PaymentCycle paymentCycle;
  late DateTime firstPaymentDate;
  late PaymentMethod paymentMethod;
  late bool isPaused;
  late String? image;
  late String? imageUrl;
  late String? remarks;

  RequestSubscription({
    required this.name,
    required this.price,
    required this.paymentCycle,
    required this.firstPaymentDate,
    required this.paymentMethod,
    required this.isPaused,
    this.image,
    this.imageUrl,
    this.remarks,
  });

  factory RequestSubscription.fromJson(Map<String, dynamic> json) =>
      _$RequestSubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$RequestSubscriptionToJson(this);
}
