import 'package:flutterbase/models/bills/bills.dart';
// import 'package:flutterbase/models/contents/agency.dart' as ag;
// import 'package:flutterbase/models/contents/menu.dart' as m;
import 'package:json_annotation/json_annotation.dart';

import '../bills/bills.dart' as a;
import 'matrix.dart';
part 'service.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ServiceModel {
  ServiceModel(
      {required this.id,
      this.agencyId,
      required this.name,
      this.menuId,
      required this.serviceReferenceNumber,
      this.billTypeId,
      required this.serviceGroupId,
      required this.systemSupportingDocumentPath,
      required this.systemApprovalLetterDate,
      required this.systemApprovalLetterRef,
      required this.systemDescription,
      required this.systemLogo,
      required this.systemName,
      required this.productLabelDisplay,
      this.matrix,
      this.extraFields,
      this.fileExtensions,
      required this.maxFileSize,
      required this.refNoLabel,
      this.allowCby,
      required this.cbyChargelines,
      this.receiptType,
      this.allowPartialPayment,
      this.isSensitive,
      this.isInvoiceIGfmas,
      this.allowThirdPartyPayment,
      this.thirdPartySearchTypes,
      required this.serviceMode,
      this.integrationData,
      this.serviceChargeData,
      this.taxData,
      this.discountData,
      this.chargelineData,
      this.chargedTo,
      this.status,
      this.creatorId,
      this.hasModified,
      this.serviceCategory,
      required this.submittedAt,
      required this.approvalAgencyAt,
      required this.approvalAgencyBy,
      required this.approvalAgencyRemarks,
      required this.approvalBaRemarks,
      required this.approvalBaAt,
      required this.approvalBaBy,
      required this.approvalJanmFungsianAt,
      required this.approvalJanmFungsianRemarks,
      required this.approvalJanmFungsianBy,
      required this.approvalJanmTeknikalAt,
      required this.approvalJanmTeknikalRemarks,
      required this.approvalJanmTeknikalBy,
      this.createdAt,
      this.updatedAt,
      this.billType,
      required this.fundVote,
      required this.project,
      required this.accountCode,
      required this.programActivity,
      this.menu,
      this.agency,
      this.ministry});

  int id;
  int? agencyId;
  String name;
  int? menuId;
  String serviceReferenceNumber;
  int? billTypeId;
  dynamic serviceGroupId;
  dynamic systemSupportingDocumentPath;
  dynamic systemApprovalLetterDate;
  dynamic systemApprovalLetterRef;
  dynamic systemDescription;
  dynamic systemLogo;
  dynamic systemName;
  dynamic productLabelDisplay;
  Matrix? matrix;
  List<dynamic>? extraFields;
  dynamic fileExtensions;
  dynamic maxFileSize;
  dynamic refNoLabel;
  int? allowCby;
  String cbyChargelines;
  String? receiptType;
  int? allowPartialPayment;
  String? serviceCategory;
  int? isSensitive;
  int? isInvoiceIGfmas;
  String? allowThirdPartyPayment;
  dynamic thirdPartySearchTypes;
  dynamic serviceMode;
  String? integrationData;
  String? serviceChargeData;
  String? taxData;
  String? discountData;
  String? chargelineData;
  String? chargedTo;
  String? status;
  int? creatorId;
  int? hasModified;
  dynamic submittedAt;
  dynamic approvalAgencyAt;
  dynamic approvalAgencyBy;
  dynamic approvalAgencyRemarks;
  dynamic approvalBaRemarks;
  dynamic approvalBaAt;
  dynamic approvalBaBy;
  dynamic approvalJanmFungsianAt;
  dynamic approvalJanmFungsianRemarks;
  dynamic approvalJanmFungsianBy;
  dynamic approvalJanmTeknikalAt;
  dynamic approvalJanmTeknikalRemarks;
  dynamic approvalJanmTeknikalBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  BillType? billType;
  dynamic fundVote;
  dynamic project;
  dynamic accountCode;
  dynamic programActivity;
  Menu? menu;
  Agency? agency;
  a.Ministry? ministry;

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class BillType {
  BillType({
    required this.id,
    required this.type,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String type;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory BillType.fromJson(Map<String, dynamic> json) =>
      _$BillTypeFromJson(json);

  Map<String, dynamic> toJson() => _$BillTypeToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DataMatrix {
  DataMatrix({
    required this.name,
    required this.basis,
    required this.matrix,
  });

  String name;
  int basis;
  List<List<dynamic>> matrix;

  factory DataMatrix.fromJson(Map<String, dynamic> json) =>
      _$DataMatrixFromJson(json);

  Map<String, dynamic> toJson() => _$DataMatrixToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MatrixMatrixClass {
  MatrixMatrixClass({
    required this.unit,
    required this.title,
    this.classification,
  });

  String unit;
  String title;
  String? classification;

  factory MatrixMatrixClass.fromJson(Map<String, dynamic> json) =>
      _$MatrixMatrixClassFromJson(json);

  Map<String, dynamic> toJson() => _$MatrixMatrixClassToJson(this);
}
