import 'package:json_annotation/json_annotation.dart';
part 'payments.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class PaymentsRequest {
  PaymentsRequest({
    required this.amount,
    required this.source,
    required this.transactionItems,
    required this.paymentMethod,
    this.referenceNumber,
    this.bankCode,
    this.redirectUrl,
  });

  String amount;
  String source;
  String transactionItems;
  String paymentMethod;
  String? referenceNumber;
  String? bankCode;
  String? redirectUrl;

  factory PaymentsRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentsRequestToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Payments {
  Payments({
    this.referenceNumber,
    this.qrCodeString,
    this.qrImage,
    this.redirect,
    this.amount,
    this.paymentType,
  });

  String? referenceNumber;
  String? qrCodeString;
  String? qrImage;
  String? redirect;
  String? amount;
  int? paymentType;

  factory Payments.fromJson(Map<String, dynamic> json) =>
      _$PaymentsFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentsToJson(this);
}

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class CartPayRequest {
  CartPayRequest({
    required this.ids,
    required this.source,
    required this.paymentMethod,
    this.redirectUrl,
    this.bankCode,
    this.bankType,
  });

  @JsonKey(name: "ids[]")
  List<int> ids;
  String source;
  String paymentMethod;
  String? redirectUrl;
  String? bankCode;
  String? bankType;
  factory CartPayRequest.fromJson(Map<String, dynamic> json) =>
      _$CartPayRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartPayRequestToJson(this);
}
