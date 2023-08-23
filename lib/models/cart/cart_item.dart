import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/models/cart/cart_matrix.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_item.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class CartItem {
  CartItem({
    required this.amount,
    required this.status,
    this.id,
    this.userId,
    this.serviceId,
    this.billId,
    this.details,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  int? serviceId;
  int? billId;
  @JsonKey(fromJson: castListCartMatrix)
  List<CartMatrix>? details;
  @JsonKey(toJson: toNull)
  String? updatedAt;
  @JsonKey(toJson: toNull)
  String? createdAt;
  @JsonKey(fromJson: maybeDouble, toJson: doubleToString)
  double amount;
  String status;
  @JsonKey(toJson: toNull)
  Services? service;
  @JsonKey(toJson: toNull)
  Bill? bill;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
