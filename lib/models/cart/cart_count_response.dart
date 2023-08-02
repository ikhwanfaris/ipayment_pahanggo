import 'package:json_annotation/json_annotation.dart';
part 'cart_count_response.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class CartCountResponse {
  CartCountResponse(this.count);
  final int count;

  factory CartCountResponse.fromJson(Map<String, dynamic> json) =>
      _$CartCountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartCountResponseToJson(this);
}
