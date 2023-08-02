// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Matrix _$MatrixFromJson(Map<String, dynamic> json) => Matrix(
      filters: (json['filters'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => FilterItem.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      products: (json['products'] as List<dynamic>)
          .map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MatrixToJson(Matrix instance) => <String, dynamic>{
      'filters': instance.filters
          .map((e) => e.map((e) => e.toJson()).toList())
          .toList(),
      'products': instance.products.map((e) => e.toJson()).toList(),
    };

FilterItem _$FilterItemFromJson(Map<String, dynamic> json) => FilterItem(
      json['id'] as int,
      (json['chains'] as List<dynamic>)
          .map((e) => Chain.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['name'] as String,
    );

Map<String, dynamic> _$FilterItemToJson(FilterItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chains': instance.chains.map((e) => e.toJson()).toList(),
      'name': instance.name,
    };

Chain _$ChainFromJson(Map<String, dynamic> json) => Chain(
      json['id'] as int,
      json['name'] as String,
    );

Map<String, dynamic> _$ChainToJson(Chain instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
      id: json['id'] as int,
      chains: (json['chains'] as List<dynamic>)
          .map((e) => Chains.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
      unit: json['unit'] as String,
      checkStock: json['check_stock'] as bool?,
      stock: json['stock'] as int,
      price: json['price'] as String,
      classificationCodeId: json['classification_code_id'] as int?,
      quotaGroup: json['quota_group'] as int?,
      checkQuota: json['check_quota'] as bool?,
      dailyQuota: json['daily_quota'] as int?,
    )..select = json['select'] as bool? ?? false;

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'id': instance.id,
      'chains': instance.chains.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'unit': instance.unit,
      'stock': instance.stock,
      'price': instance.price,
      'check_stock': instance.checkStock,
      'classification_code_id': instance.classificationCodeId,
      'quota_group': instance.quotaGroup,
      'check_quota': instance.checkQuota,
      'daily_quota': instance.dailyQuota,
    };

Chains _$ChainsFromJson(Map<String, dynamic> json) => Chains(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ChainsToJson(Chains instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Subitem _$SubitemFromJson(Map<String, dynamic> json) => Subitem(
      quantities: (json['quantities'] as List<dynamic>)
          .map((e) => Quantity.fromJson(e as Map<String, dynamic>))
          .toList(),
      headers: (json['headers'] as List<dynamic>)
          .map((e) => Header.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubitemToJson(Subitem instance) => <String, dynamic>{
      'headers': instance.headers.map((e) => e.toJson()).toList(),
      'quantities': instance.quantities.map((e) => e.toJson()).toList(),
    };

Quantity _$QuantityFromJson(Map<String, dynamic> json) => Quantity(
      rate: Rate.fromJson(json['rate'] as Map<String, dynamic>),
      unit: Unit.fromJson(json['unit'] as Map<String, dynamic>),
      id: json['id'] as int?,
      hasStockTracking:
          const HandleLaravelBoolStock().fromJson(json['has_stock_tracking']),
      stock: json['stock'] as int?,
      remainingStock: json['remaining_stock'] as int?,
      classificationCodeId: json['classification_code_id'] as int?,
      amount: const RxIntConverter().fromJson(json['amount'] as int),
      favorite: json['favorite'] as bool?,
      bill_mask: json['bill_mask'] as String?,
    )..select = json['select'] as bool? ?? false;

Map<String, dynamic> _$QuantityToJson(Quantity instance) => <String, dynamic>{
      'rate': instance.rate.toJson(),
      'unit': instance.unit.toJson(),
      'id': instance.id,
      'favorite': instance.favorite,
      'bill_mask': instance.bill_mask,
      'has_stock_tracking':
          const HandleLaravelBoolStock().toJson(instance.hasStockTracking),
      'stock': instance.stock,
      'remaining_stock': instance.remainingStock,
      'classification_code_id': instance.classificationCodeId,
      'amount': const RxIntConverter().toJson(instance.amount),
    };

Header _$HeaderFromJson(Map<String, dynamic> json) => Header(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$HeaderToJson(Header instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Rate _$RateFromJson(Map<String, dynamic> json) => Rate(
      title: json['title'] as String?,
      value: const ToStringConverter().fromJson(json['value']),
    );

Map<String, dynamic> _$RateToJson(Rate instance) => <String, dynamic>{
      'title': instance.title,
      'value': const ToStringConverter().toJson(instance.value),
    };

Unit _$UnitFromJson(Map<String, dynamic> json) => Unit(
      title: json['title'],
      value: json['value'] as String?,
    );

Map<String, dynamic> _$UnitToJson(Unit instance) => <String, dynamic>{
      'title': instance.title,
      'value': instance.value,
    };
