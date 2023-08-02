import 'package:json_annotation/json_annotation.dart';
part 'user_identity_type.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class UserIdentityType {
  UserIdentityType({
    this.id,
    this.category,
  });

  int? id;
  String? category;

  factory UserIdentityType.fromJson(Map<String, dynamic> json) => _$UserIdentityTypeFromJson(json);

  Map<String, dynamic> toJson() => _$UserIdentityTypeToJson(this);
}
