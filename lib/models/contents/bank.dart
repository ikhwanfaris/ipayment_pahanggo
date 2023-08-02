import 'package:json_annotation/json_annotation.dart';
part 'bank.g.dart';

@JsonSerializable(explicitToJson: true)
class Bank {
  Bank({
    required this.code,
    required this.name,
    required this.active,
    this.browser,
    this.iosApplicationId,
    this.androidApplicationId,
    this.redirectUrls,
  });

  String code;
  String name;
  bool active;
  String? browser;
  String? iosApplicationId;
  String? androidApplicationId;
  List<RedirectUrl>? redirectUrls;

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

  Map<String, dynamic> toJson() => _$BankToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RedirectUrl {
  RedirectUrl({
    required this.type,
    required this.url,
  });

  String type;
  String url;

  factory RedirectUrl.fromJson(Map<String, dynamic> json) =>
      _$RedirectUrlFromJson(json);

  Map<String, dynamic> toJson() => _$RedirectUrlToJson(this);
}
