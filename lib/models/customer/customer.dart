import 'package:flutterbase/models/bills/bills.dart';
import 'package:json_annotation/json_annotation.dart';
part 'customer.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class Customer {
  int id;
  int userIdentityTypeId;
  String firstName;
  String lastName;
  UserIdentityType? userIdentityType;

  Customer({
    required this.id,
    required this.userIdentityTypeId,
    required this.firstName,
    required this.lastName,
    this.userIdentityType,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
