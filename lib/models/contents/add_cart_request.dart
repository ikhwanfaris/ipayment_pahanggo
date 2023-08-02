import 'package:json_annotation/json_annotation.dart';
part 'add_cart_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AddCartRequest {
  @JsonKey(includeIfNull: false)
  String? serviceId;
  @JsonKey(includeIfNull: false)
  String? billId;
  @JsonKey(includeIfNull: false)
  double? amount;
  @JsonKey(includeIfNull: false)
  String? details;
  @JsonKey(includeIfNull: false)
  String? items;

  AddCartRequest({
    this.serviceId,
    this.billId,
    this.amount,
    this.details,
    this.items,
  });

  factory AddCartRequest.fromJson(Map<String, dynamic> json) => _$AddCartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddCartRequestToJson(this);
}
