import 'package:json_annotation/json_annotation.dart';

part 'account.entity.g.dart';

enum Currency {
  JPY,
  USD,
}

enum Language {
  Japanese,
  English,
}

@JsonSerializable()
class Account {
  late String userId;
  late Currency currency;
  late Language language;

  Account({
    required this.userId,
    required this.currency,
    required this.language,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable()
class ResponseData {
  late Account data;

  ResponseData({
    required this.data,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}
