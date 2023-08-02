import 'package:json_annotation/json_annotation.dart';
import 'package:flutterbase/models/contents/service.dart';
part 'favorite.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Favorite {
  Favorite({
    required this.id,
    required this.userId,
    this.serviceId,
    required this.billId,
    required this.createdAt,
    required this.updatedAt,
    this.service,
  });

  int id;
  int userId;
  int? serviceId;
  dynamic billId;
  DateTime createdAt;
  DateTime updatedAt;
  ServiceModel? service;

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteToJson(this);
}
