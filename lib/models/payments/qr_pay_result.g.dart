// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_pay_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QrPayResult _$QrPayResultFromJson(Map<String, dynamic> json) => QrPayResult(
      referenceNumber: json['reference_number'] as String?,
      qrCodeString: json['qr_code_string'] as String?,
      qrImage: json['qr_image'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$QrPayResultToJson(QrPayResult instance) =>
    <String, dynamic>{
      'reference_number': instance.referenceNumber,
      'qr_code_string': instance.qrCodeString,
      'qr_image': instance.qrImage,
      'error': instance.error,
    };
