// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agency _$AgencyFromJson(Map<String, dynamic> json) => Agency(
      id: json['id'] as int,
      name: json['name'] as String,
      code: json['code'] as String?,
      profile: json['profile'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$AgencyToJson(Agency instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  writeNotNull('profile', instance.profile);
  writeNotNull('address', instance.address);
  return val;
}
