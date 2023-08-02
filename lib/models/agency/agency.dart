import 'package:json_annotation/json_annotation.dart';
part 'agency.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class Agency {
  int id;
  String name;
  String? code;
  String? profile;
  String? address;

  Agency({
    required this.id,
    required this.name,
    this.code,
    this.profile,
    this.address,
  });

  factory Agency.fromJson(Map<String, dynamic> json) => _$AgencyFromJson(json);

  Map<String, dynamic> toJson() => _$AgencyToJson(this);
}
