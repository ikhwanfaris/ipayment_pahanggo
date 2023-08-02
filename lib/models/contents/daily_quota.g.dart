// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_quota.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyQuota _$DailyQuotaFromJson(Map<String, dynamic> json) => DailyQuota(
      id: json['id'] as int?,
      productId: json['product_id'] as int?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      remaining: json['remaining'] as int?,
    );

Map<String, dynamic> _$DailyQuotaToJson(DailyQuota instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'date': instance.date?.toIso8601String(),
      'remaining': instance.remaining,
    };
