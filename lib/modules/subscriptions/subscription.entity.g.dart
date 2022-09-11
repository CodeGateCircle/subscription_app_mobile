// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
      subscription_id: json['subscription_id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      payment_cycle: $enumDecode(_$PaymentCycleEnumMap, json['payment_cycle']),
      first_payment_date: DateTime.parse(json['first_payment_date'] as String),
      payment_method: json['payment_method'] as String,
      remarks: json['remarks'] as String?,
      image_url: json['image_url'] as String?,
    );

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'subscription_id': instance.subscription_id,
      'name': instance.name,
      'price': instance.price,
      'payment_cycle': _$PaymentCycleEnumMap[instance.payment_cycle]!,
      'first_payment_date': instance.first_payment_date.toIso8601String(),
      'payment_method': instance.payment_method,
      'remarks': instance.remarks,
      'image_url': instance.image_url,
    };

const _$PaymentCycleEnumMap = {
  PaymentCycle.month: 'month',
  PaymentCycle.twoMonths: 'twoMonths',
  PaymentCycle.threeMonths: 'threeMonths',
  PaymentCycle.sixMonths: 'sixMonths',
  PaymentCycle.year: 'year',
};

FindAllResultData _$FindAllResultDataFromJson(Map<String, dynamic> json) =>
    FindAllResultData(
      data: FindAllResult.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FindAllResultDataToJson(FindAllResultData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

FindAllResult _$FindAllResultFromJson(Map<String, dynamic> json) =>
    FindAllResult(
      subscriptions: (json['subscriptions'] as List<dynamic>)
          .map((e) => Subscription.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FindAllResultToJson(FindAllResult instance) =>
    <String, dynamic>{
      'subscriptions': instance.subscriptions,
    };
