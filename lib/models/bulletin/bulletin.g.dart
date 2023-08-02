// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulletin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bulletin _$BulletinFromJson(Map<String, dynamic> json) => Bulletin(
      id: json['id'] as int?,
      translatables: (json['translatables'] as List<dynamic>?)
          ?.map((e) => Translatables.fromJson(e as Map<String, dynamic>))
          .toList(),
      displayMode: (json['displayMode'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      imageUrl: json['imageUrl'] as String?,
      attachmentUrl: json['attachmentUrl'],
    );

Map<String, dynamic> _$BulletinToJson(Bulletin instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull(
      'translatables', instance.translatables?.map((e) => e.toJson()).toList());
  writeNotNull('displayMode', instance.displayMode);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('attachmentUrl', instance.attachmentUrl);
  return val;
}
