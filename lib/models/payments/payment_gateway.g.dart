// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_gateway.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentGateway _$PaymentGatewayFromJson(Map<String, dynamic> json) =>
    PaymentGateway(
      id: json['id'] as int,
      name: json['name'] as String?,
      description: json['description'] as String?,
      logo: json['logo'],
      owner: json['owner'] as String?,
      address: json['address'] as String?,
      admin: json['admin'] as String?,
      position: json['position'] as String?,
      officialEmail: json['official_email'] as String?,
      officePhone: json['office_phone'],
      isActive: json['is_active'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      translatables: (json['translatables'] as List<dynamic>?)
          ?.map((e) => Translatables.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentGatewayToJson(PaymentGateway instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'logo': instance.logo,
      'owner': instance.owner,
      'address': instance.address,
      'admin': instance.admin,
      'position': instance.position,
      'official_email': instance.officialEmail,
      'office_phone': instance.officePhone,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'translatables': instance.translatables?.map((e) => e.toJson()).toList(),
    };
