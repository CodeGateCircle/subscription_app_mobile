import 'package:json_annotation/json_annotation.dart';
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

@JsonSerializable()
class Subscription {
  late int subscriptionId;
  late String name;
  late int price;
  late PaymentCycle paymentCycle;
  late DateTime firstPaymentDate;
  late PaymentMethod paymentMethod;
  late String? remarks;
  late String? imageUrl;

  Subscription({
    required this.subscriptionId,
    required this.name,
    required this.price,
    required this.paymentCycle,
    required this.firstPaymentDate,
    required this.paymentMethod,
    this.remarks,
    this.imageUrl,
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
  late int userId;
  late CreateRequestSubscription subscriptions;

  CreateRequestData({
    required this.userId,
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
  late PaymentCycle paymentCycle;
  late DateTime firstPaymentDate;
  late PaymentMethod paymentMethod;
  late String remarks;
  late String imageUrl;

  CreateRequestSubscription({
    required this.name,
    required this.price,
    required this.paymentCycle,
    required this.firstPaymentDate,
    required this.paymentMethod,
    required this.remarks,
    required this.imageUrl,
  });

  factory CreateRequestSubscription.fromJson(Map<String, dynamic> json) =>
      _$CreateRequestSubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$CreateRequestSubscriptionToJson(this);
}
