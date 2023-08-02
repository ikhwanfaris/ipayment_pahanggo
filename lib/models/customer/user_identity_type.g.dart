// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_identity_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserIdentityType _$UserIdentityTypeFromJson(Map<String, dynamic> json) =>
    UserIdentityType(
      id: json['id'] as int?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$UserIdentityTypeToJson(UserIdentityType instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('category', instance.category);
  return val;
}
