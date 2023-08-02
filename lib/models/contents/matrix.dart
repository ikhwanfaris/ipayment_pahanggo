import 'package:get/state_manager.dart';
import 'package:json_annotation/json_annotation.dart';
part 'matrix.g.dart';

@JsonSerializable(explicitToJson: true)
class Matrix {
  Matrix(
      {
      required this.filters,
      required this.products
      // this.dailyQuota,
      // this.hasDailyQuota,
      // this.remainingDailyQuota,
      // required this.subitems,
      });

  // List<Null>? filters;
  List<List<FilterItem>> filters;
  List<Products> products;

  // @JsonKey(name: "daily_quota")
  // int? dailyQuota;
  // @JsonKey(name: "has_daily_quota")
  // @HandleLaravelBool()
  // bool? hasDailyQuota;
  // @JsonKey(name: "remaining_daily_quota")
  // int? remainingDailyQuota;
  // List<Subitem> subitems;

  factory Matrix.fromJson(Map<String, dynamic> json) => _$MatrixFromJson(json);

  Map<String, dynamic> toJson() => _$MatrixToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FilterItem {
  int id;
  List<Chain> chains;
  String name;

  FilterItem(this.id, this.chains, this.name);

  factory FilterItem.fromJson(Map<String, dynamic> json) => _$FilterItemFromJson(json);

  Map<String, dynamic> toJson() => _$FilterItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Chain {
  int id;
  String name;

  Chain(this.id, this.name);

  factory Chain.fromJson(Map<String, dynamic> json) => _$ChainFromJson(json);

  Map<String, dynamic> toJson() => _$ChainToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Products {
  int id;
  List<Chains> chains;
  String name;
  String unit;
  int stock;
  String price;

  Products({
    required this.id,
    required this.chains,
    required this.name,
    required this.unit,
    this.checkStock,
    required this.stock,
    required this.price,
    this.classificationCodeId,
    this.quotaGroup,
    required this.checkQuota,
    this.dailyQuota,
  });

  @JsonKey(name: "check_stock")
  final bool? checkStock;

  @JsonKey(name: "classification_code_id")
  final int? classificationCodeId;

  @JsonKey(name: "quota_group")
  final int? quotaGroup;

  @JsonKey(name: "check_quota")
  final bool? checkQuota;

  @JsonKey(name: "daily_quota")
  final int? dailyQuota;

  @JsonKey(defaultValue: false, includeToJson: false)
  bool? select = false;

  @JsonKey(includeToJson: false, includeFromJson: false)
  @RxIntConverter()
  RxInt amount = RxInt(0);

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Chains {
  int? id;
  String? name;

  Chains({this.id, this.name});

  factory Chains.fromJson(Map<String, dynamic> json) => _$ChainsFromJson(json);

  Map<String, dynamic> toJson() => _$ChainsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Subitem {
  Subitem({
    required this.quantities,
    required this.headers,
  });

  List<Header> headers;
  List<Quantity> quantities;

  factory Subitem.fromJson(Map<String, dynamic> json) =>
      _$SubitemFromJson(json);

  Map<String, dynamic> toJson() => _$SubitemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Quantity {
  Quantity({
    required this.rate,
    required this.unit,
    this.id,
    this.hasStockTracking,
    this.stock,
    this.remainingStock,
    this.classificationCodeId,
    required this.amount,
    required this.favorite,
    // ignore: non_constant_identifier_names
    required this.bill_mask,
  });

  Rate rate;
  Unit unit;
  final int? id;
  bool? favorite;
  // ignore: non_constant_identifier_names
  String? bill_mask;
  @JsonKey(defaultValue: false, includeToJson: false)
  bool? select = false;
  @JsonKey(name: "has_stock_tracking")
  @HandleLaravelBoolStock()
  final bool? hasStockTracking;

  final int? stock;

  @JsonKey(name: "remaining_stock")
  final int? remainingStock;

  @JsonKey(name: "classification_code_id")
  final int? classificationCodeId;

  @RxIntConverter()
  RxInt amount;

  factory Quantity.fromJson(Map<String, dynamic> json) =>
      _$QuantityFromJson(json);

  Map<String, dynamic> toJson() => _$QuantityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Header {
  Header({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Header.fromJson(Map<String, dynamic> json) => _$HeaderFromJson(json);

  Map<String, dynamic> toJson() => _$HeaderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Rate {
  Rate({
    this.title,
    this.value,
  });

  String? title;
  @ToStringConverter()
  String? value;

  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);

  Map<String, dynamic> toJson() => _$RateToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Unit {
  Unit({
    this.title,
    this.value,
  });

  dynamic title;
  String? value;

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  Map<String, dynamic> toJson() => _$UnitToJson(this);
}

class ToStringConverter implements JsonConverter<String?, dynamic> {
  const ToStringConverter();

  @override
  String? fromJson(dynamic json) => (json == null) ? null : json.toString();

  @override
  dynamic toJson(String? object) => object;
}

class HandleLaravelBool implements JsonConverter<bool?, dynamic> {
  const HandleLaravelBool();

  @override
  bool? fromJson(dynamic json) {
    if (json.runtimeType == bool) {
      return json;
    } else if (json.runtimeType == int) {
      return (json == 1) ? true : false;
    } else {
      return null;
    }
  }

  @override
  int? toJson(bool? object) => (object ?? true) ? 1 : 0;
}

class HandleLaravelBoolStock implements JsonConverter<bool?, dynamic> {
  const HandleLaravelBoolStock();

  @override
  bool? fromJson(dynamic json) {
    if (json.runtimeType == bool) {
      return json;
    } else if (json.runtimeType == int) {
      return (json == 1) ? true : false;
    } else {
      return null;
    }
  }

  @override
  bool? toJson(bool? object) => object;
}

class RxIntConverter implements JsonConverter<RxInt, int> {
  const RxIntConverter();

  @override
  RxInt fromJson(int json) => RxInt(json);

  @override
  int toJson(RxInt object) => object.value;
}
