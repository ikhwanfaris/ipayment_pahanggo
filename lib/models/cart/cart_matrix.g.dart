// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_matrix.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatrixItemGroup _$MatrixItemGroupFromJson(Map<String, dynamic> json) =>
    MatrixItemGroup(
      hasDailyQuota: json['has_daily_quota'] == null
          ? false
          : nullableIntCastBool(json['has_daily_quota']),
      dailyQuota: json['daily_quota'] as int? ?? 0,
      remainingDailyQuota: json['remaining_daily_quota'] as int? ?? 0,
      subitems: (json['subitems'] as List<dynamic>?)
              ?.map((e) => MatrixItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$MatrixItemGroupToJson(MatrixItemGroup instance) {
  final val = <String, dynamic>{
    'has_daily_quota': nullableIntCastBool(instance.hasDailyQuota),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('daily_quota', instance.dailyQuota);
  writeNotNull('remaining_daily_quota', instance.remainingDailyQuota);
  val['subitems'] = instance.subitems.map((e) => e.toJson()).toList();
  return val;
}

CartMatrix _$CartMatrixFromJson(Map<String, dynamic> json) => CartMatrix(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => MatrixItemGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
      extraFields: (json['extra_fields'] as List<dynamic>?)
          ?.map((e) => MatrixExtraField.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartMatrixToJson(CartMatrix instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('items', instance.items?.map((e) => e.toJson()).toList());
  writeNotNull(
      'extra_fields', instance.extraFields?.map((e) => e.toJson()).toList());
  return val;
}

MatrixExtraField _$MatrixExtraFieldFromJson(Map<String, dynamic> json) =>
    MatrixExtraField(
      source: json['source'] as String,
      placeholder: json['placeholder'] as String,
      type: extraFieldFromJson(json['type'] as String),
      value: json['value'] as String?,
    );

Map<String, dynamic> _$MatrixExtraFieldToJson(MatrixExtraField instance) {
  final val = <String, dynamic>{
    'placeholder': instance.placeholder,
    'type': extraFieldToString(instance.type),
    'source': instance.source,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('value', instance.value);
  return val;
}

MatrixItem _$MatrixItemFromJson(Map<String, dynamic> json) => MatrixItem(
      quantities: (json['quantities'] as List<dynamic>)
          .map((e) => MatrixQuantity.fromJson(e as Map<String, dynamic>))
          .toList(),
      headers: (json['headers'] as List<dynamic>?)
              ?.map((e) => SubItemHeader.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$MatrixItemToJson(MatrixItem instance) =>
    <String, dynamic>{
      'quantities': instance.quantities.map((e) => e.toJson()).toList(),
      'headers': instance.headers?.map((e) => e.toJson()).toList(),
    };

SubItemHeader _$SubItemHeaderFromJson(Map<String, dynamic> json) =>
    SubItemHeader(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SubItemHeaderToJson(SubItemHeader instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

MatrixQuantity _$MatrixQuantityFromJson(Map<String, dynamic> json) =>
    MatrixQuantity(
      id: json['id'] as int,
      rate: toMatrixTitleValue(json['rate']),
      unit: toMatrixTitleValue(json['unit']),
      amount: acceptStringOrInt(json['amount']),
      hasStockTracking: json['has_stock_tracking'] == null
          ? false
          : nullableIntCastBool(json['has_stock_tracking']),
      stock: json['stock'] as int? ?? 0,
      remainingStock: json['remaining_stock'] as int? ?? 0,
      classificationCodeId: json['classification_code_id'] as int?,
      classificationCode: json['classification_code'] == null
          ? null
          : ClassificationCode.fromJson(
              json['classification_code'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MatrixQuantityToJson(MatrixQuantity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'classification_code_id': instance.classificationCodeId,
      'has_stock_tracking': instance.hasStockTracking,
      'stock': instance.stock,
      'remaining_stock': instance.remainingStock,
      'rate': MatrixTitleValue.toJsonFrom(instance.rate),
      'unit': MatrixTitleValue.toJsonFrom(instance.unit),
      'amount': instance.amount,
    };

MatrixTitleValue _$MatrixTitleValueFromJson(Map<String, dynamic> json) =>
    MatrixTitleValue(
      value: nullableIntToString(json['value']),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$MatrixTitleValueToJson(MatrixTitleValue instance) =>
    <String, dynamic>{
      'title': instance.title,
      'value': instance.value,
    };

ClassificationCode _$ClassificationCodeFromJson(Map<String, dynamic> json) =>
    ClassificationCode(
      description: json['description'] as String? ?? '',
      year: json['year'] as String? ?? '',
    );

Map<String, dynamic> _$ClassificationCodeToJson(ClassificationCode instance) =>
    <String, dynamic>{
      'description': instance.description,
      'year': instance.year,
    };
