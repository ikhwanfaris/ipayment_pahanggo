import 'package:json_annotation/json_annotation.dart';

import '../contents/matrix.dart';
part 'service_incomplete.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ServiceIncompletes {
  ServiceIncompletes({
    this.id,
    this.agencyId,
    this.ministryId,
    this.name,
    this.menuId,
    this.serviceReferenceNumber,
    this.billTypeId,
    this.serviceGroupId,
    this.agencySystemId,
    this.systemSupportingDocumentPath,
    this.systemApprovalLetterDate,
    this.systemApprovalLetterRef,
    this.systemDescription,
    this.systemLogo,
    this.systemName,
    this.productLabelDisplay,
    required this.matrix,
    this.extraFields,
    this.fileExtensions,
    this.maxFileSize,
    this.refNoLabel,
    this.allowCby,
    this.cbyChargelines,
    this.receiptType,
    this.allowPartialPayment,
    this.isSensitive,
    this.isSendIgfmas,
    this.isInvoiceIGfmas,
    this.allowThirdPartyPayment,
    this.thirdPartySearchTypes,
    this.serviceMode,
    this.integrationData,
    this.serviceChargeData,
    this.taxData,
    this.discountData,
    this.chargelineData,
    this.collectionChannels,
    this.preparerLocations,
    this.usageMode,
    this.collectionType,
    this.chargedTo,
    this.status,
    this.creatorId,
    this.hasModified,
    this.submittedAt,
    this.approvalAgencyAt,
    this.approvalAgencyBy,
    this.approvalAgencyRemarks,
    this.approvalBaRemarks,
    this.approvalBaAt,
    this.approvalBaBy,
    this.janmChecker,
    this.approvalJanmFungsianAt,
    this.approvalJanmFungsianRemarks,
    this.approvalJanmFungsianBy,
    this.approvalJanmTeknikalAt,
    this.approvalJanmTeknikalRemarks,
    this.approvalJanmTeknikalBy,
    this.operationManagement,
    this.skipPaymentApproval,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.serviceCategory,
    this.products,
    this.agency,
    this.menu,
  });

  int? id;
  int? agencyId;
  int? ministryId;
  String? name;
  int? menuId;
  String? serviceReferenceNumber;
  int? billTypeId;
  int? serviceGroupId;
  dynamic agencySystemId;
  dynamic systemSupportingDocumentPath;
  dynamic systemApprovalLetterDate;
  dynamic systemApprovalLetterRef;
  dynamic systemDescription;
  dynamic systemLogo;
  dynamic systemName;
  dynamic productLabelDisplay;
  Matrix matrix;
  List<dynamic>? extraFields;
  dynamic fileExtensions;
  dynamic maxFileSize;
  String? refNoLabel;
  int? allowCby;
  String? cbyChargelines;
  String? receiptType;
  int? allowPartialPayment;
  int? isSensitive;
  int? isSendIgfmas;
  int? isInvoiceIGfmas;
  String? allowThirdPartyPayment;
  dynamic thirdPartySearchTypes;
  dynamic serviceMode;
  String? integrationData;
  String? serviceChargeData;
  String? taxData;
  String? discountData;
  String? chargelineData;
  dynamic collectionChannels;
  List<dynamic>? preparerLocations;
  String? usageMode;
  String? collectionType;
  String? chargedTo;
  String? status;
  int? creatorId;
  int? hasModified;
  DateTime? submittedAt;
  String? approvalAgencyAt;
  int? approvalAgencyBy;
  dynamic approvalAgencyRemarks;
  dynamic approvalBaRemarks;
  String? approvalBaAt;
  int? approvalBaBy;
  int? janmChecker;
  String? approvalJanmFungsianAt;
  dynamic approvalJanmFungsianRemarks;
  int? approvalJanmFungsianBy;
  String? approvalJanmTeknikalAt;
  dynamic approvalJanmTeknikalRemarks;
  int? approvalJanmTeknikalBy;
  dynamic operationManagement;
  int? skipPaymentApproval;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? serviceCategory;
  String? products;
  Agency? agency;
  Menu? menu;

  factory ServiceIncompletes.fromJson(Map<String, dynamic> json) =>
      _$ServiceIncompletesFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceIncompletesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Agency {
  Agency({
    this.id,
    this.ministryId,
    this.departmentId,
    this.depth,
    this.rgt,
    this.lft,
    this.parentId,
    this.name,
    this.shortName,
    this.code,
    this.logoPath,
    this.profile,
    this.address,
    this.isActive,
    this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? ministryId;
  int? departmentId;
  int? depth;
  int? rgt;
  int? lft;
  int? parentId;
  String? name;
  String? shortName;
  String? code;
  dynamic logoPath;
  String? profile;
  String? address;
  int? isActive;
  DateTime? endDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Agency.fromJson(Map<String, dynamic> json) => _$AgencyFromJson(json);

  Map<String, dynamic> toJson() => _$AgencyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ServiceIncompletesMatrix {
  ServiceIncompletesMatrix({
    this.name,
    this.dailyQuota,
    this.basis,
    this.matrix,
  });

  String? name;
  int? dailyQuota;
  int? basis;
  List<List<dynamic>>? matrix;

  factory ServiceIncompletesMatrix.fromJson(Map<String, dynamic> json) =>
      _$ServiceIncompletesMatrixFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceIncompletesMatrixToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MatrixMatrixClass {
  MatrixMatrixClass({
    this.title,
    this.unit,
    this.classification,
    this.stock,
  });

  String? title;
  String? unit;
  String? classification;
  int? stock;

  factory MatrixMatrixClass.fromJson(Map<String, dynamic> json) =>
      _$MatrixMatrixClassFromJson(json);

  Map<String, dynamic> toJson() => _$MatrixMatrixClassToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Menu {
  Menu({
    this.id,
    this.parentId,
    this.lft,
    this.rgt,
    this.depth,
    this.name,
    this.icon,
    this.createdAt,
    this.updatedAt,
    this.parent,
  });

  int? id;
  dynamic parentId;
  int? lft;
  int? rgt;
  int? depth;
  String? name;
  dynamic icon;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic parent;

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ServiceItem {
  ServiceItem({
    this.id,
    this.price,
    this.quantity,
    this.totalPrice,
    this.title,
    this.unit,
  });

  int? id;
  dynamic price;
  int? quantity;
  num? totalPrice;
  String? title;
  String? unit;

  factory ServiceItem.fromJson(Map<String, dynamic> json) =>
      _$ServiceItemFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceItemToJson(this);
}
