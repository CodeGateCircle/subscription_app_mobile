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
  late int price;
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

  int convertMonthlyFee() {
    int monthlyFee = 0;
    switch (paymentCycle) {
      case PaymentCycle.oneMonth:
        monthlyFee = price;
        break;
      case PaymentCycle.twoMonths:
        monthlyFee = (price / 2).round();
        break;
      case PaymentCycle.threeMonths:
        monthlyFee = (price / 3).round();
        break;
      case PaymentCycle.sixMonths:
        monthlyFee = (price / 6).round();
        break;
      case PaymentCycle.year:
        monthlyFee = (price / 12).round();
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
  late Subscription data;

  CreateResponseData({
    required this.data,
  });

  factory CreateResponseData.fromJson(Map<String, dynamic> json) =>
      _$CreateResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$CreateResponseDataToJson(this);
}

@JsonSerializable()
class UpdateResponseData {
  late Subscription data;

  UpdateResponseData({
    required this.data,
  });

  factory UpdateResponseData.fromJson(Map<String, dynamic> json) =>
      _$UpdateResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateResponseDataToJson(this);
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
  late int price;
  late PaymentCycle paymentCycle;
  late DateTime firstPaymentDate;
  late PaymentMethod paymentMethod;
  late bool isPaused;
  late String? image;
  late String? remarks;

  RequestSubscription({
    required this.name,
    required this.price,
    required this.paymentCycle,
    required this.firstPaymentDate,
    required this.paymentMethod,
    required this.isPaused,
    this.image,
    this.remarks,
  });

  factory RequestSubscription.fromJson(Map<String, dynamic> json) =>
      _$RequestSubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$RequestSubscriptionToJson(this);
}
