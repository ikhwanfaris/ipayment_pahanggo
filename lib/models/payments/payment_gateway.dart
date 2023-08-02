import 'package:flutterbase/models/shared/translatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'payment_gateway.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PaymentGateway {
  PaymentGateway({
    required this.id,
    this.name,
    this.description,
    this.logo,
    this.owner,
    this.address,
    this.admin,
    this.position,
    this.officialEmail,
    this.officePhone,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.translatables,
  });

  int id;
  String? name;
  String? description;
  dynamic logo;
  String? owner;
  String? address;
  String? admin;
  String? position;
  String? officialEmail;
  dynamic officePhone;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Translatables>? translatables;

  factory PaymentGateway.fromJson(Map<String, dynamic> json) =>
      _$PaymentGatewayFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentGatewayToJson(this);
}
