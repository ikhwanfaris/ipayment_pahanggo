import 'package:flutterbase/enums/enums.dart';
import 'package:flutterbase/helpers.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_matrix.g.dart';

const kEmptyMatrixItems = <MatrixItem>[];

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
  fieldRename: FieldRename.snake,
)
class MatrixItemGroup {
  MatrixItemGroup({
    this.hasDailyQuota,
    this.dailyQuota,
    this.remainingDailyQuota,
    this.subitems = kEmptyMatrixItems,
  });

  @JsonKey(
      defaultValue: false,
      fromJson: nullableIntCastBool,
      toJson: nullableIntCastBool)
  bool? hasDailyQuota;

  @JsonKey(defaultValue: 0)
  int? dailyQuota;

  @JsonKey(defaultValue: 0)
  int? remainingDailyQuota;

  @JsonKey(defaultValue: kEmptyMatrixItems)
  List<MatrixItem> subitems;

  factory MatrixItemGroup.fromJson(Map<String, dynamic> json) =>
      _$MatrixItemGroupFromJson(json);

  Map<String, dynamic> toJson() => _$MatrixItemGroupToJson(this);
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
  fieldRename: FieldRename.snake,
)
class CartMatrix {
  CartMatrix({
    this.items,
    // ignore: non_constant_identifier_names
    this.extraFields,
  });

  List<MatrixItemGroup>? items;
  // ignore: non_constant_identifier_names
  List<MatrixExtraField>? extraFields;

  bool get isItems => items != null;
  bool get isExtraFields => extraFields != null;

  factory CartMatrix.fromJson(Map<String, dynamic> json) =>
      _$CartMatrixFromJson(json);

  Map<String, dynamic> toJson() => _$CartMatrixToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MatrixExtraField {
  MatrixExtraField({
    required this.source,
    required this.placeholder,
    required this.type,
    this.value,
  });

  String placeholder;
  @JsonKey(fromJson: extraFieldFromJson, toJson: extraFieldToString)
  ExtraFieldType type;
  String source;
  String? value;

  factory MatrixExtraField.fromJson(Map<String, dynamic> json) =>
      _$MatrixExtraFieldFromJson(json);

  Map<String, dynamic> toJson() => _$MatrixExtraFieldToJson(this);
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: true,
)
class MatrixItem {
  MatrixItem({
    required this.quantities,
    this.headers,
  });

  List<MatrixQuantity> quantities;

  @JsonKey(defaultValue: [])
  List<SubItemHeader>? headers;

  factory MatrixItem.fromJson(Map<String, dynamic> json) =>
      _$MatrixItemFromJson(json);

  Map<String, dynamic> toJson() => _$MatrixItemToJson(this);
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: true,
  fieldRename: FieldRename.snake,
)
class SubItemHeader {
  SubItemHeader({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory SubItemHeader.fromJson(Map<String, dynamic> json) =>
      _$SubItemHeaderFromJson(json);
  Map<String, dynamic> toJson() => _$SubItemHeaderToJson(this);
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: true,
  fieldRename: FieldRename.snake,
)
class MatrixQuantity {
  MatrixQuantity({
    required this.id,
    required this.rate,
    required this.unit,
    required this.amount,
    this.hasStockTracking,
    this.stock,
    this.remainingStock,
    this.classificationCodeId,
    this.classificationCode,
  });

  int id;

  @JsonKey(defaultValue: null)
  int? classificationCodeId;

  @JsonKey(defaultValue: null, includeToJson: false)
  ClassificationCode? classificationCode;

  @JsonKey(defaultValue: false, fromJson: nullableIntCastBool)
  bool? hasStockTracking;

  @JsonKey(defaultValue: 0)
  int? stock;

  @JsonKey(defaultValue: 0)
  int? remainingStock;

  @JsonKey(fromJson: toMatrixTitleValue, toJson: MatrixTitleValue.toJsonFrom)
  MatrixTitleValue rate;

  @JsonKey(fromJson: toMatrixTitleValue, toJson: MatrixTitleValue.toJsonFrom)
  MatrixTitleValue unit;

  @JsonKey(fromJson: acceptStringOrInt)
  int amount;

  double getSubTotal() {
    return double.parse(rate.value ?? '0') * amount;
  }

  factory MatrixQuantity.fromJson(Map<String, dynamic> json) =>
      _$MatrixQuantityFromJson(json);

  Map<String, dynamic> toJson() => _$MatrixQuantityToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: true)
class MatrixTitleValue {
  MatrixTitleValue({
    this.value,
    this.title,
  });

  @JsonKey(includeIfNull: true)
  String? title;

  @JsonKey(fromJson: nullableIntToString, includeIfNull: true)
  String? value;

  // ignore: deprecated_colon_for_default_value
  String getValue(String any, {String prefix: ''}) {
    String amount = "$value";

    try {
      double _amount = double.parse(value ?? '0.0');

      amount = moneyFormat(_amount);
    } catch (_) {}

    return value != null ? "$prefix $amount" : any;
  }

  // ignore: deprecated_colon_for_default_value
  String getTitle(String any, {String prefix: ''}) {
    List<String> seg = [];

    if (prefix.isNotEmpty) {
      seg.add(prefix);
    }

    if (title != null) {
      seg.add(title!);
    } else {
      seg.add(any);
    }

    return seg.join(' ');
  }

  static Map<String, dynamic> toJsonFrom(MatrixTitleValue titleValue) =>
      _$MatrixTitleValueToJson(titleValue);

  factory MatrixTitleValue.fromJson(Map<String, dynamic> json) =>
      _$MatrixTitleValueFromJson(json);

  Map<String, dynamic> toJson() => _$MatrixTitleValueToJson(this);
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: true,
  fieldRename: FieldRename.snake,
)
class ClassificationCode {
  ClassificationCode({
    this.description,
    this.year,
  });

  @JsonKey(defaultValue: '')
  String? description;

  @JsonKey(defaultValue: '')
  String? year;

  factory ClassificationCode.fromJson(Map<String, dynamic> json) =>
      _$ClassificationCodeFromJson(json);

  Map<String, dynamic> toJson() => _$ClassificationCodeToJson(this);

  String getDescription() {
    return [description, year].where((e) => e != null).join(' ');
  }
}
