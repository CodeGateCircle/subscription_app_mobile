import 'package:json_annotation/json_annotation.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';

part 'search_result.entity.g.dart';

@JsonSerializable()
class SearchResult {
  late String name;
  late double price;
  late PaymentCycle paymentCycle;
  late String? imageUrl;

  SearchResult({
    required this.name,
    required this.price,
    required this.paymentCycle,
    required this.imageUrl,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}

@JsonSerializable()
class ResponseData {
  late ResponseResult data;

  ResponseData({
    required this.data,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}

@JsonSerializable()
class ResponseResult {
  late List<SearchResult> result;

  ResponseResult({
    required this.result,
  });

  factory ResponseResult.fromJson(Map<String, dynamic> json) =>
      _$ResponseResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseResultToJson(this);
}
