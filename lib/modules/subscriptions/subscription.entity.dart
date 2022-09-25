import 'package:json_annotation/json_annotation.dart';
part 'subscription.entity.g.dart';

enum PaymentCycle {
  month,
  twoMonths,
  threeMonths,
  sixMonths,
  year,
}

@JsonSerializable()
class Subscription {
  late int subscription_id;
  late String name;
  late int price;
  late PaymentCycle payment_cycle;
  late DateTime first_payment_date;
  late String payment_method;
  late String? remarks;
  late String? image_url;

  Subscription({
    required this.subscription_id,
    required this.name,
    required this.price,
    required this.payment_cycle,
    required this.first_payment_date,
    required this.payment_method,
    this.remarks,
    this.image_url,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);
}

@JsonSerializable()
class ResponseData {
  late ResponseSubscriptions data;

  ResponseData({
    required this.data,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
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
class CreateRequestData {
  late int user_id;
  late CreateRequestSubscription subscriptions;

  CreateRequestData({
    required this.user_id,
    required this.subscriptions,
  });

  factory CreateRequestData.fromJson(Map<String, dynamic> json) =>
      _$CreateRequestDataFromJson(json);
  Map<String, dynamic> toJson() => _$CreateRequestDataToJson(this);
}

@JsonSerializable()
class CreateRequestSubscription {
  late String name;
  late int price;
  late PaymentCycle payment_cycle;
  late DateTime first_payment_date;
  late String payment_method;
  late String remarks;
  late String image_url;

  CreateRequestSubscription({
    required this.name,
    required this.price,
    required this.payment_cycle,
    required this.first_payment_date,
    required this.payment_method,
    required this.remarks,
    required this.image_url,
  });

  factory CreateRequestSubscription.fromJson(Map<String, dynamic> json) =>
      _$CreateRequestSubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$CreateRequestSubscriptionToJson(this);
}
