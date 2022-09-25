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
class Response {
  ResponseData data;

  Response({
    required this.data,
  });

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}

@JsonSerializable()
class ResponseData {
  List<Subscription> subscriptions;

  ResponseData({
    required this.subscriptions,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}
