import 'package:json_annotation/json_annotation.dart';
part 'bill_type.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class BillType {
  BillType({
    this.id,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? type;
  String? createdAt;
  String? updatedAt;

  factory BillType.fromJson(Map<String, dynamic> json) =>
      _$BillTypeFromJson(json);

  Map<String, dynamic> toJson() => _$BillTypeToJson(this);
}
