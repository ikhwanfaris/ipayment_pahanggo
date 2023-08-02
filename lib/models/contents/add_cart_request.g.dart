// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_cart_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCartRequest _$AddCartRequestFromJson(Map<String, dynamic> json) =>
    AddCartRequest(
      serviceId: json['service_id'] as String?,
      billId: json['bill_id'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      details: json['details'] as String?,
      items: json['items'] as String?,
    );

Map<String, dynamic> _$AddCartRequestToJson(AddCartRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('service_id', instance.serviceId);
  writeNotNull('bill_id', instance.billId);
  writeNotNull('amount', instance.amount);
  writeNotNull('details', instance.details);
  writeNotNull('items', instance.items);
  return val;
}
