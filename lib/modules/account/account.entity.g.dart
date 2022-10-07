// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      userId: json['userId'] as String,
      currency: $enumDecode(_$CurrencyEnumMap, json['currency']),
      language: $enumDecode(_$LanguageEnumMap, json['language']),
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'userId': instance.userId,
      'currency': _$CurrencyEnumMap[instance.currency]!,
      'language': _$LanguageEnumMap[instance.language]!,
    };

const _$CurrencyEnumMap = {
  Currency.JPY: 'JPY',
  Currency.USD: 'USD',
};

const _$LanguageEnumMap = {
  Language.Japanese: 'Japanese',
  Language.English: 'English',
};

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) => ResponseData(
      data: Account.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

RequestData _$RequestDataFromJson(Map<String, dynamic> json) => RequestData(
      user_id: json['user_id'] as String,
      currency: json['currency'] as String,
      language: json['language'] as String,
    );

Map<String, dynamic> _$RequestDataToJson(RequestData instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'currency': instance.currency,
      'language': instance.language,
    };
