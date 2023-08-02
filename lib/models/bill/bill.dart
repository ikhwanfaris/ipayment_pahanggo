import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bill.g.dart';

@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class Bill {
  int id;
  int? stagingPaymentId;
  int? serviceId;
  int? billTypeId;
  int? ministryId;
  int? makerControllingOfficerId;
  int? makerPtjGroupId;
  int? makerPtjId;
  int? makerAccountingOfficeId;
  int? chargedControllingOfficerId;
  int? chargedPtjGroupId;
  int? chargedPtjId;
  int? departmentId;
  int? agencyId;
  int? productId;
  int? subproductId;
  int? processCode;
  String? referenceNumber;
  String? detail;
  String? entityCode;
  String? identityCode;
  String? name1;
  String? name2;
  String? address1;
  String? address2;
  String? address3;
  String? postcode;
  String? city;
  String? district;
  String? state;
  String? country;
  String? telephone;
  String? fax;
  String? email;
  String? description;
  String? actualAmount;
  String? paidAmount;
  String? changedAmout;
  String? amountWithoutTax;
  String? discountType;
  String? discountAmount;
  String? amountWithDiscount;
  String? taxAmount;
  String? amountWithTax;
  String? roundingAdjustment;
  NettCalculation? nettCalculations;
  String? collectionLocation;
  String? centralisedLocation;
  String? centralisedSublocation;
  String? startAt;
  String? endAt;
  String? billMask;
  String? billNumber;
  int? creatorId;
  List<dynamic>? validationErrors;
  String? remarks;
  int? payerId;
  int? customerId;
  int? customerCharge;
  String? cancellationCategory;
  String? cancellationReason;
  String? queryRemarks;
  String? status;
  String? source;
  String? createdAt;
  String? updatedAt;
  @JsonKey(fromJson: nullableJsonDecode)
  Map<String, dynamic>? calculations;
  BillType? billType;
  Service? service;
  Agency? agency;
  Customer? customer;
  int? favorite;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool checked;

  Bill({
    required this.id,
    required this.paidAmount,
    required this.changedAmout,
    required this.amountWithoutTax,
    required this.discountType,
    required this.discountAmount,
    required this.amountWithDiscount,
    required this.taxAmount,
    required this.amountWithTax,
    required this.roundingAdjustment,
    required this.startAt,
    required this.endAt,
    this.stagingPaymentId,
    this.serviceId,
    this.billTypeId,
    this.ministryId,
    this.makerControllingOfficerId,
    this.makerPtjGroupId,
    this.makerPtjId,
    this.makerAccountingOfficeId,
    this.chargedControllingOfficerId,
    this.chargedPtjGroupId,
    this.chargedPtjId,
    this.departmentId,
    this.agencyId,
    this.productId,
    this.subproductId,
    this.billType,
    this.processCode,
    this.referenceNumber,
    this.detail,
    this.entityCode,
    this.identityCode,
    this.name1,
    this.name2,
    this.address1,
    this.address2,
    this.address3,
    this.postcode,
    this.city,
    this.district,
    this.state,
    this.country,
    this.telephone,
    this.fax,
    this.email,
    this.description,
    this.collectionLocation,
    this.centralisedLocation,
    this.centralisedSublocation,
    this.billMask,
    this.billNumber,
    this.calculations,
    this.creatorId,
    this.validationErrors,
    this.remarks,
    this.payerId,
    this.customerId,
    required this.customerCharge,
    this.cancellationCategory,
    this.cancellationReason,
    this.queryRemarks,
    required this.status,
    this.source,
    this.createdAt,
    this.updatedAt,
    this.service,
    this.agency,
    this.customer,
    this.favorite,
    this.checked = false,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);

  Map<String, dynamic> toJson() => _$BillToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class NettCalculation {
  NettCalculation({
    this.rounding = 0,
    this.original = 0,
    this.changes = 0,
    this.changesDraft = 0,
    this.total = 0,
    this.paid = 0,
    this.paidDraft = 0,
    this.due = 0,
    this.dueInWords = '',
  });

  final double rounding;
  final double original;
  final double changes;
  final double changesDraft;
  final double total;
  final double paid;
  final double paidDraft;
  final double due;
  final String dueInWords;

  factory NettCalculation.fromJson(Map<String, dynamic> json) =>
      _$NettCalculationFromJson(json);

  Map<String, dynamic> toJson() => _$NettCalculationToJson(this);
}
