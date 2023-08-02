import 'package:json_annotation/json_annotation.dart';
part 'pay_result.g.dart';

@JsonSerializable(explicitToJson: true)
class PayResult {
  PayResult({required this.redirect});

  String redirect;

  String get referenceNumber => redirect.toString().split("/").last;

  factory PayResult.fromJson(Map<String, dynamic> json) =>
      _$PayResultFromJson(json);

  Map<String, dynamic> toJson() => _$PayResultToJson(this);
}
