import 'package:json_annotation/json_annotation.dart';
part 'qr_pay_result.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class QrPayResult {
  QrPayResult({
    this.referenceNumber,
    this.qrCodeString,
    this.qrImage,
    this.error,
  });

  String? referenceNumber;
  String? qrCodeString;
  String? qrImage;
  String? error;

  bool isError() {
    return error != null;
  }

  factory QrPayResult.fromJson(Map<String, dynamic> json) =>
      _$QrPayResultFromJson(json);

  Map<String, dynamic> toJson() => _$QrPayResultToJson(this);
}
