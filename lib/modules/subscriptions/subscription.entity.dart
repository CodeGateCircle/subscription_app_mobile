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
class FindAllResultData {
  FindAllResult data;

  FindAllResultData({
    required this.data,
  });

  factory FindAllResultData.fromJson(Map<String, dynamic> json) =>
      _$FindAllResultDataFromJson(json);
  Map<String, dynamic> toJson() => _$FindAllResultDataToJson(this);
}

@JsonSerializable()
class FindAllResult {
  List<Subscription> subscriptions;

  FindAllResult({
    required this.subscriptions,
  });

  factory FindAllResult.fromJson(Map<String, dynamic> json) =>
      _$FindAllResultFromJson(json);
  Map<String, dynamic> toJson() => _$FindAllResultToJson(this);
}
