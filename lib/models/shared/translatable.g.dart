// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translatable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Translatables _$TranslatablesFromJson(Map<String, dynamic> json) =>
    Translatables(
      id: json['id'] as int?,
      translatableId: json['translatable_id'] as int?,
      translatableType: json['translatable_type'] as String?,
      path: json['path'] as String?,
      language: json['language'] as String?,
      content: json['content'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$TranslatablesToJson(Translatables instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('translatable_id', instance.translatableId);
  writeNotNull('translatable_type', instance.translatableType);
  writeNotNull('path', instance.path);
  writeNotNull('language', instance.language);
  writeNotNull('content', instance.content);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  return val;
}
