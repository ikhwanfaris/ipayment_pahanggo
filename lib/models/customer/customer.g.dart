// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: json['id'] as int,
      userIdentityTypeId: json['user_identity_type_id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      userIdentityType: json['user_identity_type'] == null
          ? null
          : UserIdentityType.fromJson(
              json['user_identity_type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'user_identity_type_id': instance.userIdentityTypeId,
    'first_name': instance.firstName,
    'last_name': instance.lastName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('user_identity_type', instance.userIdentityType?.toJson());
  return val;
}
