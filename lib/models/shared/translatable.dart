import 'package:json_annotation/json_annotation.dart';
part 'translatable.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class Translatables {
  Translatables({
    this.id,
    this.translatableId,
    this.translatableType,
    this.path,
    this.language,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? translatableId;
  String? translatableType;
  String? path;
  String? language;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Translatables.fromJson(Map<String, dynamic> json) => _$TranslatablesFromJson(json);

  Map<String, dynamic> toJson() => _$TranslatablesToJson(this);
}
