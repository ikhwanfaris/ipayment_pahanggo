// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      amount: maybeDouble(json['amount']),
      status: json['status'] as String,
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      serviceId: json['service_id'] as int?,
      billId: json['bill_id'] as int?,
      details: castListCartMatrix(json['details']),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    )
      ..service = json['service'] == null
          ? null
          : Services.fromJson(json['service'] as Map<String, dynamic>)
      ..bill = json['bill'] == null
          ? null
          : Bill.fromJson(json['bill'] as Map<String, dynamic>);

Map<String, dynamic> _$CartItemToJson(CartItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user_id', instance.userId);
  writeNotNull('service_id', instance.serviceId);
  writeNotNull('bill_id', instance.billId);
  writeNotNull('details', instance.details?.map((e) => e.toJson()).toList());
  writeNotNull('updated_at', toNull(instance.updatedAt));
  writeNotNull('created_at', toNull(instance.createdAt));
  val['amount'] = doubleToString(instance.amount);
  val['status'] = instance.status;
  writeNotNull('service', toNull(instance.service));
  writeNotNull('bill', toNull(instance.bill));
  return val;
}
