import 'package:flutterbase/models/shared/translatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'menu.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Menu {
  int id;
  int? lft;
  int? rgt;
  int? depth;
  int? parentId;
  String? name;
  String? type;
  String? icon;
  String? iconClass;
  List<Translatables>? translatables;

  Menu({
    required this.id,
    this.lft,
    this.rgt,
    this.depth,
    this.parentId,
    required this.name,
    this.type,
    this.icon,
    this.iconClass,
    this.translatables,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
