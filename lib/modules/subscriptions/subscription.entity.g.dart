// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      paymentCycle: $enumDecode(_$PaymentCycleEnumMap, json['paymentCycle']),
      firstPaymentDate: DateTime.parse(json['firstPaymentDate'] as String),
      paymentMethod: $enumDecode(_$PaymentMethodEnumMap, json['paymentMethod']),
      isPaused: json['isPaused'] as bool,
      remarks: json['remarks'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'paymentCycle': _$PaymentCycleEnumMap[instance.paymentCycle]!,
      'firstPaymentDate': instance.firstPaymentDate.toIso8601String(),
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
      'isPaused': instance.isPaused,
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

FindAllResponseData _$FindAllResponseDataFromJson(Map<String, dynamic> json) =>
    FindAllResponseData(
      data:
          ResponseSubscriptions.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FindAllResponseDataToJson(
        FindAllResponseData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

CreateResponseData _$CreateResponseDataFromJson(Map<String, dynamic> json) =>
    CreateResponseData(
      data: Subscription.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateResponseDataToJson(CreateResponseData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

UpdateResponseData _$UpdateResponseDataFromJson(Map<String, dynamic> json) =>
    UpdateResponseData(
      data: Subscription.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateResponseDataToJson(UpdateResponseData instance) =>
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

RequestData _$RequestDataFromJson(Map<String, dynamic> json) => RequestData(
      userId: json['userId'] as String,
      subscription: RequestSubscription.fromJson(
          json['subscription'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequestDataToJson(RequestData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'subscription': instance.subscription,
    };

RequestSubscription _$RequestSubscriptionFromJson(Map<String, dynamic> json) =>
    RequestSubscription(
      name: json['name'] as String,
      price: json['price'] as int,
      paymentCycle: $enumDecode(_$PaymentCycleEnumMap, json['paymentCycle']),
      firstPaymentDate: DateTime.parse(json['firstPaymentDate'] as String),
      paymentMethod: $enumDecode(_$PaymentMethodEnumMap, json['paymentMethod']),
      isPause: json['isPause'] as bool,
      image: json['image'] as String?,
      remarks: json['remarks'] as String?,
    );

Map<String, dynamic> _$RequestSubscriptionToJson(
        RequestSubscription instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'paymentCycle': _$PaymentCycleEnumMap[instance.paymentCycle]!,
      'firstPaymentDate': instance.firstPaymentDate.toIso8601String(),
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
      'isPause': instance.isPause,
      'image': instance.image,
      'remarks': instance.remarks,
    };
