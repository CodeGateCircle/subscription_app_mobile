// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      paymentCycle: $enumDecode(_$PaymentCycleEnumMap, json['paymentCycle']),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'paymentCycle': _$PaymentCycleEnumMap[instance.paymentCycle]!,
      'imageUrl': instance.imageUrl,
    };

const _$PaymentCycleEnumMap = {
  PaymentCycle.oneMonth: 'oneMonth',
  PaymentCycle.twoMonths: 'twoMonths',
  PaymentCycle.threeMonths: 'threeMonths',
  PaymentCycle.sixMonths: 'sixMonths',
  PaymentCycle.year: 'year',
};

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) => ResponseData(
      data: ResponseResult.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ResponseResult _$ResponseResultFromJson(Map<String, dynamic> json) =>
    ResponseResult(
      result: (json['result'] as List<dynamic>)
          .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseResultToJson(ResponseResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
