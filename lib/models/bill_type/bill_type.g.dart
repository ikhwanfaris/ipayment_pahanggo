// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillType _$BillTypeFromJson(Map<String, dynamic> json) => BillType(
      id: json['id'] as int?,
      type: json['type'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$BillTypeToJson(BillType instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('type', instance.type);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('updated_at', instance.updatedAt);
  return val;
}
