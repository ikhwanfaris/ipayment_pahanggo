// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceMenu _$ServiceMenuFromJson(Map<String, dynamic> json) => ServiceMenu(
      id: json['id'] as int?,
      agencyId: json['agency_id'] as int?,
      serviceReferenceNumber: json['service_reference_number'] as String,
      name: json['name'] as String?,
      ministryId: json['ministry_id'] as int?,
      matrix: json['matrix'] == null
          ? null
          : Matrix.fromJson(json['matrix'] as Map<String, dynamic>),
      favorite: json['favorite'] as bool,
      agency: Agency.fromJson(json['agency'] as Map<String, dynamic>),
    )
      ..billTypeId = json['bill_type_id'] as int?
      ..ministry = json['ministry'] == null
          ? null
          : Ministry.fromJson(json['ministry'] as Map<String, dynamic>);

Map<String, dynamic> _$ServiceMenuToJson(ServiceMenu instance) =>
    <String, dynamic>{
      'id': instance.id,
      'agency_id': instance.agencyId,
      'ministry_id': instance.ministryId,
      'service_reference_number': instance.serviceReferenceNumber,
      'name': instance.name,
      'matrix': instance.matrix?.toJson(),
      'bill_type_id': instance.billTypeId,
      'favorite': instance.favorite,
      'agency': instance.agency.toJson(),
      'ministry': instance.ministry?.toJson(),
    };

Agency _$AgencyFromJson(Map<String, dynamic> json) => Agency(
      id: json['id'] as int,
      name: json['name'] as String,
      logoPath: json['logo_path'],
    );

Map<String, dynamic> _$AgencyToJson(Agency instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo_path': instance.logoPath,
    };

Matrix _$MatrixFromJson(Map<String, dynamic> json) => Matrix(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MatrixToJson(Matrix instance) => <String, dynamic>{
      'products': instance.products?.map((e) => e.toJson()).toList(),
    };

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
      id: json['id'] as int?,
      name: json['name'] as String?,
      unit: json['unit'] as String?,
      checkStock: json['check_stock'] as bool?,
      stock: json['stock'] as int?,
      price: json['price'] as String?,
      classificationCodeId: json['classification_code_id'] as int?,
      quotaGroup: json['quota_group'] as int?,
      checkQuota: json['check_quota'] as bool?,
      dailyQuota: json['daily_quota'] as int?,
    );

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'unit': instance.unit,
      'check_stock': instance.checkStock,
      'stock': instance.stock,
      'price': instance.price,
      'classification_code_id': instance.classificationCodeId,
      'quota_group': instance.quotaGroup,
      'check_quota': instance.checkQuota,
      'daily_quota': instance.dailyQuota,
    };
