import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'service.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class Service {
  int id;
  int? billTypeId;
  int? menuId;

  String chargedTo;
  String? approvalBaAt;
  String? discountData;
  String? name;
  String? receiptType;
  String? serviceChargeData;
  String? serviceReferenceNumber;
  String? status;
  String? submittedAt;
  String? taxData;
  String? referenceNoLabel;

  @JsonKey(fromJson: nullableJsonDecodeList)
  List<Map<String, dynamic>>? cbyChargelines;
  @JsonKey(fromJson: nullableJsonDecodeList)
  List<Map<String, dynamic>>? chargelineData;

  Agency? agency;
  Menu? menu;

  @JsonKey(fromJson: nullableIntCastBool)
  bool? favourite;
  bool? withMatrix;

  Service({
    required this.chargedTo,
    required this.id,
    this.agency,
    this.approvalBaAt,
    this.billTypeId,
    this.cbyChargelines,
    this.chargelineData,
    this.discountData,
    this.favourite,
    this.menu,
    this.menuId,
    this.name,
    this.receiptType,
    this.serviceChargeData,
    this.serviceReferenceNumber,
    this.status,
    this.submittedAt,
    this.taxData,
    this.withMatrix,
    this.referenceNoLabel,
  });

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
