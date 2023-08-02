// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentsRequest _$PaymentsRequestFromJson(Map<String, dynamic> json) =>
    PaymentsRequest(
      amount: json['amount'] as String,
      source: json['source'] as String,
      transactionItems: json['transaction_items'] as String,
      paymentMethod: json['payment_method'] as String,
      referenceNumber: json['reference_number'] as String?,
      bankCode: json['bank_code'] as String?,
      redirectUrl: json['redirect_url'] as String?,
    );

Map<String, dynamic> _$PaymentsRequestToJson(PaymentsRequest instance) {
  final val = <String, dynamic>{
    'amount': instance.amount,
    'source': instance.source,
    'transaction_items': instance.transactionItems,
    'payment_method': instance.paymentMethod,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('reference_number', instance.referenceNumber);
  writeNotNull('bank_code', instance.bankCode);
  writeNotNull('redirect_url', instance.redirectUrl);
  return val;
}

Payments _$PaymentsFromJson(Map<String, dynamic> json) => Payments(
      referenceNumber: json['reference_number'] as String?,
      qrCodeString: json['qr_code_string'] as String?,
      qrImage: json['qr_image'] as String?,
      redirect: json['redirect'] as String?,
      amount: json['amount'] as String?,
      paymentType: json['payment_type'] as int?,
    );

Map<String, dynamic> _$PaymentsToJson(Payments instance) => <String, dynamic>{
      'reference_number': instance.referenceNumber,
      'qr_code_string': instance.qrCodeString,
      'qr_image': instance.qrImage,
      'redirect': instance.redirect,
      'amount': instance.amount,
      'payment_type': instance.paymentType,
    };

CartPayRequest _$CartPayRequestFromJson(Map<String, dynamic> json) =>
    CartPayRequest(
      ids: (json['ids[]'] as List<dynamic>).map((e) => e as int).toList(),
      source: json['source'] as String,
      paymentMethod: json['payment_method'] as String,
      redirectUrl: json['redirect_url'] as String?,
      bankCode: json['bank_code'] as String?,
      bankType: json['bank_type'] as String?,
    );

Map<String, dynamic> _$CartPayRequestToJson(CartPayRequest instance) {
  final val = <String, dynamic>{
    'ids[]': instance.ids,
    'source': instance.source,
    'payment_method': instance.paymentMethod,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('redirect_url', instance.redirectUrl);
  writeNotNull('bank_code', instance.bankCode);
  writeNotNull('bank_type', instance.bankType);
  return val;
}
