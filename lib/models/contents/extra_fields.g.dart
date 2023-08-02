// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraField _$ExtraFieldFromJson(Map<String, dynamic> json) => ExtraField(
      source: json['source'] as String?,
      placeholder: json['placeholder'] as String?,
      type: json['type'] as String?,
      fieldId: json['field_id'] as String?,
      value: const ExtraFieldValue().fromJson(json['value']),
    );

Map<String, dynamic> _$ExtraFieldToJson(ExtraField instance) =>
    <String, dynamic>{
      'source': instance.source,
      'placeholder': instance.placeholder,
      'type': instance.type,
      'field_id': instance.fieldId,
      'value': const ExtraFieldValue().toJson(instance.value),
    };
