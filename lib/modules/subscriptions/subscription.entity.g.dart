// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
      subscriptionId: json['subscriptionId'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      paymentCycle: $enumDecode(_$PaymentCycleEnumMap, json['paymentCycle']),
      firstPaymentDate: DateTime.parse(json['firstPaymentDate'] as String),
      paymentMethod: $enumDecode(_$PaymentMethodEnumMap, json['paymentMethod']),
      remarks: json['remarks'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'subscriptionId': instance.subscriptionId,
      'name': instance.name,
      'price': instance.price,
      'paymentCycle': _$PaymentCycleEnumMap[instance.paymentCycle]!,
      'firstPaymentDate': instance.firstPaymentDate.toIso8601String(),
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
      'remarks': instance.remarks,
      'imageUrl': instance.imageUrl,
    };

const _$PaymentCycleEnumMap = {
  PaymentCycle.oneMonth: 'oneMonth',
  PaymentCycle.twoMonths: 'twoMonths',
  PaymentCycle.threeMonths: 'threeMonths',
  PaymentCycle.sixMonths: 'sixMonths',
  PaymentCycle.year: 'year',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.cash: 'cash',
  PaymentMethod.card: 'card',
};

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) => ResponseData(
      data:
          ResponseSubscriptions.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ResponseSubscriptions _$ResponseSubscriptionsFromJson(
        Map<String, dynamic> json) =>
    ResponseSubscriptions(
      subscriptions: (json['subscriptions'] as List<dynamic>)
          .map((e) => Subscription.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseSubscriptionsToJson(
        ResponseSubscriptions instance) =>
    <String, dynamic>{
      'subscriptions': instance.subscriptions,
    };

CreateRequestData _$CreateRequestDataFromJson(Map<String, dynamic> json) =>
    CreateRequestData(
      userId: json['userId'] as int,
      subscriptions: CreateRequestSubscription.fromJson(
          json['subscriptions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateRequestDataToJson(CreateRequestData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'subscriptions': instance.subscriptions,
    };

CreateRequestSubscription _$CreateRequestSubscriptionFromJson(
        Map<String, dynamic> json) =>
    CreateRequestSubscription(
      name: json['name'] as String,
      price: json['price'] as int,
      paymentCycle: $enumDecode(_$PaymentCycleEnumMap, json['paymentCycle']),
      firstPaymentDate: DateTime.parse(json['firstPaymentDate'] as String),
      paymentMethod: $enumDecode(_$PaymentMethodEnumMap, json['paymentMethod']),
      remarks: json['remarks'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$CreateRequestSubscriptionToJson(
        CreateRequestSubscription instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'paymentCycle': _$PaymentCycleEnumMap[instance.paymentCycle]!,
      'firstPaymentDate': instance.firstPaymentDate.toIso8601String(),
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
      'remarks': instance.remarks,
      'imageUrl': instance.imageUrl,
    };
