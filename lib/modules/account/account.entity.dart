import 'package:json_annotation/json_annotation.dart';

part 'account.entity.g.dart';

enum Currency {
  JPY,
  USD,
}

extension CurrencyExt on Currency {
  String get currency {
    switch (this) {
      case Currency.JPY:
        return "JPY";
      case Currency.USD:
        return "USD";
    }
  }
}

enum Language {
  Japanese,
  English,
}

extension LanguageExt on Language {
  String get language {
    switch (this) {
      case Language.Japanese:
        return "Japanese";
      case Language.English:
        return "English";
    }
  }
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

@JsonSerializable()
class RequestData {
  late String userId;
  late String currency;
  late String language;

  RequestData({
    required this.userId,
    required this.currency,
    required this.language,
  });

  factory RequestData.fromJson(Map<String, dynamic> json) =>
      _$RequestDataFromJson(json);
  Map<String, dynamic> toJson() => _$RequestDataToJson(this);
}
