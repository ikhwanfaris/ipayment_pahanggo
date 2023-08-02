import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/contents/agency.dart';
import 'package:flutterbase/models/service/service.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bill.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Bill {
  Bill({
    this.id,
    this.billTypeId,
    this.serviceId,
    this.ministryId,
    this.departmentId,
    this.agencyId,
    this.creatorId,
    this.makerPtjId,
    this.locationId,
    this.sublocationId,
    this.userIdentityTypeId,
    this.countryId,
    this.stateId,
    this.cityId,
    this.districtId,
    this.identityCodeCategory,
    this.identityCode,
    this.previousIdentityCode,
    this.customerName,
    this.customerReferenceNumber,
    this.address,
    this.postcode,
    this.stateName,
    this.cityName,
    this.districtName,
    this.telephone,
    this.email,
    this.detail,
    this.referenceNumber,
    this.billDate,
    this.startAt,
    this.endAt,
    this.customerNote,
    this.source,
    this.stagingBatchId,
    this.stagingBatchContentId,
    this.processCode,
    this.dataStatus,
    this.status,
    this.firstApproverId,
    this.secondApproverId,
    this.firstApprovalAt,
    this.secondApprovalAt,
    this.taskAt,
    this.queryRemarks,
    this.billNumber,
    this.billMask,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.nettCalculations,
    this.service,
    this.agency,
    this.customer,
    this.billType,
    this.favorite,
  });

  int? id;
  int? billTypeId;
  int? serviceId;
  int? ministryId;
  int? departmentId;
  int? agencyId;
  int? creatorId;
  int? makerPtjId;
  int? locationId;
  int? sublocationId;
  int? userIdentityTypeId;
  int? countryId;
  int? stateId;
  int? cityId;
  int? districtId;
  String? identityCodeCategory;
  String? identityCode;
  dynamic previousIdentityCode;
  String? customerName;
  String? customerReferenceNumber;
  String? address;
  String? postcode;
  String? stateName;
  String? cityName;
  String? districtName;
  String? telephone;
  String? email;
  String? detail;
  String? referenceNumber;
  DateTime? billDate;
  DateTime? startAt;
  DateTime? endAt;
  String? source;
  dynamic stagingBatchId;
  dynamic stagingBatchContentId;
  int? processCode;
  String? dataStatus;
  String? status;
  dynamic firstApproverId;
  dynamic secondApproverId;
  dynamic firstApprovalAt;
  dynamic secondApprovalAt;
  dynamic taskAt;
  dynamic queryRemarks;
  String? billNumber;
  String? billMask;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  NettCalculations? nettCalculations;
  Service? service;
  Agency? agency;
  dynamic customer;
  BillType? billType;
  bool? favorite;
  String? customerNote;
  // ignore: deprecated_member_use
  @JsonKey(defaultValue: false, ignore: true)
  RxBool? isFavorite;
  // ignore: deprecated_member_use
  @JsonKey(defaultValue: false, ignore: true)
  RxBool? isSelected;
  // ignore: deprecated_member_use
  @JsonKey(defaultValue: false, ignore: true)
  TextEditingController? amountController;

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);

  Map<String, dynamic> toJson() => _$BillToJson(this);

  static Future<Bill> fetch(int id) async {
    var response = await api.getBill(id);
    return Bill.fromJson(response.data);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class BillType {
  BillType({
    required this.id,
    required this.type,
  });

  int id;
  String type;

  factory BillType.fromJson(Map<String, dynamic> json) =>
      _$BillTypeFromJson(json);

  Map<String, dynamic> toJson() => _$BillTypeToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class NettCalculations {
  NettCalculations({
    this.roundingData,
    this.changesItems,
    this.changesDraftItems,
    this.paymentItems,
    this.paymentDraftItems,
    this.rounding,
    this.original,
    this.changes,
    this.changesDraft,
    this.total,
    this.paid,
    this.paidDraft,
    this.due,
    this.dueInWords,
  });

  dynamic roundingData;
  List<dynamic>? changesItems;
  List<dynamic>? changesDraftItems;
  List<dynamic>? paymentItems;
  List<dynamic>? paymentDraftItems;
  double? rounding;
  double? original;
  double? changes;
  double? changesDraft;
  double? total;
  double? paid;
  double? paidDraft;
  double? due;
  String? dueInWords;

  factory NettCalculations.fromJson(Map<String, dynamic> json) =>
      _$NettCalculationsFromJson(json);

  Map<String, dynamic> toJson() => _$NettCalculationsToJson(this);
}
