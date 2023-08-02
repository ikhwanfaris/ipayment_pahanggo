import 'package:flutter/cupertino.dart';
import 'package:flutterbase/models/incomplete/service_incomplete.dart';
import 'package:get/get.dart';

class Bills {
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
  // ignore: unnecessary_question_mark
  String? previousIdentityCode;
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
  String? recordSeqNumber;
  String? documentSeqNumber;
  String? documentNoSap;
  String? documentNoOriginal;
  String? documentYear;
  String? billDate;
  String? postingDate;
  String? startAt;
  String? endAt;
  String? customerNote;
  String? source;
  int? stagingBatchId;
  int? stagingBatchContentId;
  int? processCode;
  String? dataStatus;
  String? status;
  int? firstApproverId;
  int? secondApproverId;
  String? firstApprovalAt;
  String? secondApprovalAt;
  String? taskAt;
  String? queryRemarks;
  String? billNumber;
  String? billMask;
  String? makerName;
  String? makerPosition;
  String? documentDatePrepared;
  String? approverName;
  String? approverPosition;
  String? approvalDate;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  NettCalculations? nettCalculations;
  bool? favorite;
  bool? inCart;
  List<Chargelines>? chargelines;
  List<Paymentsss>? payments;
  List<AmountChanges>? amountChanges;
  Service? service;
  Agency? agency;
  Null customer;
  BillType? billType;
  int? favorite1;
  bool? checked = false;
  String? amount1;
  String? amount = "";
  RxBool select = RxBool(false);
  final TextEditingController amount2 = TextEditingController(text: "0.00");
  RxString rounding = RxString("");
  Bills(
      {this.id,
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
      this.recordSeqNumber,
      this.documentSeqNumber,
      this.documentNoSap,
      this.documentNoOriginal,
      this.documentYear,
      this.billDate,
      this.postingDate,
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
      this.makerName,
      this.makerPosition,
      this.documentDatePrepared,
      this.approverName,
      this.approverPosition,
      this.approvalDate,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.nettCalculations,
      this.favorite,
      this.inCart,
      this.service,
      this.agency,
      this.customer,
      this.billType,
      this.amount1,
      this.favorite1,
      this.checked,
      this.amount});

  Bills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billTypeId = json['bill_type_id'];
    serviceId = json['service_id'];
    ministryId = json['ministry_id'];
    departmentId = json['department_id'];
    agencyId = json['agency_id'];
    creatorId = json['creator_id'];
    makerPtjId = json['maker_ptj_id'];
    locationId = json['location_id'];
    sublocationId = json['sublocation_id'];
    userIdentityTypeId = json['user_identity_type_id'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    districtId = json['district_id'];
    identityCodeCategory = json['identity_code_category'];
    identityCode = json['identity_code'];
    previousIdentityCode = json['previous_identity_code'];
    customerName = json['customer_name'];
    customerReferenceNumber = json['customer_reference_number'];
    address = json['address'];
    postcode = json['postcode'];
    stateName = json['state_name'];
    cityName = json['city_name'];
    districtName = json['district_name'];
    telephone = json['telephone'];
    email = json['email'];
    detail = json['detail'];
    referenceNumber = json['reference_number'];
    recordSeqNumber = json['record_seq_number'];
    documentSeqNumber = json['document_seq_number'];
    documentNoSap = json['document_no_sap'];
    documentNoOriginal = json['document_no_original'];
    documentYear = json['document_year'];
    billDate = json['bill_date'];
    postingDate = json['posting_date'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    customerNote = json['customer_note'];
    source = json['source'];
    stagingBatchId = json['staging_batch_id'];
    stagingBatchContentId = json['staging_batch_content_id'];
    processCode = json['process_code'];
    dataStatus = json['data_status'];
    status = json['status'];
    firstApproverId = json['first_approver_id'];
    secondApproverId = json['second_approver_id'];
    firstApprovalAt = json['first_approval_at'];
    secondApprovalAt = json['second_approval_at'];
    taskAt = json['task_at'];
    queryRemarks = json['query_remarks'];
    billNumber = json['bill_number'];
    billMask = json['bill_mask'];
    makerName = json['maker_name'];
    makerPosition = json['maker_position'];
    documentDatePrepared = json['document_date_prepared'];
    approverName = json['approver_name'];
    approverPosition = json['approver_position'];
    approvalDate = json['approval_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    amount1 = json['amount'];
    nettCalculations = json['nett_calculations'] != null
        ? new NettCalculations.fromJson(json['nett_calculations'])
        : null;
    favorite = json['favorite'];
    inCart = json['in_cart'];
    if (json['chargelines'] != null) {
      chargelines = <Chargelines>[];
      json['chargelines'].forEach((v) {
        chargelines!.add(new Chargelines.fromJson(v));
      });
    }
    if (json['payments'] != null) {
      payments = <Paymentsss>[];
      json['payments'].forEach((v) {
        payments!.add(new Paymentsss.fromJson(v));
      });
    }
    if (json['amount_changes'] != null) {
      amountChanges = <AmountChanges>[];
      json['amount_changes'].forEach((v) {
        amountChanges!.add(new AmountChanges.fromJson(v));
      });
    }
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    agency =
        json['agency'] != null ? new Agency.fromJson(json['agency']) : null;
    customer = json['customer'];
    billType = json['bill_type'] != null
        ? new BillType.fromJson(json['bill_type'])
        : null;
    favorite1 = (json['favorite']) == true ? 1 : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bill_type_id'] = this.billTypeId;
    data['service_id'] = this.serviceId;
    data['ministry_id'] = this.ministryId;
    data['department_id'] = this.departmentId;
    data['agency_id'] = this.agencyId;
    data['creator_id'] = this.creatorId;
    data['maker_ptj_id'] = this.makerPtjId;
    data['location_id'] = this.locationId;
    data['sublocation_id'] = this.sublocationId;
    data['user_identity_type_id'] = this.userIdentityTypeId;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['district_id'] = this.districtId;
    data['identity_code_category'] = this.identityCodeCategory;
    data['identity_code'] = this.identityCode;
    data['previous_identity_code'] = this.previousIdentityCode;
    data['customer_name'] = this.customerName;
    data['customer_reference_number'] = this.customerReferenceNumber;
    data['address'] = this.address;
    data['postcode'] = this.postcode;
    data['state_name'] = this.stateName;
    data['city_name'] = this.cityName;
    data['district_name'] = this.districtName;
    data['telephone'] = this.telephone;
    data['email'] = this.email;
    data['detail'] = this.detail;
    data['reference_number'] = this.referenceNumber;
    data['record_seq_number'] = this.recordSeqNumber;
    data['document_seq_number'] = this.documentSeqNumber;
    data['document_no_sap'] = this.documentNoSap;
    data['document_no_original'] = this.documentNoOriginal;
    data['document_year'] = this.documentYear;
    data['bill_date'] = this.billDate;
    data['posting_date'] = this.postingDate;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['customer_note'] = this.customerNote;
    data['source'] = this.source;
    data['staging_batch_id'] = this.stagingBatchId;
    data['staging_batch_content_id'] = this.stagingBatchContentId;
    data['process_code'] = this.processCode;
    data['data_status'] = this.dataStatus;
    data['status'] = this.status;
    data['first_approver_id'] = this.firstApproverId;
    data['second_approver_id'] = this.secondApproverId;
    data['first_approval_at'] = this.firstApprovalAt;
    data['second_approval_at'] = this.secondApprovalAt;
    data['task_at'] = this.taskAt;
    data['query_remarks'] = this.queryRemarks;
    data['bill_number'] = this.billNumber;
    data['bill_mask'] = this.billMask;
    data['maker_name'] = this.makerName;
    data['maker_position'] = this.makerPosition;
    data['document_date_prepared'] = this.documentDatePrepared;
    data['approver_name'] = this.approverName;
    data['approver_position'] = this.approverPosition;
    data['approval_date'] = this.approvalDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['amount'] = this.amount1;
    if (this.nettCalculations != null) {
      data['nett_calculations'] = this.nettCalculations!.toJson();
    }
    data['favorite'] = this.favorite;
    data['in_cart'] = this.inCart;
    if (this.chargelines != null) {
      data['chargelines'] = this.chargelines!.map((v) => v.toJson()).toList();
    }
    if (this.payments != null) {
      data['payments'] = this.payments!.map((v) => v.toJson()).toList();
    }
    if (this.amountChanges != null) {
      data['amount_changes'] =
          this.amountChanges!.map((v) => v.toJson()).toList();
    }

    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.agency != null) {
      data['agency'] = this.agency!.toJson();
    }
    data['customer'] = this.customer;
    if (this.billType != null) {
      data['bill_type'] = this.billType!.toJson();
    }
    data['favorite'] = this.favorite;
    return data;
  }
}

class Paymentsss {
  int? id;
  int? paymentId;
  int? userId;
  String? referenceNumber;
  String? agencyReferenceNumber;
  String? receiptNumber;
  Null receiptNumberSap;
  String? receiptYear;
  String? receiptDocumentDate;
  Null receiptNote;
  Null receiptAmountIgfmas;
  String? paymentDate;
  String? source;
  String? status;
  String? cashierName;
  int? firstApproverId;
  Null secondApproverId;
  String? firstApprovalAt;
  Null secondApprovalAt;
  String? taskAt;
  String? amount;
  String? createdAt;
  String? updatedAt;

  Paymentsss(
      {this.id,
      this.paymentId,
      this.userId,
      this.referenceNumber,
      this.agencyReferenceNumber,
      this.receiptNumber,
      this.receiptNumberSap,
      this.receiptYear,
      this.receiptDocumentDate,
      this.receiptNote,
      this.receiptAmountIgfmas,
      this.paymentDate,
      this.source,
      this.status,
      this.cashierName,
      this.firstApproverId,
      this.secondApproverId,
      this.firstApprovalAt,
      this.secondApprovalAt,
      this.taskAt,
      this.amount,
      this.createdAt,
      this.updatedAt});

  Paymentsss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentId = json['payment_id'];
    userId = json['user_id'];
    referenceNumber = json['reference_number'];
    agencyReferenceNumber = json['agency_reference_number'];
    receiptNumber = json['receipt_number'];
    receiptNumberSap = json['receipt_number_sap'];
    receiptYear = json['receipt_year'];
    receiptDocumentDate = json['receipt_document_date'];
    receiptNote = json['receipt_note'];
    receiptAmountIgfmas = json['receipt_amount_igfmas'];
    paymentDate = json['payment_date'];
    source = json['source'];
    status = json['status'];
    cashierName = json['cashier_name'];
    firstApproverId = json['first_approver_id'];
    secondApproverId = json['second_approver_id'];
    firstApprovalAt = json['first_approval_at'];
    secondApprovalAt = json['second_approval_at'];
    taskAt = json['task_at'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_id'] = this.paymentId;
    data['user_id'] = this.userId;
    data['reference_number'] = this.referenceNumber;
    data['agency_reference_number'] = this.agencyReferenceNumber;
    data['receipt_number'] = this.receiptNumber;
    data['receipt_number_sap'] = this.receiptNumberSap;
    data['receipt_year'] = this.receiptYear;
    data['receipt_document_date'] = this.receiptDocumentDate;
    data['receipt_note'] = this.receiptNote;
    data['receipt_amount_igfmas'] = this.receiptAmountIgfmas;
    data['payment_date'] = this.paymentDate;
    data['source'] = this.source;
    data['status'] = this.status;
    data['cashier_name'] = this.cashierName;
    data['first_approver_id'] = this.firstApproverId;
    data['second_approver_id'] = this.secondApproverId;
    data['first_approval_at'] = this.firstApprovalAt;
    data['second_approval_at'] = this.secondApprovalAt;
    data['task_at'] = this.taskAt;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PaymentItems {
  int? id;
  int? paymentId;
  int? userId;
  String? referenceNumber;
  String? agencyReferenceNumber;
  String? receiptNumber;
  Null receiptNumberSap;
  String? receiptYear;
  String? receiptDocumentDate;
  Null receiptNote;
  Null receiptAmountIgfmas;
  String? paymentDate;
  String? source;
  String? status;
  String? cashierName;
  Null firstApproverId;
  Null secondApproverId;
  Null firstApprovalAt;
  Null secondApprovalAt;
  Null taskAt;
  String? amount;
  String? createdAt;
  String? updatedAt;

  PaymentItems(
      {this.id,
      this.paymentId,
      this.userId,
      this.referenceNumber,
      this.agencyReferenceNumber,
      this.receiptNumber,
      this.receiptNumberSap,
      this.receiptYear,
      this.receiptDocumentDate,
      this.receiptNote,
      this.receiptAmountIgfmas,
      this.paymentDate,
      this.source,
      this.status,
      this.cashierName,
      this.firstApproverId,
      this.secondApproverId,
      this.firstApprovalAt,
      this.secondApprovalAt,
      this.taskAt,
      this.amount,
      this.createdAt,
      this.updatedAt});

  PaymentItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentId = json['payment_id'];
    userId = json['user_id'];
    referenceNumber = json['reference_number'];
    agencyReferenceNumber = json['agency_reference_number'];
    receiptNumber = json['receipt_number'];
    receiptNumberSap = json['receipt_number_sap'];
    receiptYear = json['receipt_year'];
    receiptDocumentDate = json['receipt_document_date'];
    receiptNote = json['receipt_note'];
    receiptAmountIgfmas = json['receipt_amount_igfmas'];
    paymentDate = json['payment_date'];
    source = json['source'];
    status = json['status'];
    cashierName = json['cashier_name'];
    firstApproverId = json['first_approver_id'];
    secondApproverId = json['second_approver_id'];
    firstApprovalAt = json['first_approval_at'];
    secondApprovalAt = json['second_approval_at'];
    taskAt = json['task_at'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_id'] = this.paymentId;
    data['user_id'] = this.userId;
    data['reference_number'] = this.referenceNumber;
    data['agency_reference_number'] = this.agencyReferenceNumber;
    data['receipt_number'] = this.receiptNumber;
    data['receipt_number_sap'] = this.receiptNumberSap;
    data['receipt_year'] = this.receiptYear;
    data['receipt_document_date'] = this.receiptDocumentDate;
    data['receipt_note'] = this.receiptNote;
    data['receipt_amount_igfmas'] = this.receiptAmountIgfmas;
    data['payment_date'] = this.paymentDate;
    data['source'] = this.source;
    data['status'] = this.status;
    data['cashier_name'] = this.cashierName;
    data['first_approver_id'] = this.firstApproverId;
    data['second_approver_id'] = this.secondApproverId;
    data['first_approval_at'] = this.firstApprovalAt;
    data['second_approval_at'] = this.secondApprovalAt;
    data['task_at'] = this.taskAt;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Chargelines {
  int? id;
  int? paymentId;
  int? classificationCodeId;
  int? ministryId;
  int? departmentId;
  int? agencyId;
  int? preparerPtjId;
  int? chargedPtjId;
  int? fundVoteId;
  int? programActivityId;
  int? projectId;
  int? accountCodeId;
  String? amount;
  String? createdAt;
  String? updatedAt;
  AccountCode? accountCode;
  FundVote? fundVote;
  ProgramActivity? programActivity;
  Project? project;
  ClassificationCode? classificationCode;

  Chargelines(
      {this.id,
      this.paymentId,
      this.classificationCodeId,
      this.ministryId,
      this.departmentId,
      this.agencyId,
      this.preparerPtjId,
      this.chargedPtjId,
      this.fundVoteId,
      this.programActivityId,
      this.projectId,
      this.accountCodeId,
      this.amount,
      this.createdAt,
      this.updatedAt,
      this.accountCode,
      this.fundVote,
      this.programActivity,
      this.project,
      this.classificationCode});

  Chargelines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentId = json['payment_id'];
    classificationCodeId = json['classification_code_id'];
    ministryId = json['ministry_id'];
    departmentId = json['department_id'];
    agencyId = json['agency_id'];
    preparerPtjId = json['preparer_ptj_id'];
    chargedPtjId = json['charged_ptj_id'];
    fundVoteId = json['fund_vote_id'];
    programActivityId = json['program_activity_id'];
    projectId = json['project_id'];
    accountCodeId = json['account_code_id'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    accountCode = json['account_code'] != null
        ? new AccountCode.fromJson(json['account_code'])
        : null;
    fundVote = json['fund_vote'] != null
        ? new FundVote.fromJson(json['fund_vote'])
        : null;
    programActivity = json['program_activity'] != null
        ? new ProgramActivity.fromJson(json['program_activity'])
        : null;
    project = json['project'] != null
        ? new Project.fromJson(json['program_activity'])
        : null;
    classificationCode = json['classification_code'] != null
        ? new ClassificationCode.fromJson(json['classification_code'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_id'] = this.paymentId;
    data['classification_code_id'] = this.classificationCodeId;
    data['ministry_id'] = this.ministryId;
    data['department_id'] = this.departmentId;
    data['agency_id'] = this.agencyId;
    data['preparer_ptj_id'] = this.preparerPtjId;
    data['charged_ptj_id'] = this.chargedPtjId;
    data['fund_vote_id'] = this.fundVoteId;
    data['program_activity_id'] = this.programActivityId;
    data['project_id'] = this.projectId;
    data['account_code_id'] = this.accountCodeId;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.accountCode != null) {
      data['account_code'] = this.accountCode!.toJson();
    }
    if (this.fundVote != null) {
      data['fund_vote'] = this.fundVote!.toJson();
    }
    if (this.programActivity != null) {
      data['program_activity'] = this.programActivity!.toJson();
    }
    data['project'] = this.project;
    if (this.classificationCode != null) {
      data['classification_code'] = this.classificationCode!.toJson();
    }
    return data;
  }
}

class AccountCode {
  int? id;
  String? financialYear;
  String? code;
  int? ptjGroupId;
  String? description;
  int? isActive;
  int? isManualAdded;
  String? createdAt;
  String? updatedAt;

  AccountCode(
      {this.id,
      this.financialYear,
      this.code,
      this.ptjGroupId,
      this.description,
      this.isActive,
      this.isManualAdded,
      this.createdAt,
      this.updatedAt});

  AccountCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    financialYear = json['financial_year'];
    code = json['code'];
    ptjGroupId = json['ptj_group_id'];
    description = json['description'];
    isActive = json['is_active'];
    isManualAdded = json['isManualAdded'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['financial_year'] = this.financialYear;
    data['code'] = this.code;
    data['ptj_group_id'] = this.ptjGroupId;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['isManualAdded'] = this.isManualAdded;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class FundVote {
  int? id;
  String? type;
  String? financialYear;
  String? code;
  String? description;
  String? startAt;
  String? endAt;
  int? isActive;
  int? isManualAdded;
  String? createdAt;
  String? updatedAt;

  FundVote(
      {this.id,
      this.type,
      this.financialYear,
      this.code,
      this.description,
      this.startAt,
      this.endAt,
      this.isActive,
      this.isManualAdded,
      this.createdAt,
      this.updatedAt});

  FundVote.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    financialYear = json['financial_year'];
    code = json['code'];
    description = json['description'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    isActive = json['is_active'];
    isManualAdded = json['isManualAdded'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['financial_year'] = this.financialYear;
    data['code'] = this.code;
    data['description'] = this.description;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['is_active'] = this.isActive;
    data['isManualAdded'] = this.isManualAdded;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ProgramActivity {
  int? id;
  String? financialYear;
  String? code;
  String? description;
  String? startAt;
  String? endAt;
  int? isActive;
  int? isManualAdded;
  String? createdAt;
  String? updatedAt;

  ProgramActivity(
      {this.id,
      this.financialYear,
      this.code,
      this.description,
      this.startAt,
      this.endAt,
      this.isActive,
      this.isManualAdded,
      this.createdAt,
      this.updatedAt});

  ProgramActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    financialYear = json['financial_year'];
    code = json['code'];
    description = json['description'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    isActive = json['is_active'];
    isManualAdded = json['isManualAdded'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['financial_year'] = this.financialYear;
    data['code'] = this.code;
    data['description'] = this.description;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['is_active'] = this.isActive;
    data['isManualAdded'] = this.isManualAdded;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ClassificationCode {
  int? id;
  String? code;
  String? description;
  String? year;
  int? ministryId;
  int? departmentId;
  int? agencyId;
  int? preparerPtjId;
  int? chargedPtjId;
  int? isFund;
  int? fundVoteId;
  int? programActivityId;
  int? projectId;
  int? accountCodeId;
  int? isSend;
  int? isActive;
  int? isManualAdded;
  String? createdAt;
  String? updatedAt;

  ClassificationCode(
      {this.id,
      this.code,
      this.description,
      this.year,
      this.ministryId,
      this.departmentId,
      this.agencyId,
      this.preparerPtjId,
      this.chargedPtjId,
      this.isFund,
      this.fundVoteId,
      this.programActivityId,
      this.projectId,
      this.accountCodeId,
      this.isSend,
      this.isActive,
      this.isManualAdded,
      this.createdAt,
      this.updatedAt});

  ClassificationCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
    year = json['year'];
    ministryId = json['ministry_id'];
    departmentId = json['department_id'];
    agencyId = json['agency_id'];
    preparerPtjId = json['preparer_ptj_id'];
    chargedPtjId = json['charged_ptj_id'];
    isFund = json['is_fund'];
    fundVoteId = json['fund_vote_id'];
    programActivityId = json['program_activity_id'];
    projectId = json['project_id'];
    accountCodeId = json['account_code_id'];
    isSend = json['is_send'];
    isActive = json['is_active'];
    isManualAdded = json['isManualAdded'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['description'] = this.description;
    data['year'] = this.year;
    data['ministry_id'] = this.ministryId;
    data['department_id'] = this.departmentId;
    data['agency_id'] = this.agencyId;
    data['preparer_ptj_id'] = this.preparerPtjId;
    data['charged_ptj_id'] = this.chargedPtjId;
    data['is_fund'] = this.isFund;
    data['fund_vote_id'] = this.fundVoteId;
    data['program_activity_id'] = this.programActivityId;
    data['project_id'] = this.projectId;
    data['account_code_id'] = this.accountCodeId;
    data['is_send'] = this.isSend;
    data['is_active'] = this.isActive;
    data['isManualAdded'] = this.isManualAdded;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AmountChanges {
  int? id;
  int? paymentId;
  int? paymentChargelineId;
  int? userId;
  String? referenceNumber;
  String? agencyReferenceNumber;
  String? agencyApprovalDate;
  String? changeAmountReason;
  String? source;
  String? status;
  int? firstApproverId;
  int? secondApproverId;
  String? firstApprovalAt;
  String? secondApprovalAt;
  String? taskAt;
  String? amount;
  String? createdAt;
  String? updatedAt;

  AmountChanges(
      {this.id,
      this.paymentId,
      this.paymentChargelineId,
      this.userId,
      this.referenceNumber,
      this.agencyReferenceNumber,
      this.agencyApprovalDate,
      this.changeAmountReason,
      this.source,
      this.status,
      this.firstApproverId,
      this.secondApproverId,
      this.firstApprovalAt,
      this.secondApprovalAt,
      this.taskAt,
      this.amount,
      this.createdAt,
      this.updatedAt});

  AmountChanges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentId = json['payment_id'];
    paymentChargelineId = json['payment_chargeline_id'];
    userId = json['user_id'];
    referenceNumber = json['reference_number'];
    agencyReferenceNumber = json['agency_reference_number'];
    agencyApprovalDate = json['agency_approval_date'];
    changeAmountReason = json['change_amount_reason'];
    source = json['source'];
    status = json['status'];
    firstApproverId = json['first_approver_id'];
    secondApproverId = json['second_approver_id'];
    firstApprovalAt = json['first_approval_at'];
    secondApprovalAt = json['second_approval_at'];
    taskAt = json['task_at'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_id'] = this.paymentId;
    data['payment_chargeline_id'] = this.paymentChargelineId;
    data['user_id'] = this.userId;
    data['reference_number'] = this.referenceNumber;
    data['agency_reference_number'] = this.agencyReferenceNumber;
    data['agency_approval_date'] = this.agencyApprovalDate;
    data['change_amount_reason'] = this.changeAmountReason;
    data['source'] = this.source;
    data['status'] = this.status;
    data['first_approver_id'] = this.firstApproverId;
    data['second_approver_id'] = this.secondApproverId;
    data['first_approval_at'] = this.firstApprovalAt;
    data['second_approval_at'] = this.secondApprovalAt;
    data['task_at'] = this.taskAt;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class NettCalculations {
  RoundingData? roundingData;
  List<ChangesItems>? changesItems;
  List<Null>? changesDraftItems;
  List<Null>? paymentItems;
  List<Null>? paymentDraftItems;
  num? rounding;
  num? original;
  num? changes;
  num? changesDraft;
  num? total;
  num? paid;
  num? paidDraft;
  num? due;
  String? dueInWords;

  NettCalculations(
      {this.roundingData,
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
      this.dueInWords});

  NettCalculations.fromJson(Map<String, dynamic> json) {
    roundingData = json['roundingData'] != null
        ? new RoundingData.fromJson(json['roundingData'])
        : null;
    if (json['changes_items'] != null) {
      changesItems = <ChangesItems>[];
      json['changes_items'].forEach((v) {
        changesItems!.add(new ChangesItems.fromJson(v));
      });
    }
    if (json['changes_draft_items'] != null) {
      changesDraftItems = <Null>[];
      json['changes_draft_items'].forEach((v) {
        // changesDraftItems!.add(new Null.fromJson(v));
      });
    }
    if (json['payment_items'] != null) {
      paymentItems = <Null>[];
      json['payment_items'].forEach((v) {
        // paymentItems!.add(new Null.fromJson(v));
      });
    }
    if (json['payment_draft_items'] != null) {
      paymentDraftItems = <Null>[];
      json['payment_draft_items'].forEach((v) {
        // paymentDraftItems!.add(new Null.fromJson(v));
      });
    }
    rounding = json['rounding'];
    original = json['original'];
    changes = json['changes'];
    changesDraft = json['changes_draft'];
    total = json['total'];
    paid = json['paid'];
    paidDraft = json['paid_draft'];
    due = json['due'];
    dueInWords = json['due_in_words'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roundingData'] = this.roundingData;
    if (this.changesItems != null) {
      // data['changes_items'] =
      //     this.changesItems!.map((v) => v.toJson()).toList();
    }
    if (this.changesDraftItems != null) {
      // data['changes_draft_items'] =
      //     this.changesDraftItems!.map((v) => v.toJson()).toList();
    }
    if (this.paymentItems != null) {
      // data['payment_items'] =
      //     this.paymentItems!.map((v) => v.toJson()).toList();
    }
    if (this.paymentDraftItems != null) {
      // data['payment_draft_items'] =
      //     this.paymentDraftItems!.map((v) => v.toJson()).toList();
    }
    data['rounding'] = this.rounding;
    data['original'] = this.original;
    data['changes'] = this.changes;
    data['changes_draft'] = this.changesDraft;
    data['total'] = this.total;
    data['paid'] = this.paid;
    data['paid_draft'] = this.paidDraft;
    data['due'] = this.due;
    data['due_in_words'] = this.dueInWords;
    return data;
  }
}

class RoundingData {
  double? amount;
  int? fundVoteId;
  int? accountCodeId;

  RoundingData({this.amount, this.fundVoteId, this.accountCodeId});

  RoundingData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    fundVoteId = json['fund_vote_id'];
    accountCodeId = json['account_code_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['fund_vote_id'] = this.fundVoteId;
    data['account_code_id'] = this.accountCodeId;
    return data;
  }
}

class Customers {
  int? id;
  int? userIdentityTypeId;
  String? firstName;
  String? lastName;
  UserIdentityType? userIdentityType;

  Customers(
      {this.id,
      this.userIdentityTypeId,
      this.firstName,
      this.lastName,
      this.userIdentityType});

  Customers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userIdentityTypeId = json['user_identity_type_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userIdentityType = json['user_identity_type'] != null
        ? new UserIdentityType.fromJson(json['user_identity_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_identity_type_id'] = this.userIdentityTypeId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    if (this.userIdentityType != null) {
      data['user_identity_type'] = this.userIdentityType!.toJson();
    }
    return data;
  }
}

class ChangesItems {
  int? id;
  int? paymentId;
  int? paymentChargelineId;
  int? userId;
  String? referenceNumber;
  String? agencyReferenceNumber;
  String? agencyApprovalDate;
  String? changeAmountReason;
  String? source;
  String? status;
  int? firstApproverId;
  int? secondApproverId;
  String? firstApprovalAt;
  String? secondApprovalAt;
  String? taskAt;
  String? amount;
  String? createdAt;
  String? updatedAt;

  ChangesItems(
      {this.id,
      this.paymentId,
      this.paymentChargelineId,
      this.userId,
      this.referenceNumber,
      this.agencyReferenceNumber,
      this.agencyApprovalDate,
      this.changeAmountReason,
      this.source,
      this.status,
      this.firstApproverId,
      this.secondApproverId,
      this.firstApprovalAt,
      this.secondApprovalAt,
      this.taskAt,
      this.amount,
      this.createdAt,
      this.updatedAt});

  ChangesItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentId = json['payment_id'];
    paymentChargelineId = json['payment_chargeline_id'];
    userId = json['user_id'];
    referenceNumber = json['reference_number'];
    agencyReferenceNumber = json['agency_reference_number'];
    agencyApprovalDate = json['agency_approval_date'];
    changeAmountReason = json['change_amount_reason'];
    source = json['source'];
    status = json['status'];
    firstApproverId = json['first_approver_id'];
    secondApproverId = json['second_approver_id'];
    firstApprovalAt = json['first_approval_at'];
    secondApprovalAt = json['second_approval_at'];
    taskAt = json['task_at'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_id'] = this.paymentId;
    data['payment_chargeline_id'] = this.paymentChargelineId;
    data['user_id'] = this.userId;
    data['reference_number'] = this.referenceNumber;
    data['agency_reference_number'] = this.agencyReferenceNumber;
    data['agency_approval_date'] = this.agencyApprovalDate;
    data['change_amount_reason'] = this.changeAmountReason;
    data['source'] = this.source;
    data['status'] = this.status;
    data['first_approver_id'] = this.firstApproverId;
    data['second_approver_id'] = this.secondApproverId;
    data['first_approval_at'] = this.firstApprovalAt;
    data['second_approval_at'] = this.secondApprovalAt;
    data['task_at'] = this.taskAt;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class UserIdentityType {
  int? id;
  String? category;

  UserIdentityType({this.id, this.category});

  UserIdentityType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    return data;
  }
}

class BillType {
  int? id;
  String? type;

  BillType({this.id, this.type});

  BillType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    return data;
  }
}

class Service {
  int? id;
  int? menuId;
  String? name;
  String? serviceReferenceNumber;
  String? cbyChargelines;
  String? receiptType;
  String? serviceChargeData;
  String? taxData;
  String? discountData;
  String? chargelineData;
  String? chargedTo;
  String? status;
  String? submittedAt;
  String? approvalBaAt;
  String? serviceCategory;
  String? allowThirdPartyPayment;
  String? refNoLabel;
  Menuss? menu;

  Service(
      {this.id,
      this.menuId,
      this.name,
      this.serviceReferenceNumber,
      this.cbyChargelines,
      this.receiptType,
      this.serviceChargeData,
      this.taxData,
      this.discountData,
      this.chargelineData,
      this.chargedTo,
      this.status,
      this.submittedAt,
      this.approvalBaAt,
      this.serviceCategory,
      this.allowThirdPartyPayment,
      this.refNoLabel,
      this.menu});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    name = json['name'];
    serviceReferenceNumber = json['service_reference_number'];
    cbyChargelines = json['cby_chargelines'];
    receiptType = json['receipt_type'];
    serviceChargeData = json['service_charge_data'];
    taxData = json['tax_data'];
    discountData = json['discount_data'];
    chargelineData = json['chargeline_data'];
    chargedTo = json['charged_to'];
    status = json['status'];
    submittedAt = json['submitted_at'];
    approvalBaAt = json['approval_ba_at'];
    serviceCategory = json['service_category'];
    allowThirdPartyPayment = json['allow_third_party_payment'];
    refNoLabel = json['ref_no_label'];
    menu = json['menu'] != null ? new Menuss.fromJson(json['menu']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    data['name'] = this.name;
    data['service_reference_number'] = this.serviceReferenceNumber;
    data['cby_chargelines'] = this.cbyChargelines;
    data['receipt_type'] = this.receiptType;
    data['service_charge_data'] = this.serviceChargeData;
    data['tax_data'] = this.taxData;
    data['discount_data'] = this.discountData;
    data['chargeline_data'] = this.chargelineData;
    data['charged_to'] = this.chargedTo;
    data['status'] = this.status;
    data['submitted_at'] = this.submittedAt;
    data['approval_ba_at'] = this.approvalBaAt;
    data['service_category'] = this.serviceCategory;
    data['allow_third_party_payment'] = this.allowThirdPartyPayment;
    data['ref_no_label'] = this.refNoLabel;
    if (this.menu != null) {
      data['menu'] = this.menu!.toJson();
    }
    return data;
  }
}

class Menus {
  int? id;
  String? name;

  Menus({this.id, this.name});

  Menus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Agency {
  int? id;
  String? name;
  String? shortName;
  String? code;
  String? profile;
  String? address;
  int? ministryId;
  int? departmentId;
  Department? department;
  Ministry? ministry;

  Agency(
      {this.id,
      this.name,
      this.shortName,
      this.code,
      this.profile,
      this.address,
      this.ministryId,
      this.departmentId,
      this.department,
      this.ministry});

  Agency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['short_name'];
    code = json['code'];
    profile = json['profile'];
    address = json['address'];
    ministryId = json['ministry_id'];
    departmentId = json['department_id'];
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
    ministry = json['ministry'] != null
        ? new Ministry.fromJson(json['ministry'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['short_name'] = this.shortName;
    data['code'] = this.code;
    data['profile'] = this.profile;
    data['address'] = this.address;
    data['ministry_id'] = this.ministryId;
    data['department_id'] = this.departmentId;
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    if (this.ministry != null) {
      data['ministry'] = this.ministry!.toJson();
    }
    return data;
  }
}

class Department {
  int? id;
  String? departmentName;
  String? deptReferenceNo;

  Department({this.id, this.departmentName, this.deptReferenceNo});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentName = json['department_name'];
    deptReferenceNo = json['dept_reference_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['department_name'] = this.departmentName;
    data['dept_reference_no'] = this.deptReferenceNo;
    return data;
  }
}

class Ministry {
  int? id;
  String? ministryName;
  // ignore: unnecessary_question_mark
  Null shortName;
  String? ministryReferenceNo;

  Ministry(
      {this.id, this.ministryName, this.shortName, this.ministryReferenceNo});

  Ministry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ministryName = json['ministry_name'];
    shortName = json['short_name'];
    ministryReferenceNo = json['ministry_reference_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ministry_name'] = this.ministryName;
    data['short_name'] = this.shortName;
    data['ministry_reference_no'] = this.ministryReferenceNo;
    return data;
  }
}

class PaymentGateway {
  int? id;
  String? name;
  String? originalName;
  String? description;
  String? logo;
  String? owner;
  String? address;
  String? admin;
  String? position;
  String? officialEmail;
  String? officePhone;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  bool? isObw;
  bool? isQr;

  // could be original name or translated name
  String? title;

  PaymentGateway({
    this.id,
    this.title,
    this.originalName,
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
    this.isObw,
    this.isQr,
  });

  bool needPaynetBank() {
    return (name ?? '').toLowerCase() == 'DuitNow OBW'.toLowerCase() ||
        (isObw == null ? false : isObw!);
  }

  bool isQrPayment() {
    return "${this.name}".toLowerCase() == 'DuitNow QR'.toLowerCase() ||
        (this.isQr == null ? false : this.isQr!);
  }

  PaymentGateway.fromJson(Map<String, dynamic> json) {
    String code = Get.locale?.languageCode ?? 'ms_MY';

    // find the translated name
    var tran = (json['translatables'] ?? []).firstWhere(
      (e) => e['content'] != null && e['language'] == code,
    );

    // set title with the translated name
    title = tran?['content'] ?? json['name'];

    // DO NOT CHANGE ORIGINAL 'name'
    // it used in the logic:
    // - [PaymentGateway.needPaynetBank]
    // - [PaymentGateway.isQrPayment]
    name = json['name'];

    id = json['id'];
    description = json['description'];
    logo = json['logo'];
    owner = json['owner'];
    address = json['address'];
    admin = json['admin'];
    position = json['position'];
    officialEmail = json['official_email'];
    officePhone = json['office_phone'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.title;
    data['description'] = this.description;
    data['logo'] = this.logo;
    data['owner'] = this.owner;
    data['address'] = this.address;
    data['admin'] = this.admin;
    data['position'] = this.position;
    data['official_email'] = this.officialEmail;
    data['office_phone'] = this.officePhone;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Banks {
  String? code;
  String? name;
  bool? active;
  String? browser;
  String? iosApplicationId;
  String? androidApplicationId;
  List<RedirectUrls>? redirectUrls;

  Banks(
      {this.code,
      this.name,
      this.active,
      this.browser,
      this.iosApplicationId,
      this.androidApplicationId,
      this.redirectUrls});

  Banks.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    active = json['active'];
    browser = json['browser'];
    iosApplicationId = json['iosApplicationId'];
    androidApplicationId = json['androidApplicationId'];
    if (json['redirectUrls'] != null) {
      redirectUrls = <RedirectUrls>[];
      json['redirectUrls'].forEach((v) {
        redirectUrls!.add(new RedirectUrls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['active'] = this.active;
    data['browser'] = this.browser;
    data['iosApplicationId'] = this.iosApplicationId;
    data['androidApplicationId'] = this.androidApplicationId;
    if (this.redirectUrls != null) {
      data['redirectUrls'] = this.redirectUrls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RedirectUrls {
  String? type;
  String? url;

  RedirectUrls({this.type, this.url});

  RedirectUrls.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}

class HistoryItem {
  int? userId;
  int? customerId;
  int? id;
  int? paymentId;
  String? referenceNumber;
  String? transactionReference;
  String? paymentDescription;
  String? receiptNumber;
  String? userName;
  String? detail;
  String? billNumber;
  String? billReferenceNumber;
  String? amount;
  String? createdAt;
  String? status;
  String? source;
  int? billTypeId;

  HistoryItem(
      {this.userId,
      this.customerId,
      this.id,
      this.paymentId,
      this.referenceNumber,
      this.transactionReference,
      this.paymentDescription,
      this.receiptNumber,
      this.userName,
      this.detail,
      this.billNumber,
      this.billReferenceNumber,
      this.amount,
      this.createdAt,
      this.status,
      this.source});

  HistoryItem.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    customerId = json['customer_id'];
    id = json['id'];
    paymentId = json['payment_id'];
    referenceNumber = json['reference_number'];
    transactionReference = json['transaction_reference'];
    paymentDescription = json['payment_description'];
    receiptNumber = json['receipt_number'];
    userName = json['user_name'];
    detail = json['detail'];
    billNumber = json['bill_number'];
    billReferenceNumber = json['bill_reference_number'];
    amount = json['amount'];
    createdAt = json['created_at'];
    status = json['status'];
    source = json['source'];
    billTypeId = json['bill_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['customer_id'] = this.customerId;
    data['id'] = this.id;
    data['payment_id'] = this.paymentId;
    data['reference_number'] = this.referenceNumber;
    data['transaction_reference'] = this.transactionReference;
    data['payment_description'] = this.paymentDescription;
    data['receipt_number'] = this.receiptNumber;
    data['user_name'] = this.userName;
    data['detail'] = this.detail;
    data['bill_number'] = this.billNumber;
    data['bill_reference_number'] = this.billReferenceNumber;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['source'] = this.source;
    return data;
  }
}

class History {
  int? id;
  Null transferDetailId;
  int? gatewayId;
  int? rmaId;
  int? userId;
  Null counterUserId;
  Null counterId;
  Null collectionCenterId;
  Null counterHistoryId;
  String? referenceNumber;
  String? transactionReference;
  String? amount;
  String? paymentMethod;
  String? paymentResponse;
  int? count;
  String? source;
  Null customerName;
  Null customerEmail;
  Null customerPhoneNo;
  String? status;
  String? flag;
  String? transactionFee;
  int? settlement;
  Null settledAt;
  String? createdAt;
  String? updatedAt;
  List<Items>? items;
  Customer? user;
  int? paymentCategory;

  History(
      {this.id,
      this.transferDetailId,
      this.gatewayId,
      this.rmaId,
      this.userId,
      this.counterUserId,
      this.counterId,
      this.collectionCenterId,
      this.counterHistoryId,
      this.referenceNumber,
      this.transactionReference,
      this.amount,
      this.paymentMethod,
      this.paymentResponse,
      this.count,
      this.source,
      this.customerName,
      this.customerEmail,
      this.customerPhoneNo,
      this.status,
      this.flag,
      this.transactionFee,
      this.settlement,
      this.settledAt,
      this.createdAt,
      this.updatedAt,
      this.items,
      this.user,
      this.paymentCategory});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transferDetailId = json['transfer_detail_id'];
    gatewayId = json['gateway_id'];
    rmaId = json['rma_id'];
    userId = json['user_id'];
    counterUserId = json['counter_user_id'];
    counterId = json['counter_id'];
    collectionCenterId = json['collection_center_id'];
    counterHistoryId = json['counter_history_id'];
    referenceNumber = json['reference_number'];
    transactionReference = json['transaction_reference'];
    amount = json['amount'];
    paymentMethod = json['payment_method'];
    paymentResponse = json['payment_response'];
    count = json['count'];
    source = json['source'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerPhoneNo = json['customer_phone_no'];
    status = json['status'];
    flag = json['flag'];
    transactionFee = json['transaction_fee'];
    settlement = json['settlement'];
    settledAt = json['settled_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    user = json['user'] != null ? new Customer.fromJson(json['user']) : null;
    paymentCategory = json['payment_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transfer_detail_id'] = this.transferDetailId;
    data['gateway_id'] = this.gatewayId;
    data['rma_id'] = this.rmaId;
    data['user_id'] = this.userId;
    data['counter_user_id'] = this.counterUserId;
    data['counter_id'] = this.counterId;
    data['collection_center_id'] = this.collectionCenterId;
    data['counter_history_id'] = this.counterHistoryId;
    data['reference_number'] = this.referenceNumber;
    data['transaction_reference'] = this.transactionReference;
    data['amount'] = this.amount;
    data['payment_method'] = this.paymentMethod;
    data['payment_response'] = this.paymentResponse;
    data['count'] = this.count;
    data['source'] = this.source;
    data['customer_name'] = this.customerName;
    data['customer_email'] = this.customerEmail;
    data['customer_phone_no'] = this.customerPhoneNo;
    data['status'] = this.status;
    data['flag'] = this.flag;
    data['transaction_fee'] = this.transactionFee;
    data['settlement'] = this.settlement;
    data['settled_at'] = this.settledAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['payment_category'] = this.paymentCategory;
    return data;
  }
}

class Receipt {
  String? downloadUrl;

  Receipt({this.downloadUrl});

  Receipt.fromJson(Map<String, dynamic> json) {
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['download_url'] = this.downloadUrl;
    return data;
  }
}

class Items {
  int? id;
  int? transactionId;
  int? billId;
  int? customerId;
  String? receiptNumber;
  String? receiptDate;
  String? originalReceiptUrl;
  String? copyReceiptUrl;
  String? paymentDescription;
  int? serviceId;
  String? amount;
  // Item? items;
  // String? extraFields;
  String? createdAt;
  String? updatedAt;
  Bills? bill;
  Service? service;
  Customer? customer;

  Items(
      {this.id,
      this.transactionId,
      this.billId,
      this.customerId,
      this.receiptNumber,
      this.receiptDate,
      this.originalReceiptUrl,
      this.copyReceiptUrl,
      this.paymentDescription,
      this.serviceId,
      this.amount,
      // this.items,
      // this.extraFields,
      this.createdAt,
      this.updatedAt,
      // this.bill,
      this.service,
      this.customer});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    billId = json['bill_id'];
    customerId = json['customer_id'];
    receiptNumber = json['receipt_number'];
    receiptDate = json['receipt_date'];
    originalReceiptUrl = json['original_receipt_url'];
    copyReceiptUrl = json['copy_receipt_url'];
    paymentDescription = json['payment_description'];
    serviceId = json['service_id'];
    amount = json['amount'];
    // items = json['items'] != null ? new Item.fromJson(json['items']) : null;
    // extraFields = json['extra_fields'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bill = json['bill'] != null ? new Bills.fromJson(json['service']) : null;

    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_id'] = this.transactionId;
    data['bill_id'] = this.billId;
    data['customer_id'] = this.customerId;
    data['receipt_number'] = this.receiptNumber;
    data['receipt_date'] = this.receiptDate;
    data['original_receipt_url'] = this.originalReceiptUrl;
    data['copy_receipt_url'] = this.copyReceiptUrl;
    data['payment_description'] = this.paymentDescription;
    data['service_id'] = this.serviceId;
    data['amount'] = this.amount;
    // if (this.items != null) {
    //   data['items'] = this.items!.toJson();
    // }
    // data['extra_fields'] = this.extraFields;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // data['bill'] = this.bill;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Item {
  String? referenceNumber;

  Item({this.referenceNumber});

  Item.fromJson(Map<String, dynamic> json) {
    referenceNumber = json['reference_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reference_number'] = this.referenceNumber;
    return data;
  }
}

class Bill {
  int? id;
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
  Null productId;
  Null subproductId;
  BillType? billType;
  Null processCode;
  String? referenceNumber;
  String? detail;
  Null entityCode;
  String? identityCode;
  String? name1;
  String? name2;
  String? address1;
  Null address2;
  Null address3;
  String? postcode;
  String? city;
  String? district;
  String? state;
  String? country;
  String? telephone;
  Null fax;
  String? email;
  Null description;
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
  String? nettAmount;
  String? nettAmountText;
  String? collectionLocation;
  String? centralisedLocation;
  String? centralisedSublocation;
  String? startAt;
  String? endAt;
  String? billMask;
  String? billNumber;
  String? calculations;
  int? creatorId;
  List<Null>? validationErrors;
  Null remarks;
  int? payerId;
  Null customerId;
  Null oldCustomerId;
  int? amountWasChanged;
  int? customerCharge;
  Null cancellationCategory;
  Null cancellationReason;
  Null queryRemarks;
  String? status;
  String? source;
  String? createdAt;
  String? updatedAt;
  Service? service;
  Agency? agency;
  Null customer;

  Bill(
      {this.id,
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
      this.actualAmount,
      this.paidAmount,
      this.changedAmout,
      this.amountWithoutTax,
      this.discountType,
      this.discountAmount,
      this.amountWithDiscount,
      this.taxAmount,
      this.amountWithTax,
      this.roundingAdjustment,
      this.nettAmount,
      this.nettAmountText,
      this.collectionLocation,
      this.centralisedLocation,
      this.centralisedSublocation,
      this.startAt,
      this.endAt,
      this.billMask,
      this.billNumber,
      this.calculations,
      this.creatorId,
      this.validationErrors,
      this.remarks,
      this.payerId,
      this.customerId,
      this.oldCustomerId,
      this.amountWasChanged,
      this.customerCharge,
      this.cancellationCategory,
      this.cancellationReason,
      this.queryRemarks,
      this.status,
      this.source,
      this.createdAt,
      this.updatedAt,
      this.service,
      this.agency,
      this.customer});

  Bill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stagingPaymentId = json['staging_payment_id'];
    serviceId = json['service_id'];
    billTypeId = json['bill_type_id'];
    ministryId = json['ministry_id'];
    makerControllingOfficerId = json['maker_controlling_officer_id'];
    makerPtjGroupId = json['maker_ptj_group_id'];
    makerPtjId = json['maker_ptj_id'];
    makerAccountingOfficeId = json['maker_accounting_office_id'];
    chargedControllingOfficerId = json['charged_controlling_officer_id'];
    chargedPtjGroupId = json['charged_ptj_group_id'];
    chargedPtjId = json['charged_ptj_id'];
    departmentId = json['department_id'];
    agencyId = json['agency_id'];
    productId = json['product_id'];
    subproductId = json['subproduct_id'];
    billType = json['bill_type'] != null
        ? new BillType.fromJson(json['bill_type'])
        : null;
    processCode = json['process_code'];
    referenceNumber = json['reference_number'];
    detail = json['detail'];
    entityCode = json['entity_code'];
    identityCode = json['identity_code'];
    name1 = json['name_1'];
    name2 = json['name_2'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    address3 = json['address_3'];
    postcode = json['postcode'];
    city = json['city'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    telephone = json['telephone'];
    fax = json['fax'];
    email = json['email'];
    description = json['description'];
    actualAmount = json['actual_amount'];
    paidAmount = json['paid_amount'];
    changedAmout = json['changed_amout'];
    amountWithoutTax = json['amount_without_tax'];
    discountType = json['discount_type'];
    discountAmount = json['discount_amount'];
    amountWithDiscount = json['amount_with_discount'];
    taxAmount = json['tax_amount'];
    amountWithTax = json['amount_with_tax'];
    roundingAdjustment = json['rounding_adjustment'];
    nettAmount = json['nett_amount'];
    nettAmountText = json['nett_amount_text'];
    collectionLocation = json['collection_location'];
    centralisedLocation = json['centralised_location'];
    centralisedSublocation = json['centralised_sublocation'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    billMask = json['bill_mask'];
    billNumber = json['bill_number'];
    calculations = json['calculations'];
    creatorId = json['creator_id'];
    if (json['validation_errors'] != null) {
      validationErrors = <Null>[];
      json['validation_errors'].forEach((v) {
        // validationErrors!.add(new Null.fromJson(v));
      });
    }
    remarks = json['remarks'];
    payerId = json['payer_id'];
    customerId = json['customer_id'];
    oldCustomerId = json['old_customer_id'];
    amountWasChanged = json['amount_was_changed'];
    customerCharge = json['customer_charge'];
    cancellationCategory = json['cancellation_category'];
    cancellationReason = json['cancellation_reason'];
    queryRemarks = json['query_remarks'];
    status = json['status'];
    source = json['source'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    agency =
        json['agency'] != null ? new Agency.fromJson(json['agency']) : null;
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staging_payment_id'] = this.stagingPaymentId;
    data['service_id'] = this.serviceId;
    data['bill_type_id'] = this.billTypeId;
    data['ministry_id'] = this.ministryId;
    data['maker_controlling_officer_id'] = this.makerControllingOfficerId;
    data['maker_ptj_group_id'] = this.makerPtjGroupId;
    data['maker_ptj_id'] = this.makerPtjId;
    data['maker_accounting_office_id'] = this.makerAccountingOfficeId;
    data['charged_controlling_officer_id'] = this.chargedControllingOfficerId;
    data['charged_ptj_group_id'] = this.chargedPtjGroupId;
    data['charged_ptj_id'] = this.chargedPtjId;
    data['department_id'] = this.departmentId;
    data['agency_id'] = this.agencyId;
    data['product_id'] = this.productId;
    data['subproduct_id'] = this.subproductId;
    if (this.billType != null) {
      data['bill_type'] = this.billType!.toJson();
    }
    data['process_code'] = this.processCode;
    data['reference_number'] = this.referenceNumber;
    data['detail'] = this.detail;
    data['entity_code'] = this.entityCode;
    data['identity_code'] = this.identityCode;
    data['name_1'] = this.name1;
    data['name_2'] = this.name2;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['address_3'] = this.address3;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['telephone'] = this.telephone;
    data['fax'] = this.fax;
    data['email'] = this.email;
    data['description'] = this.description;
    data['actual_amount'] = this.actualAmount;
    data['paid_amount'] = this.paidAmount;
    data['changed_amout'] = this.changedAmout;
    data['amount_without_tax'] = this.amountWithoutTax;
    data['discount_type'] = this.discountType;
    data['discount_amount'] = this.discountAmount;
    data['amount_with_discount'] = this.amountWithDiscount;
    data['tax_amount'] = this.taxAmount;
    data['amount_with_tax'] = this.amountWithTax;
    data['rounding_adjustment'] = this.roundingAdjustment;
    data['nett_amount'] = this.nettAmount;
    data['nett_amount_text'] = this.nettAmountText;
    data['collection_location'] = this.collectionLocation;
    data['centralised_location'] = this.centralisedLocation;
    data['centralised_sublocation'] = this.centralisedSublocation;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['bill_mask'] = this.billMask;
    data['bill_number'] = this.billNumber;
    data['calculations'] = this.calculations;
    data['creator_id'] = this.creatorId;
    if (this.validationErrors != null) {
      // data['validation_errors'] =
      //     this.validationErrors!.map((v) => v.toJson()).toList();
    }
    data['remarks'] = this.remarks;
    data['payer_id'] = this.payerId;
    data['customer_id'] = this.customerId;
    data['old_customer_id'] = this.oldCustomerId;
    data['amount_was_changed'] = this.amountWasChanged;
    data['customer_charge'] = this.customerCharge;
    data['cancellation_category'] = this.cancellationCategory;
    data['cancellation_reason'] = this.cancellationReason;
    data['query_remarks'] = this.queryRemarks;
    data['status'] = this.status;
    data['source'] = this.source;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.agency != null) {
      data['agency'] = this.agency!.toJson();
    }
    data['customer'] = this.customer;
    return data;
  }
}

class Users {
  int? id;
  String? icNo;
  String? firstName;
  String? lastName;

  Users({this.id, this.icNo, this.firstName, this.lastName});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icNo = json['ic_no'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ic_no'] = this.icNo;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class Services {
  int? id;
  int? agencyId;
  int? ministryId;
  String? name;
  int? menuId;
  String? serviceReferenceNumber;
  int? billTypeId;
  Null serviceGroupId;
  Null systemSupportingDocumentPath;
  Null systemApprovalLetterDate;
  Null systemApprovalLetterRef;
  Null systemDescription;
  Null systemLogo;
  Null systemName;
  Null productLabelDisplay;
  List<Null>? matrix;
  List<Null>? extraFields;
  String? fileExtensions;
  Null maxFileSize;
  Null refNoLabel;
  int? allowCby;
  String? cbyChargelines;
  String? receiptType;
  int? allowPartialPayment;
  int? isSensitive;
  int? isInvoiceIGFMAS;
  String? allowThirdPartyPayment;
  String? thirdPartySearchTypes;
  Null serviceMode;
  String? integrationData;
  String? serviceChargeData;
  String? taxData;
  String? discountData;
  String? chargelineData;
  String? chargedTo;
  String? status;
  int? creatorId;
  int? hasModified;
  String? submittedAt;
  String? approvalAgencyAt;
  int? approvalAgencyBy;
  Null approvalAgencyRemarks;
  Null approvalBaRemarks;
  String? approvalBaAt;
  int? approvalBaBy;
  String? approvalJanmFungsianAt;
  Null approvalJanmFungsianRemarks;
  int? approvalJanmFungsianBy;
  String? approvalJanmTeknikalAt;
  Null approvalJanmTeknikalRemarks;
  int? approvalJanmTeknikalBy;
  String? createdAt;
  String? updatedAt;

  Services(
      {this.id,
      this.agencyId,
      this.ministryId,
      this.name,
      this.menuId,
      this.serviceReferenceNumber,
      this.billTypeId,
      this.serviceGroupId,
      this.systemSupportingDocumentPath,
      this.systemApprovalLetterDate,
      this.systemApprovalLetterRef,
      this.systemDescription,
      this.systemLogo,
      this.systemName,
      this.productLabelDisplay,
      this.matrix,
      this.extraFields,
      this.fileExtensions,
      this.maxFileSize,
      this.refNoLabel,
      this.allowCby,
      this.cbyChargelines,
      this.receiptType,
      this.allowPartialPayment,
      this.isSensitive,
      this.isInvoiceIGFMAS,
      this.allowThirdPartyPayment,
      this.thirdPartySearchTypes,
      this.serviceMode,
      this.integrationData,
      this.serviceChargeData,
      this.taxData,
      this.discountData,
      this.chargelineData,
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
      this.approvalJanmFungsianAt,
      this.approvalJanmFungsianRemarks,
      this.approvalJanmFungsianBy,
      this.approvalJanmTeknikalAt,
      this.approvalJanmTeknikalRemarks,
      this.approvalJanmTeknikalBy,
      this.createdAt,
      this.updatedAt});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agencyId = json['agency_id'];
    ministryId = json['ministry_id'];
    name = json['name'];
    menuId = json['menu_id'];
    serviceReferenceNumber = json['service_reference_number'];
    billTypeId = json['bill_type_id'];
    serviceGroupId = json['service_group_id'];
    systemSupportingDocumentPath = json['system_supporting_document_path'];
    systemApprovalLetterDate = json['system_approval_letter_date'];
    systemApprovalLetterRef = json['system_approval_letter_ref'];
    systemDescription = json['system_description'];
    systemLogo = json['system_logo'];
    systemName = json['system_name'];
    productLabelDisplay = json['product_label_display'];
    if (json['matrix'] != null) {
      matrix = <Null>[];
      json['matrix'].forEach((v) {
        // matrix!.add(new Null.fromJson(v));
      });
    }
    if (json['extra_fields'] != null) {
      extraFields = <Null>[];
      json['extra_fields'].forEach((v) {
        // extraFields!.add(new Null.fromJson(v));
      });
    }
    fileExtensions = json['file_extensions'];
    maxFileSize = json['max_file_size'];
    refNoLabel = json['ref_no_label'];
    allowCby = json['allow_cby'];
    cbyChargelines = json['cby_chargelines'];
    receiptType = json['receipt_type'];
    allowPartialPayment = json['allow_partial_payment'];
    isSensitive = json['is_sensitive'];
    isInvoiceIGFMAS = json['is_invoice_iGFMAS'];
    allowThirdPartyPayment = json['allow_third_party_payment'];
    thirdPartySearchTypes = json['third_party_search_types'];
    serviceMode = json['service_mode'];
    integrationData = json['integration_data'];
    serviceChargeData = json['service_charge_data'];
    taxData = json['tax_data'];
    discountData = json['discount_data'];
    chargelineData = json['chargeline_data'];
    chargedTo = json['charged_to'];
    status = json['status'];
    creatorId = json['creator_id'];
    hasModified = json['has_modified'];
    submittedAt = json['submitted_at'];
    approvalAgencyAt = json['approval_agency_at'];
    approvalAgencyBy = json['approval_agency_by'];
    approvalAgencyRemarks = json['approval_agency_remarks'];
    approvalBaRemarks = json['approval_ba_remarks'];
    approvalBaAt = json['approval_ba_at'];
    approvalBaBy = json['approval_ba_by'];
    approvalJanmFungsianAt = json['approval_janm_fungsian_at'];
    approvalJanmFungsianRemarks = json['approval_janm_fungsian_remarks'];
    approvalJanmFungsianBy = json['approval_janm_fungsian_by'];
    approvalJanmTeknikalAt = json['approval_janm_teknikal_at'];
    approvalJanmTeknikalRemarks = json['approval_janm_teknikal_remarks'];
    approvalJanmTeknikalBy = json['approval_janm_teknikal_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['agency_id'] = this.agencyId;
    data['ministry_id'] = this.ministryId;
    data['name'] = this.name;
    data['menu_id'] = this.menuId;
    data['service_reference_number'] = this.serviceReferenceNumber;
    data['bill_type_id'] = this.billTypeId;
    data['service_group_id'] = this.serviceGroupId;
    data['system_supporting_document_path'] = this.systemSupportingDocumentPath;
    data['system_approval_letter_date'] = this.systemApprovalLetterDate;
    data['system_approval_letter_ref'] = this.systemApprovalLetterRef;
    data['system_description'] = this.systemDescription;
    data['system_logo'] = this.systemLogo;
    data['system_name'] = this.systemName;
    data['product_label_display'] = this.productLabelDisplay;
    if (this.matrix != null) {
      // data['matrix'] = this.matrix!.map((v) => v.toJson()).toList();
    }
    if (this.extraFields != null) {
      // data['extra_fields'] = this.extraFields!.map((v) => v.toJson()).toList();
    }
    data['file_extensions'] = this.fileExtensions;
    data['max_file_size'] = this.maxFileSize;
    data['ref_no_label'] = this.refNoLabel;
    data['allow_cby'] = this.allowCby;
    data['cby_chargelines'] = this.cbyChargelines;
    data['receipt_type'] = this.receiptType;
    data['allow_partial_payment'] = this.allowPartialPayment;
    data['is_sensitive'] = this.isSensitive;
    data['is_invoice_iGFMAS'] = this.isInvoiceIGFMAS;
    data['allow_third_party_payment'] = this.allowThirdPartyPayment;
    data['third_party_search_types'] = this.thirdPartySearchTypes;
    data['service_mode'] = this.serviceMode;
    data['integration_data'] = this.integrationData;
    data['service_charge_data'] = this.serviceChargeData;
    data['tax_data'] = this.taxData;
    data['discount_data'] = this.discountData;
    data['chargeline_data'] = this.chargelineData;
    data['charged_to'] = this.chargedTo;
    data['status'] = this.status;
    data['creator_id'] = this.creatorId;
    data['has_modified'] = this.hasModified;
    data['submitted_at'] = this.submittedAt;
    data['approval_agency_at'] = this.approvalAgencyAt;
    data['approval_agency_by'] = this.approvalAgencyBy;
    data['approval_agency_remarks'] = this.approvalAgencyRemarks;
    data['approval_ba_remarks'] = this.approvalBaRemarks;
    data['approval_ba_at'] = this.approvalBaAt;
    data['approval_ba_by'] = this.approvalBaBy;
    data['approval_janm_fungsian_at'] = this.approvalJanmFungsianAt;
    data['approval_janm_fungsian_remarks'] = this.approvalJanmFungsianRemarks;
    data['approval_janm_fungsian_by'] = this.approvalJanmFungsianBy;
    data['approval_janm_teknikal_at'] = this.approvalJanmTeknikalAt;
    data['approval_janm_teknikal_remarks'] = this.approvalJanmTeknikalRemarks;
    data['approval_janm_teknikal_by'] = this.approvalJanmTeknikalBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Customer {
  int? id;
  String? icNo;
  String? firstName;
  String? lastName;

  Customer({this.id, this.icNo, this.firstName, this.lastName});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icNo = json['ic_no'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ic_no'] = this.icNo;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class FavBill {
  int? id;
  int? userId;
  int? serviceId;
  int? billId;
  String? createdAt;
  String? updatedAt;
  late Billss bill;

  FavBill(
      {this.id,
      this.userId,
      this.serviceId,
      this.billId,
      this.createdAt,
      this.updatedAt,
      required this.bill});

  FavBill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    billId = json['bill_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bill = (json['bill'] != null ? new Billss.fromJson(json['bill']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['service_id'] = this.serviceId;
    data['bill_id'] = this.billId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['bill'] = this.bill.toJson();
    return data;
  }
}

class Billss {
  int? id;
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
  Null productId;
  Null subproductId;
  BillType? billType;
  Null processCode;
  String? referenceNumber;
  String? detail;
  Null entityCode;
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
  Null fax;
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
  String? nettAmount;
  String? nettAmountText;
  String? collectionLocation;
  String? centralisedLocation;
  String? centralisedSublocation;
  String? startAt;
  String? endAt;
  String? billMask;
  String? billNumber;
  String? calculations;
  int? creatorId;
  List<Null>? validationErrors;
  Null remarks;
  Null payerId;
  Null customerId;
  Null oldCustomerId;
  int? amountWasChanged;
  int? customerCharge;
  String? cancellationCategory;
  String? cancellationReason;
  String? queryRemarks;
  String? status;
  String? source;
  String? createdAt;
  String? updatedAt;
  Service? service;
  Agency? agency;
  Null customer;

  Billss(
      {this.id,
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
      this.actualAmount,
      this.paidAmount,
      this.changedAmout,
      this.amountWithoutTax,
      this.discountType,
      this.discountAmount,
      this.amountWithDiscount,
      this.taxAmount,
      this.amountWithTax,
      this.roundingAdjustment,
      this.nettAmount,
      this.nettAmountText,
      this.collectionLocation,
      this.centralisedLocation,
      this.centralisedSublocation,
      this.startAt,
      this.endAt,
      this.billMask,
      this.billNumber,
      this.calculations,
      this.creatorId,
      this.validationErrors,
      this.remarks,
      this.payerId,
      this.customerId,
      this.oldCustomerId,
      this.amountWasChanged,
      this.customerCharge,
      this.cancellationCategory,
      this.cancellationReason,
      this.queryRemarks,
      this.status,
      this.source,
      this.createdAt,
      this.updatedAt,
      this.service,
      this.agency,
      this.customer});

  Billss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stagingPaymentId = json['staging_payment_id'];
    serviceId = json['service_id'];
    billTypeId = json['bill_type_id'];
    ministryId = json['ministry_id'];
    makerControllingOfficerId = json['maker_controlling_officer_id'];
    makerPtjGroupId = json['maker_ptj_group_id'];
    makerPtjId = json['maker_ptj_id'];
    makerAccountingOfficeId = json['maker_accounting_office_id'];
    chargedControllingOfficerId = json['charged_controlling_officer_id'];
    chargedPtjGroupId = json['charged_ptj_group_id'];
    chargedPtjId = json['charged_ptj_id'];
    departmentId = json['department_id'];
    agencyId = json['agency_id'];
    productId = json['product_id'];
    subproductId = json['subproduct_id'];
    billType = json['bill_type'] != null
        ? new BillType.fromJson(json['bill_type'])
        : null;
    processCode = json['process_code'];
    referenceNumber = json['reference_number'];
    detail = json['detail'];
    entityCode = json['entity_code'];
    identityCode = json['identity_code'];
    name1 = json['name_1'];
    name2 = json['name_2'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    address3 = json['address_3'];
    postcode = json['postcode'];
    city = json['city'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    telephone = json['telephone'];
    fax = json['fax'];
    email = json['email'];
    description = json['description'];
    actualAmount = json['actual_amount'];
    paidAmount = json['paid_amount'];
    changedAmout = json['changed_amout'];
    amountWithoutTax = json['amount_without_tax'];
    discountType = json['discount_type'];
    discountAmount = json['discount_amount'];
    amountWithDiscount = json['amount_with_discount'];
    taxAmount = json['tax_amount'];
    amountWithTax = json['amount_with_tax'];
    roundingAdjustment = json['rounding_adjustment'];
    nettAmount = json['nett_amount'];
    nettAmountText = json['nett_amount_text'];
    collectionLocation = json['collection_location'];
    centralisedLocation = json['centralised_location'];
    centralisedSublocation = json['centralised_sublocation'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    billMask = json['bill_mask'];
    billNumber = json['bill_number'];
    calculations = json['calculations'];
    creatorId = json['creator_id'];
    if (json['validation_errors'] != null) {
      validationErrors = <Null>[];
      json['validation_errors'].forEach((v) {
        // validationErrors!.add(new Null.fromJson(v));
      });
    }
    remarks = json['remarks'];
    payerId = json['payer_id'];
    customerId = json['customer_id'];
    oldCustomerId = json['old_customer_id'];
    amountWasChanged = json['amount_was_changed'];
    customerCharge = json['customer_charge'];
    cancellationCategory = json['cancellation_category'];
    cancellationReason = json['cancellation_reason'];
    queryRemarks = json['query_remarks'];
    status = json['status'];
    source = json['source'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    agency =
        json['agency'] != null ? new Agency.fromJson(json['agency']) : null;
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staging_payment_id'] = this.stagingPaymentId;
    data['service_id'] = this.serviceId;
    data['bill_type_id'] = this.billTypeId;
    data['ministry_id'] = this.ministryId;
    data['maker_controlling_officer_id'] = this.makerControllingOfficerId;
    data['maker_ptj_group_id'] = this.makerPtjGroupId;
    data['maker_ptj_id'] = this.makerPtjId;
    data['maker_accounting_office_id'] = this.makerAccountingOfficeId;
    data['charged_controlling_officer_id'] = this.chargedControllingOfficerId;
    data['charged_ptj_group_id'] = this.chargedPtjGroupId;
    data['charged_ptj_id'] = this.chargedPtjId;
    data['department_id'] = this.departmentId;
    data['agency_id'] = this.agencyId;
    data['product_id'] = this.productId;
    data['subproduct_id'] = this.subproductId;
    if (this.billType != null) {
      data['bill_type'] = this.billType!.toJson();
    }
    data['process_code'] = this.processCode;
    data['reference_number'] = this.referenceNumber;
    data['detail'] = this.detail;
    data['entity_code'] = this.entityCode;
    data['identity_code'] = this.identityCode;
    data['name_1'] = this.name1;
    data['name_2'] = this.name2;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['address_3'] = this.address3;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['telephone'] = this.telephone;
    data['fax'] = this.fax;
    data['email'] = this.email;
    data['description'] = this.description;
    data['actual_amount'] = this.actualAmount;
    data['paid_amount'] = this.paidAmount;
    data['changed_amout'] = this.changedAmout;
    data['amount_without_tax'] = this.amountWithoutTax;
    data['discount_type'] = this.discountType;
    data['discount_amount'] = this.discountAmount;
    data['amount_with_discount'] = this.amountWithDiscount;
    data['tax_amount'] = this.taxAmount;
    data['amount_with_tax'] = this.amountWithTax;
    data['rounding_adjustment'] = this.roundingAdjustment;
    data['nett_amount'] = this.nettAmount;
    data['nett_amount_text'] = this.nettAmountText;
    data['collection_location'] = this.collectionLocation;
    data['centralised_location'] = this.centralisedLocation;
    data['centralised_sublocation'] = this.centralisedSublocation;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['bill_mask'] = this.billMask;
    data['bill_number'] = this.billNumber;
    data['calculations'] = this.calculations;
    data['creator_id'] = this.creatorId;
    if (this.validationErrors != null) {
      // data['validation_errors'] =
      // this.validationErrors!.map((v) => v.toJson()).toList();
    }
    data['remarks'] = this.remarks;
    data['payer_id'] = this.payerId;
    data['customer_id'] = this.customerId;
    data['old_customer_id'] = this.oldCustomerId;
    data['amount_was_changed'] = this.amountWasChanged;
    data['customer_charge'] = this.customerCharge;
    data['cancellation_category'] = this.cancellationCategory;
    data['cancellation_reason'] = this.cancellationReason;
    data['query_remarks'] = this.queryRemarks;
    data['status'] = this.status;
    data['source'] = this.source;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.agency != null) {
      data['agency'] = this.agency!.toJson();
    }
    data['customer'] = this.customer;
    return data;
  }
}

class BillTypes {
  int? id;
  String? type;

  BillTypes({this.id, this.type});

  BillTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    return data;
  }
}

class Servicess {
  int? id;
  int? menuId;
  String? name;
  String? serviceReferenceNumber;
  String? cbyChargelines;
  String? receiptType;
  String? serviceChargeData;
  String? taxData;
  String? discountData;
  String? chargelineData;
  String? chargedTo;
  String? status;
  String? submittedAt;
  String? approvalBaAt;
  Menuss? menu;
  bool? withMatrix;

  Servicess(
      {this.id,
      this.menuId,
      this.name,
      this.serviceReferenceNumber,
      this.cbyChargelines,
      this.receiptType,
      this.serviceChargeData,
      this.taxData,
      this.discountData,
      this.chargelineData,
      this.chargedTo,
      this.status,
      this.submittedAt,
      this.approvalBaAt,
      this.menu,
      this.withMatrix});

  Servicess.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    name = json['name'];
    serviceReferenceNumber = json['service_reference_number'];
    cbyChargelines = json['cby_chargelines'];
    receiptType = json['receipt_type'];
    serviceChargeData = json['service_charge_data'];
    taxData = json['tax_data'];
    discountData = json['discount_data'];
    chargelineData = json['chargeline_data'];
    chargedTo = json['charged_to'];
    status = json['status'];
    submittedAt = json['submitted_at'];
    approvalBaAt = json['approval_ba_at'];
    menu = json['menu'] != null ? new Menuss.fromJson(json['menu']) : null;
    withMatrix = json['with_matrix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    data['name'] = this.name;
    data['service_reference_number'] = this.serviceReferenceNumber;
    data['cby_chargelines'] = this.cbyChargelines;
    data['receipt_type'] = this.receiptType;
    data['service_charge_data'] = this.serviceChargeData;
    data['tax_data'] = this.taxData;
    data['discount_data'] = this.discountData;
    data['chargeline_data'] = this.chargelineData;
    data['charged_to'] = this.chargedTo;
    data['status'] = this.status;
    data['submitted_at'] = this.submittedAt;
    data['approval_ba_at'] = this.approvalBaAt;
    if (this.menu != null) {
      data['menu'] = this.menu!.toJson();
    }
    data['with_matrix'] = this.withMatrix;
    return data;
  }
}

class Menuss {
  int? id;
  String? name;

  Menuss({this.id, this.name});

  Menuss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Agencys {
  int? id;
  String? name;
  String? code;
  String? profile;
  String? address;

  Agencys({this.id, this.name, this.code, this.profile, this.address});

  Agencys.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    profile = json['profile'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['profile'] = this.profile;
    data['address'] = this.address;
    return data;
  }
}

class FavBills {
  int? id;
  int? userId;
  Null serviceId;
  int? billId;
  String? createdAt;
  String? updatedAt;
  Bills? payment;

  FavBills(
      {this.id,
      this.userId,
      this.serviceId,
      this.billId,
      this.createdAt,
      this.updatedAt,
      this.payment});

  FavBills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    billId = json['bill_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    payment =
        json['payment'] != null ? new Bills.fromJson(json['payment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['service_id'] = this.serviceId;
    data['bill_id'] = this.billId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    return data;
  }
}

class Paymentss {
  int? id;
  Null billTypeId;
  Null serviceId;
  int? ministryId;
  int? departmentId;
  Null agencyId;
  int? creatorId;
  int? makerPtjId;
  Null locationId;
  Null sublocationId;
  Null userIdentityTypeId;
  int? countryId;
  int? stateId;
  int? cityId;
  int? districtId;
  String? identityCodeCategory;
  Null identityCode;
  Null previousIdentityCode;
  Null customerName;
  Null customerReferenceNumber;
  String? address;
  String? postcode;
  String? stateName;
  String? cityName;
  String? districtName;
  String? telephone;
  String? email;
  String? detail;
  String? referenceNumber;
  Null recordSeqNumber;
  Null documentSeqNumber;
  Null documentNoSap;
  Null documentNoOriginal;
  Null documentYear;
  Null invoiceNumber;
  Null invoiceNumberSap;
  Null invoiceYear;
  String? billDate;
  Null postingDate;
  String? startAt;
  String? endAt;
  String? customerNote;
  String? source;
  Null stagingBatchId;
  Null stagingBatchContentId;
  int? processCode;
  String? dataStatus;
  String? status;
  int? firstApproverId;
  Null secondApproverId;
  String? firstApprovalAt;
  Null secondApprovalAt;
  String? taskAt;
  Null queryRemarks;
  Null billNumber;
  Null billMask;
  Null makerName;
  Null makerPosition;
  Null documentDatePrepared;
  Null approverName;
  Null approverPosition;
  Null approvalDate;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  NettCalculations? nettCalculations;
  Service? service;
  Agency? agency;
  Null customer;
  Null billType;
  String amount = "";
  Paymentss(
      {this.id,
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
      this.recordSeqNumber,
      this.documentSeqNumber,
      this.documentNoSap,
      this.documentNoOriginal,
      this.documentYear,
      this.invoiceNumber,
      this.invoiceNumberSap,
      this.invoiceYear,
      this.billDate,
      this.postingDate,
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
      this.makerName,
      this.makerPosition,
      this.documentDatePrepared,
      this.approverName,
      this.approverPosition,
      this.approvalDate,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.nettCalculations,
      this.service,
      this.agency,
      this.customer,
      this.billType});

  Paymentss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billTypeId = json['bill_type_id'];
    serviceId = json['service_id'];
    ministryId = json['ministry_id'];
    departmentId = json['department_id'];
    agencyId = json['agency_id'];
    creatorId = json['creator_id'];
    makerPtjId = json['maker_ptj_id'];
    locationId = json['location_id'];
    sublocationId = json['sublocation_id'];
    userIdentityTypeId = json['user_identity_type_id'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    districtId = json['district_id'];
    identityCodeCategory = json['identity_code_category'];
    identityCode = json['identity_code'];
    previousIdentityCode = json['previous_identity_code'];
    customerName = json['customer_name'];
    customerReferenceNumber = json['customer_reference_number'];
    address = json['address'];
    postcode = json['postcode'];
    stateName = json['state_name'];
    cityName = json['city_name'];
    districtName = json['district_name'];
    telephone = json['telephone'];
    email = json['email'];
    detail = json['detail'];
    referenceNumber = json['reference_number'];
    recordSeqNumber = json['record_seq_number'];
    documentSeqNumber = json['document_seq_number'];
    documentNoSap = json['document_no_sap'];
    documentNoOriginal = json['document_no_original'];
    documentYear = json['document_year'];
    invoiceNumber = json['invoice_number'];
    invoiceNumberSap = json['invoice_number_sap'];
    invoiceYear = json['invoice_year'];
    billDate = json['bill_date'];
    postingDate = json['posting_date'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    customerNote = json['customer_note'];
    source = json['source'];
    stagingBatchId = json['staging_batch_id'];
    stagingBatchContentId = json['staging_batch_content_id'];
    processCode = json['process_code'];
    dataStatus = json['data_status'];
    status = json['status'];
    if (json['first_approver_id'] != null) {
      firstApproverId = json['first_approver_id'];
    }
    secondApproverId = json['second_approver_id'];
    if (json['first_approval_at'] != null) {
      firstApprovalAt = json['first_approval_at'];
    }
    secondApprovalAt = json['second_approval_at'];
    if (json['task_at'] != null) {
      taskAt = json['task_at'];
    }
    queryRemarks = json['query_remarks'];
    billNumber = json['bill_number'];
    billMask = json['bill_mask'];
    makerName = json['maker_name'];
    makerPosition = json['maker_position'];
    documentDatePrepared = json['document_date_prepared'];
    approverName = json['approver_name'];
    approverPosition = json['approver_position'];
    approvalDate = json['approval_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    nettCalculations = json['nett_calculations'] != null
        ? new NettCalculations.fromJson(json['nett_calculations'])
        : null;
    service = json['service'];
    agency = json['agency'];
    customer = json['customer'];
    billType = json['bill_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bill_type_id'] = this.billTypeId;
    data['service_id'] = this.serviceId;
    data['ministry_id'] = this.ministryId;
    data['department_id'] = this.departmentId;
    data['agency_id'] = this.agencyId;
    data['creator_id'] = this.creatorId;
    data['maker_ptj_id'] = this.makerPtjId;
    data['location_id'] = this.locationId;
    data['sublocation_id'] = this.sublocationId;
    data['user_identity_type_id'] = this.userIdentityTypeId;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['district_id'] = this.districtId;
    data['identity_code_category'] = this.identityCodeCategory;
    data['identity_code'] = this.identityCode;
    data['previous_identity_code'] = this.previousIdentityCode;
    data['customer_name'] = this.customerName;
    data['customer_reference_number'] = this.customerReferenceNumber;
    data['address'] = this.address;
    data['postcode'] = this.postcode;
    data['state_name'] = this.stateName;
    data['city_name'] = this.cityName;
    data['district_name'] = this.districtName;
    data['telephone'] = this.telephone;
    data['email'] = this.email;
    data['detail'] = this.detail;
    data['reference_number'] = this.referenceNumber;
    data['record_seq_number'] = this.recordSeqNumber;
    data['document_seq_number'] = this.documentSeqNumber;
    data['document_no_sap'] = this.documentNoSap;
    data['document_no_original'] = this.documentNoOriginal;
    data['document_year'] = this.documentYear;
    data['invoice_number'] = this.invoiceNumber;
    data['invoice_number_sap'] = this.invoiceNumberSap;
    data['invoice_year'] = this.invoiceYear;
    data['bill_date'] = this.billDate;
    data['posting_date'] = this.postingDate;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['customer_note'] = this.customerNote;
    data['source'] = this.source;
    data['staging_batch_id'] = this.stagingBatchId;
    data['staging_batch_content_id'] = this.stagingBatchContentId;
    data['process_code'] = this.processCode;
    data['data_status'] = this.dataStatus;
    data['status'] = this.status;
    data['first_approver_id'] = this.firstApproverId;
    data['second_approver_id'] = this.secondApproverId;
    data['first_approval_at'] = this.firstApprovalAt;
    data['second_approval_at'] = this.secondApprovalAt;
    data['task_at'] = this.taskAt;
    data['query_remarks'] = this.queryRemarks;
    data['bill_number'] = this.billNumber;
    data['bill_mask'] = this.billMask;
    data['maker_name'] = this.makerName;
    data['maker_position'] = this.makerPosition;
    data['document_date_prepared'] = this.documentDatePrepared;
    data['approver_name'] = this.approverName;
    data['approver_position'] = this.approverPosition;
    data['approval_date'] = this.approvalDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.nettCalculations != null) {
      data['nett_calculations'] = this.nettCalculations!.toJson();
    }
    data['service'] = this.service;
    data['agency'] = this.agency;
    data['customer'] = this.customer;
    data['bill_type'] = this.billType;
    return data;
  }
}

class Billsss {
  int? id;
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
  Null productId;
  Null subproductId;
  BillType? billType;
  String? processCode;
  String? referenceNumber;
  String? detail;
  Null entityCode;
  String? identityCode;
  String? name1;
  String? name2;
  String? address1;
  String? address2;
  Null address3;
  String? postcode;
  String? city;
  String? district;
  String? state;
  String? country;
  String? telephone;
  Null fax;
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
  String? nettAmount;
  String? nettAmountText;
  String? collectionLocation;
  String? centralisedLocation;
  String? centralisedSublocation;
  String? startAt;
  String? endAt;
  String? billMask;
  String? billNumber;
  String? calculations;
  int? creatorId;
  List<Null>? validationErrors;
  Null remarks;
  Null payerId;
  Null customerId;
  Null oldCustomerId;
  int? amountWasChanged;
  int? customerCharge;
  String? cancellationCategory;
  String? cancellationReason;
  String? queryRemarks;
  String? status;
  String? source;
  String? createdAt;
  String? updatedAt;
  Service? service;
  Agency? agency;
  Null customer;

  Billsss(
      {this.id,
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
      this.actualAmount,
      this.paidAmount,
      this.changedAmout,
      this.amountWithoutTax,
      this.discountType,
      this.discountAmount,
      this.amountWithDiscount,
      this.taxAmount,
      this.amountWithTax,
      this.roundingAdjustment,
      this.nettAmount,
      this.nettAmountText,
      this.collectionLocation,
      this.centralisedLocation,
      this.centralisedSublocation,
      this.startAt,
      this.endAt,
      this.billMask,
      this.billNumber,
      this.calculations,
      this.creatorId,
      this.validationErrors,
      this.remarks,
      this.payerId,
      this.customerId,
      this.oldCustomerId,
      this.amountWasChanged,
      this.customerCharge,
      this.cancellationCategory,
      this.cancellationReason,
      this.queryRemarks,
      this.status,
      this.source,
      this.createdAt,
      this.updatedAt,
      this.service,
      this.agency,
      this.customer});

  Billsss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stagingPaymentId = json['staging_payment_id'];
    serviceId = json['service_id'];
    billTypeId = json['bill_type_id'];
    ministryId = json['ministry_id'];
    makerControllingOfficerId = json['maker_controlling_officer_id'];
    makerPtjGroupId = json['maker_ptj_group_id'];
    makerPtjId = json['maker_ptj_id'];
    makerAccountingOfficeId = json['maker_accounting_office_id'];
    chargedControllingOfficerId = json['charged_controlling_officer_id'];
    chargedPtjGroupId = json['charged_ptj_group_id'];
    chargedPtjId = json['charged_ptj_id'];
    departmentId = json['department_id'];
    agencyId = json['agency_id'];
    productId = json['product_id'];
    subproductId = json['subproduct_id'];
    billType = json['bill_type'] != null
        ? new BillType.fromJson(json['bill_type'])
        : null;
    processCode = json['process_code'];
    referenceNumber = json['reference_number'];
    detail = json['detail'];
    entityCode = json['entity_code'];
    identityCode = json['identity_code'];
    name1 = json['name_1'];
    name2 = json['name_2'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    address3 = json['address_3'];
    postcode = json['postcode'];
    city = json['city'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    telephone = json['telephone'];
    fax = json['fax'];
    email = json['email'];
    description = json['description'];
    actualAmount = json['actual_amount'];
    paidAmount = json['paid_amount'];
    changedAmout = json['changed_amout'];
    amountWithoutTax = json['amount_without_tax'];
    discountType = json['discount_type'];
    discountAmount = json['discount_amount'];
    amountWithDiscount = json['amount_with_discount'];
    taxAmount = json['tax_amount'];
    amountWithTax = json['amount_with_tax'];
    roundingAdjustment = json['rounding_adjustment'];
    nettAmount = json['nett_amount'];
    nettAmountText = json['nett_amount_text'];
    collectionLocation = json['collection_location'];
    centralisedLocation = json['centralised_location'];
    centralisedSublocation = json['centralised_sublocation'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    billMask = json['bill_mask'];
    billNumber = json['bill_number'];
    calculations = json['calculations'];
    creatorId = json['creator_id'];
    if (json['validation_errors'] != null) {
      validationErrors = <Null>[];
      json['validation_errors'].forEach((v) {
        // validationErrors!.add(new Null.fromJson(v));
      });
    }
    remarks = json['remarks'];
    payerId = json['payer_id'];
    customerId = json['customer_id'];
    oldCustomerId = json['old_customer_id'];
    amountWasChanged = json['amount_was_changed'];
    customerCharge = json['customer_charge'];
    cancellationCategory = json['cancellation_category'];
    cancellationReason = json['cancellation_reason'];
    queryRemarks = json['query_remarks'];
    status = json['status'];
    source = json['source'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    agency =
        json['agency'] != null ? new Agency.fromJson(json['agency']) : null;
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staging_payment_id'] = this.stagingPaymentId;
    data['service_id'] = this.serviceId;
    data['bill_type_id'] = this.billTypeId;
    data['ministry_id'] = this.ministryId;
    data['maker_controlling_officer_id'] = this.makerControllingOfficerId;
    data['maker_ptj_group_id'] = this.makerPtjGroupId;
    data['maker_ptj_id'] = this.makerPtjId;
    data['maker_accounting_office_id'] = this.makerAccountingOfficeId;
    data['charged_controlling_officer_id'] = this.chargedControllingOfficerId;
    data['charged_ptj_group_id'] = this.chargedPtjGroupId;
    data['charged_ptj_id'] = this.chargedPtjId;
    data['department_id'] = this.departmentId;
    data['agency_id'] = this.agencyId;
    data['product_id'] = this.productId;
    data['subproduct_id'] = this.subproductId;
    if (this.billType != null) {
      data['bill_type'] = this.billType!.toJson();
    }
    data['process_code'] = this.processCode;
    data['reference_number'] = this.referenceNumber;
    data['detail'] = this.detail;
    data['entity_code'] = this.entityCode;
    data['identity_code'] = this.identityCode;
    data['name_1'] = this.name1;
    data['name_2'] = this.name2;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['address_3'] = this.address3;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['telephone'] = this.telephone;
    data['fax'] = this.fax;
    data['email'] = this.email;
    data['description'] = this.description;
    data['actual_amount'] = this.actualAmount;
    data['paid_amount'] = this.paidAmount;
    data['changed_amout'] = this.changedAmout;
    data['amount_without_tax'] = this.amountWithoutTax;
    data['discount_type'] = this.discountType;
    data['discount_amount'] = this.discountAmount;
    data['amount_with_discount'] = this.amountWithDiscount;
    data['tax_amount'] = this.taxAmount;
    data['amount_with_tax'] = this.amountWithTax;
    data['rounding_adjustment'] = this.roundingAdjustment;
    data['nett_amount'] = this.nettAmount;
    data['nett_amount_text'] = this.nettAmountText;
    data['collection_location'] = this.collectionLocation;
    data['centralised_location'] = this.centralisedLocation;
    data['centralised_sublocation'] = this.centralisedSublocation;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['bill_mask'] = this.billMask;
    data['bill_number'] = this.billNumber;
    data['calculations'] = this.calculations;
    data['creator_id'] = this.creatorId;
    if (this.validationErrors != null) {
      // data['validation_errors'] =
      //     this.validationErrors!.map((v) => v.toJson()).toList();
    }
    data['remarks'] = this.remarks;
    data['payer_id'] = this.payerId;
    data['customer_id'] = this.customerId;
    data['old_customer_id'] = this.oldCustomerId;
    data['amount_was_changed'] = this.amountWasChanged;
    data['customer_charge'] = this.customerCharge;
    data['cancellation_category'] = this.cancellationCategory;
    data['cancellation_reason'] = this.cancellationReason;
    data['query_remarks'] = this.queryRemarks;
    data['status'] = this.status;
    data['source'] = this.source;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.agency != null) {
      data['agency'] = this.agency!.toJson();
    }
    data['customer'] = this.customer;
    return data;
  }
}

class Rounding {
  Setting? setting;
  num? value;

  Rounding({this.setting, this.value});

  Rounding.fromJson(Map<String, dynamic> json) {
    setting =
        json['setting'] != null ? new Setting.fromJson(json['setting']) : null;
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.setting != null) {
      data['setting'] = this.setting!.toJson();
    }
    data['value'] = this.value;
    return data;
  }
}

class Setting {
  int? id;
  int? roundingValue;
  int? roundDownValue;
  int? isFund;
  int? fundVoteId;
  int? accountCodeId;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  AccountCode? accountCode;
  FundVote? fundVote;

  Setting(
      {this.id,
      this.roundingValue,
      this.roundDownValue,
      this.isFund,
      this.fundVoteId,
      this.accountCodeId,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.accountCode,
      this.fundVote});

  Setting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roundingValue = json['rounding_value'];
    roundDownValue = json['round_down_value'];
    isFund = json['is_fund'];
    fundVoteId = json['fund_vote_id'];
    accountCodeId = json['account_code_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    accountCode = json['account_code'] != null
        ? new AccountCode.fromJson(json['account_code'])
        : null;
    fundVote = json['fund_vote'] != null
        ? new FundVote.fromJson(json['fund_vote'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rounding_value'] = this.roundingValue;
    data['round_down_value'] = this.roundDownValue;
    data['is_fund'] = this.isFund;
    data['fund_vote_id'] = this.fundVoteId;
    data['account_code_id'] = this.accountCodeId;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.accountCode != null) {
      data['account_code'] = this.accountCode!.toJson();
    }
    data['fund_vote'] = this.fundVote;
    return data;
  }
}

class Incomplete {
  int? id;
  // ignore: unnecessary_question_mark
  Null transferDetailId;
  int? gatewayId;
  int? rmaId;
  int? userId;
  String? referenceNumber;
  String? transactionReference;
  String? amount;
  String? paymentMethod;
  String? paymentResponse;
  int? count;
  String? source;
  String? customerName;
  String? customerEmail;
  String? customerPhoneNo;
  String? status;
  String? flag;
  String? transactionFee;
  int? settlement;
  String? settledAt;
  String? createdAt;
  String? updatedAt;
  List<ItemsIncomplete>? items;
  Customer? user;

  Incomplete(
      {this.id,
      this.transferDetailId,
      this.gatewayId,
      this.rmaId,
      this.userId,
      this.referenceNumber,
      this.transactionReference,
      this.amount,
      this.paymentMethod,
      this.paymentResponse,
      this.count,
      this.source,
      this.customerName,
      this.customerEmail,
      this.customerPhoneNo,
      this.status,
      this.flag,
      this.transactionFee,
      this.settlement,
      this.settledAt,
      this.createdAt,
      this.updatedAt,
      this.items,
      this.user});

  Incomplete.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transferDetailId = json['transfer_detail_id'];
    gatewayId = json['gateway_id'];
    rmaId = json['rma_id'];
    userId = json['user_id'];
    referenceNumber = json['reference_number'];
    transactionReference = json['transaction_reference'];
    amount = json['amount'];
    paymentMethod = json['payment_method'];
    paymentResponse = json['payment_response'];
    count = json['count'];
    source = json['source'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerPhoneNo = json['customer_phone_no'];
    status = json['status'];
    flag = json['flag'];
    transactionFee = json['transaction_fee'];
    settlement = json['settlement'];
    settledAt = json['settled_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = <ItemsIncomplete>[];
      json['items'].forEach((v) {
        items!.add(new ItemsIncomplete.fromJson(v));
      });
    }
    user = json['user'] != null ? new Customer.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transfer_detail_id'] = this.transferDetailId;
    data['gateway_id'] = this.gatewayId;
    data['rma_id'] = this.rmaId;
    data['user_id'] = this.userId;
    data['reference_number'] = this.referenceNumber;
    data['transaction_reference'] = this.transactionReference;
    data['amount'] = this.amount;
    data['payment_method'] = this.paymentMethod;
    data['payment_response'] = this.paymentResponse;
    data['count'] = this.count;
    data['source'] = this.source;
    data['customer_name'] = this.customerName;
    data['customer_email'] = this.customerEmail;
    data['customer_phone_no'] = this.customerPhoneNo;
    data['status'] = this.status;
    data['flag'] = this.flag;
    data['transaction_fee'] = this.transactionFee;
    data['settlement'] = this.settlement;
    data['settled_at'] = this.settledAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class ItemsIncomplete {
  int? id;
  int? transactionId;
  int? billId;
  int? customerId;
  int? accountingOfficeId;
  String? receiptNumber;
  String? receiptDate;
  int? receiptDownloadCount;
  String? originalReceiptUrl;
  String? copyReceiptUrl;
  String? cancellationReceiptUrl;
  String? paymentDescription;
  int? serviceId;
  int? ministryId;
  int? departmentId;
  int? agencyId;
  int? ptjId;
  // ignore: unnecessary_question_mark
  Null preparerPtjId;
  String? amount;
  List<dynamic>? items;
  List? extraFields;
  // ignore: unnecessary_question_mark
  Null transferDetailId;
  String? status;
  String? createdAt;
  String? updatedAt;
  Bills? bill;
  ServiceIncompletes? service;
  CustomerIncomplete? customer;

  ItemsIncomplete(
      {this.id,
      this.transactionId,
      this.billId,
      this.customerId,
      this.accountingOfficeId,
      this.receiptNumber,
      this.receiptDate,
      this.receiptDownloadCount,
      this.originalReceiptUrl,
      this.copyReceiptUrl,
      this.cancellationReceiptUrl,
      this.paymentDescription,
      this.serviceId,
      this.ministryId,
      this.departmentId,
      this.agencyId,
      this.ptjId,
      this.preparerPtjId,
      this.amount,
      this.items,
      this.extraFields,
      this.transferDetailId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.bill,
      this.service,
      this.customer});

  ItemsIncomplete.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    billId = json['bill_id'];
    customerId = json['customer_id'];
    accountingOfficeId = json['accounting_office_id'];
    receiptNumber = json['receipt_number'];
    receiptDate = json['receipt_date'];
    receiptDownloadCount = json['receipt_download_count'];
    originalReceiptUrl = json['original_receipt_url'];
    copyReceiptUrl = json['copy_receipt_url'];
    cancellationReceiptUrl = json['cancellation_receipt_url'];
    paymentDescription = json['payment_description'];
    serviceId = json['service_id'];
    ministryId = json['ministry_id'];
    departmentId = json['department_id'];
    agencyId = json['agency_id'];
    ptjId = json['ptj_id'];
    preparerPtjId = json['preparer_ptj_id'];
    amount = json['amount'];
    items = json['items'] != null ? (json['items'] as List) : [];
    // ignore: unnecessary_statements
    json['extra_fields'] != null ? [] : [];
    transferDetailId = json['transfer_detail_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bill = json['bill'] != null ? new Bills.fromJson(json['bill']) : null;
    service = json['service'] != null
        ? ServiceIncompletes.fromJson(json['service'])
        : null;
    customer = json['customer'] != null
        ? new CustomerIncomplete.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_id'] = this.transactionId;
    data['bill_id'] = this.billId;
    data['customer_id'] = this.customerId;
    data['accounting_office_id'] = this.accountingOfficeId;
    data['receipt_number'] = this.receiptNumber;
    data['receipt_date'] = this.receiptDate;
    data['receipt_download_count'] = this.receiptDownloadCount;
    data['original_receipt_url'] = this.originalReceiptUrl;
    data['copy_receipt_url'] = this.copyReceiptUrl;
    data['cancellation_receipt_url'] = this.cancellationReceiptUrl;
    data['payment_description'] = this.paymentDescription;
    data['service_id'] = this.serviceId;
    data['ministry_id'] = this.ministryId;
    data['department_id'] = this.departmentId;
    data['agency_id'] = this.agencyId;
    data['ptj_id'] = this.ptjId;
    data['preparer_ptj_id'] = this.preparerPtjId;
    data['amount'] = this.amount;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v).toList();
    }
    if (this.extraFields != null) {
      data['extra_fields'] = this.extraFields!.map((v) => v.toJson()).toList();
    }
    data['transfer_detail_id'] = this.transferDetailId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.bill != null) {
      data['bill'] = this.bill!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class BillIncomplete {
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
  // ignore: unnecessary_question_mark
  int? stateId;
  // ignore: unnecessary_question_mark
  int? cityId;
  // ignore: unnecessary_question_mark
  int? districtId;
  String? identityCodeCategory;
  String? identityCode;
  // ignore: unnecessary_question_mark
  Null previousIdentityCode;
  String? customerName;
  String? customerReferenceNumber;
  // ignore: unnecessary_question_mark
  String? customerIdentityType;
  String? address;
  String? postcode;
  String? stateName;
  String? cityName;
  String? districtName;
  String? telephone;
  String? email;
  String? detail;
  String? referenceNumber;
  // ignore: unnecessary_question_mark
  String? agencyReferenceNumber2;
  // ignore: unnecessary_question_mark
  String? agencyReason;
  // ignore: unnecessary_question_mark
  String? recordSeqNumber;
  // ignore: unnecessary_question_mark
  String? documentSeqNumber;
  // ignore: unnecessary_question_mark
  String? documentNoSap;
  // ignore: unnecessary_question_mark
  String? documentNoOriginal;
  // ignore: unnecessary_question_mark
  String? documentYear;
  // ignore: unnecessary_question_mark
  String? invoiceNumber;
  // ignore: unnecessary_question_mark
  String? invoiceNumberSap;
  // ignore: unnecessary_question_mark
  String? invoiceYear;
  String? billDate;
  // ignore: unnecessary_question_mark
  String? documentDate;
  // ignore: unnecessary_question_mark
  String? postingDate;
  String? startAt;
  String? endAt;
  // ignore: unnecessary_question_mark
  String? startPaymentDate;
  // ignore: unnecessary_question_mark
  String? endPaymentDate;
  String? customerNote;
  String? source;
  int? stagingBatchId;
  int? stagingBatchContentId;
  int? processCode;
  String? dataStatus;
  String? status;
  int? firstApproverId;
  int? secondApproverId;
  String? firstApprovalAt;
  String? secondApprovalAt;
  String? taskAt;
  String? queryRemarks;
  String? billNumber;
  String? billMask;
  String? makerName;
  String? makerPosition;
  String? documentDatePrepared;
  String? approverName;
  String? approverPosition;
  String? approvalDate;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  NettCalculations? nettCalculations;
  bool? favorite;
  List<Chargelines>? chargelines;
  List<Null>? amountChanges;
  Service? service;
  Agency? agency;
  Customer? customer;
  BillType? billType;

  BillIncomplete(
      {this.id,
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
      this.customerIdentityType,
      this.address,
      this.postcode,
      this.stateName,
      this.cityName,
      this.districtName,
      this.telephone,
      this.email,
      this.detail,
      this.referenceNumber,
      this.agencyReferenceNumber2,
      this.agencyReason,
      this.recordSeqNumber,
      this.documentSeqNumber,
      this.documentNoSap,
      this.documentNoOriginal,
      this.documentYear,
      this.invoiceNumber,
      this.invoiceNumberSap,
      this.invoiceYear,
      this.billDate,
      this.documentDate,
      this.postingDate,
      this.startAt,
      this.endAt,
      this.startPaymentDate,
      this.endPaymentDate,
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
      this.makerName,
      this.makerPosition,
      this.documentDatePrepared,
      this.approverName,
      this.approverPosition,
      this.approvalDate,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.nettCalculations,
      this.favorite,
      this.chargelines,
      this.amountChanges,
      this.service,
      this.agency,
      this.customer,
      this.billType});

  BillIncomplete.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billTypeId = json['bill_type_id'];
    serviceId = json['service_id'];
    ministryId = json['ministry_id'];
    departmentId = json['department_id'];
    agencyId = json['agency_id'];
    creatorId = json['creator_id'];
    makerPtjId = json['maker_ptj_id'];
    locationId = json['location_id'];
    sublocationId = json['sublocation_id'];
    userIdentityTypeId = json['user_identity_type_id'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    districtId = json['district_id'];
    identityCodeCategory = json['identity_code_category'];
    identityCode = json['identity_code'];
    previousIdentityCode = json['previous_identity_code'];
    customerName = json['customer_name'];
    customerReferenceNumber = json['customer_reference_number'];
    customerIdentityType = json['customer_identity_type'];
    address = json['address'];
    postcode = json['postcode'];
    stateName = json['state_name'];
    cityName = json['city_name'];
    districtName = json['district_name'];
    telephone = json['telephone'];
    email = json['email'];
    detail = json['detail'];
    referenceNumber = json['reference_number'];
    agencyReferenceNumber2 = json['agency_reference_number2'];
    agencyReason = json['agency_reason'];
    recordSeqNumber = json['record_seq_number'];
    documentSeqNumber = json['document_seq_number'];
    documentNoSap = json['document_no_sap'];
    documentNoOriginal = json['document_no_original'];
    documentYear = json['document_year'];
    invoiceNumber = json['invoice_number'];
    invoiceNumberSap = json['invoice_number_sap'];
    invoiceYear = json['invoice_year'];
    billDate = json['bill_date'];
    documentDate = json['document_date'];
    postingDate = json['posting_date'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    startPaymentDate = json['start_payment_date'];
    endPaymentDate = json['end_payment_date'];
    customerNote = json['customer_note'];
    source = json['source'];
    stagingBatchId = json['staging_batch_id'];
    stagingBatchContentId = json['staging_batch_content_id'];
    processCode = json['process_code'];
    dataStatus = json['data_status'];
    status = json['status'];
    firstApproverId = json['first_approver_id'];
    secondApproverId = json['second_approver_id'];
    firstApprovalAt = json['first_approval_at'];
    secondApprovalAt = json['second_approval_at'];
    taskAt = json['task_at'];
    queryRemarks = json['query_remarks'];
    billNumber = json['bill_number'];
    billMask = json['bill_mask'];
    makerName = json['maker_name'];
    makerPosition = json['maker_position'];
    documentDatePrepared = json['document_date_prepared'];
    approverName = json['approver_name'];
    approverPosition = json['approver_position'];
    approvalDate = json['approval_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    nettCalculations = json['nett_calculations'] != null
        ? new NettCalculations.fromJson(json['nett_calculations'])
        : null;
    favorite = json['favorite'];
    if (json['chargelines'] != null) {
      chargelines = <Chargelines>[];
      json['chargelines'].forEach((v) {
        chargelines!.add(new Chargelines.fromJson(v));
      });
    }
    if (json['amount_changes'] != null) {
      // amountChanges = <Null>[];
      // json['amount_changes'].forEach((v) {
      //   amountChanges!.add(new Null.fromJson(v));
      // });
    }
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    agency =
        json['agency'] != null ? new Agency.fromJson(json['agency']) : null;
    customer = json['customer'];
    billType = json['bill_type'] != null
        ? new BillType.fromJson(json['bill_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bill_type_id'] = this.billTypeId;
    data['service_id'] = this.serviceId;
    data['ministry_id'] = this.ministryId;
    data['department_id'] = this.departmentId;
    data['agency_id'] = this.agencyId;
    data['creator_id'] = this.creatorId;
    data['maker_ptj_id'] = this.makerPtjId;
    data['location_id'] = this.locationId;
    data['sublocation_id'] = this.sublocationId;
    data['user_identity_type_id'] = this.userIdentityTypeId;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['district_id'] = this.districtId;
    data['identity_code_category'] = this.identityCodeCategory;
    data['identity_code'] = this.identityCode;
    data['previous_identity_code'] = this.previousIdentityCode;
    data['customer_name'] = this.customerName;
    data['customer_reference_number'] = this.customerReferenceNumber;
    data['customer_identity_type'] = this.customerIdentityType;
    data['address'] = this.address;
    data['postcode'] = this.postcode;
    data['state_name'] = this.stateName;
    data['city_name'] = this.cityName;
    data['district_name'] = this.districtName;
    data['telephone'] = this.telephone;
    data['email'] = this.email;
    data['detail'] = this.detail;
    data['reference_number'] = this.referenceNumber;
    data['agency_reference_number2'] = this.agencyReferenceNumber2;
    data['agency_reason'] = this.agencyReason;
    data['record_seq_number'] = this.recordSeqNumber;
    data['document_seq_number'] = this.documentSeqNumber;
    data['document_no_sap'] = this.documentNoSap;
    data['document_no_original'] = this.documentNoOriginal;
    data['document_year'] = this.documentYear;
    data['invoice_number'] = this.invoiceNumber;
    data['invoice_number_sap'] = this.invoiceNumberSap;
    data['invoice_year'] = this.invoiceYear;
    data['bill_date'] = this.billDate;
    data['document_date'] = this.documentDate;
    data['posting_date'] = this.postingDate;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['start_payment_date'] = this.startPaymentDate;
    data['end_payment_date'] = this.endPaymentDate;
    data['customer_note'] = this.customerNote;
    data['source'] = this.source;
    data['staging_batch_id'] = this.stagingBatchId;
    data['staging_batch_content_id'] = this.stagingBatchContentId;
    data['process_code'] = this.processCode;
    data['data_status'] = this.dataStatus;
    data['status'] = this.status;
    data['first_approver_id'] = this.firstApproverId;
    data['second_approver_id'] = this.secondApproverId;
    data['first_approval_at'] = this.firstApprovalAt;
    data['second_approval_at'] = this.secondApprovalAt;
    data['task_at'] = this.taskAt;
    data['query_remarks'] = this.queryRemarks;
    data['bill_number'] = this.billNumber;
    data['bill_mask'] = this.billMask;
    data['maker_name'] = this.makerName;
    data['maker_position'] = this.makerPosition;
    data['document_date_prepared'] = this.documentDatePrepared;
    data['approver_name'] = this.approverName;
    data['approver_position'] = this.approverPosition;
    data['approval_date'] = this.approvalDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.nettCalculations != null) {
      data['nett_calculations'] = this.nettCalculations!.toJson();
    }
    data['favorite'] = this.favorite;
    if (this.chargelines != null) {
      data['chargelines'] = this.chargelines!.map((v) => v.toJson()).toList();
    }
    if (this.amountChanges != null) {
      // data['amount_changes'] =
      //     this.amountChanges!.map((v) => v.toJson()).toList();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.agency != null) {
      data['agency'] = this.agency!.toJson();
    }
    data['customer'] = this.customer;
    if (this.billType != null) {
      data['bill_type'] = this.billType!.toJson();
    }
    return data;
  }
}

class NettCalculationsIncomplete {
  // ignore: unnecessary_question_mark
  Null roundingData;
  List<Null>? changesItems;
  List<Null>? changesDraftItems;
  List<Null>? paymentItems;
  List<Null>? paymentDraftItems;
  int? rounding;
  int? original;
  int? changes;
  int? changesDraft;
  int? total;
  int? paid;
  int? paidDraft;
  int? due;
  String? dueInWords;

  NettCalculationsIncomplete(
      {this.roundingData,
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
      this.dueInWords});

  NettCalculationsIncomplete.fromJson(Map<String, dynamic> json) {
    roundingData = json['roundingData'];
    if (json['changes_items'] != null) {
      changesItems = <Null>[];
      json['changes_items'].forEach((v) {
        // changesItems!.add(new Null.fromJson(v));
      });
    }
    if (json['changes_draft_items'] != null) {
      changesDraftItems = <Null>[];
      json['changes_draft_items'].forEach((v) {
        // changesDraftItems!.add(new Null.fromJson(v));
      });
    }
    if (json['payment_items'] != null) {
      paymentItems = <Null>[];
      json['payment_items'].forEach((v) {
        // paymentItems!.add(new Null.fromJson(v));
      });
    }
    if (json['payment_draft_items'] != null) {
      paymentDraftItems = <Null>[];
      json['payment_draft_items'].forEach((v) {
        // paymentDraftItems!.add(new Null.fromJson(v));
      });
    }
    rounding = json['rounding'];
    original = json['original'];
    changes = json['changes'];
    changesDraft = json['changes_draft'];
    total = json['total'];
    paid = json['paid'];
    paidDraft = json['paid_draft'];
    due = json['due'];
    dueInWords = json['due_in_words'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roundingData'] = this.roundingData;
    if (this.changesItems != null) {
      // data['changes_items'] =
      //     this.changesItems!.map((v) => v.toJson()).toList();
    }
    if (this.changesDraftItems != null) {
      // data['changes_draft_items'] =
      //     this.changesDraftItems!.map((v) => v.toJson()).toList();
    }
    if (this.paymentItems != null) {
      // data['payment_items'] =
      //     this.paymentItems!.map((v) => v.toJson()).toList();
    }
    if (this.paymentDraftItems != null) {
      // data['payment_draft_items'] =
      //     this.paymentDraftItems!.map((v) => v.toJson()).toList();
    }
    data['rounding'] = this.rounding;
    data['original'] = this.original;
    data['changes'] = this.changes;
    data['changes_draft'] = this.changesDraft;
    data['total'] = this.total;
    data['paid'] = this.paid;
    data['paid_draft'] = this.paidDraft;
    data['due'] = this.due;
    data['due_in_words'] = this.dueInWords;
    return data;
  }
}

class Project {
  int? id;
  String? financialYear;
  String? code;
  String? description;
  String? startAt;
  String? endAt;
  int? isActive;
  int? isManualAdded;
  String? createdAt;
  String? updatedAt;

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    financialYear = json['financial_year'];
    code = json['code'];
    description = json['description'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    isActive = json['is_active'];
    isManualAdded = json['isManualAdded'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['financial_year'] = this.financialYear;
    data['code'] = this.code;
    data['description'] = this.description;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['is_active'] = this.isActive;
    data['isManualAdded'] = this.isManualAdded;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AccountCodeIncomplete {
  int? id;
  String? financialYear;
  String? code;
  int? ptjGroupId;
  String? description;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  AccountCodeIncomplete(
      {this.id,
      this.financialYear,
      this.code,
      this.ptjGroupId,
      this.description,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  AccountCodeIncomplete.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    financialYear = json['financial_year'];
    code = json['code'];
    ptjGroupId = json['ptj_group_id'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['financial_year'] = this.financialYear;
    data['code'] = this.code;
    data['ptj_group_id'] = this.ptjGroupId;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ServiceIncomplete {
  int? id;
  int? menuId;
  String? name;
  String? serviceReferenceNumber;
  String? cbyChargelines;
  String? receiptType;
  String? serviceChargeData;
  String? taxData;
  String? discountData;
  String? chargelineData;
  String? chargedTo;
  String? status;
  String? submittedAt;
  String? approvalBaAt;
  List<Null>? matrix;
  String? allowThirdPartyPayment;
  String? serviceCategory;
  String? products;
  AgencyIncomplete? agency;
  Menu? menu;

  ServiceIncomplete(
      {this.id,
      this.menuId,
      this.name,
      this.serviceReferenceNumber,
      this.cbyChargelines,
      this.receiptType,
      this.serviceChargeData,
      this.taxData,
      this.discountData,
      this.chargelineData,
      this.chargedTo,
      this.status,
      this.submittedAt,
      this.approvalBaAt,
      this.matrix,
      this.allowThirdPartyPayment,
      this.serviceCategory,
      this.products,
      this.agency,
      this.menu});

  ServiceIncomplete.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    name = json['name'];
    serviceReferenceNumber = json['service_reference_number'];
    cbyChargelines = json['cby_chargelines'];
    receiptType = json['receipt_type'];
    serviceChargeData = json['service_charge_data'];
    taxData = json['tax_data'];
    discountData = json['discount_data'];
    chargelineData = json['chargeline_data'];
    chargedTo = json['charged_to'];
    status = json['status'];
    submittedAt = json['submitted_at'];
    approvalBaAt = json['approval_ba_at'];
    if (json['matrix'] != null) {
      matrix = <Null>[];
      json['matrix'].forEach((v) {
        // matrix!.add(new Null.fromJson(v));
      });
    }
    allowThirdPartyPayment = json['allow_third_party_payment'];
    serviceCategory = json['service_category'];
    products = json['products'];
    agency = json['agency'] != null
        ? new AgencyIncomplete.fromJson(json['agency'])
        : null;
    menu = json['menu'] != null ? new Menu.fromJson(json['menu']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    data['name'] = this.name;
    data['service_reference_number'] = this.serviceReferenceNumber;
    data['cby_chargelines'] = this.cbyChargelines;
    data['receipt_type'] = this.receiptType;
    data['service_charge_data'] = this.serviceChargeData;
    data['tax_data'] = this.taxData;
    data['discount_data'] = this.discountData;
    data['chargeline_data'] = this.chargelineData;
    data['charged_to'] = this.chargedTo;
    data['status'] = this.status;
    data['submitted_at'] = this.submittedAt;
    data['approval_ba_at'] = this.approvalBaAt;
    if (this.matrix != null) {
      // data['matrix'] = this.matrix!.map((v) => v.toJson()).toList();
    }
    data['allow_third_party_payment'] = this.allowThirdPartyPayment;
    data['service_category'] = this.serviceCategory;
    data['products'] = this.products;
    if (this.menu != null) {
      data['menu'] = this.menu!.toJson();
    }
    return data;
  }
}

class Menu {
  int? id;
  String? name;
  int? parentId;
  Parent? parent;

  Menu({this.id, this.name, this.parentId, this.parent});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    parent =
        json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    return data;
  }
}

class Parent {
  int? id;
  // ignore: unnecessary_question_mark
  Null parentId;
  int? lft;
  int? rgt;
  int? depth;
  String? name;
  // ignore: unnecessary_question_mark
  Null icon;
  String? createdAt;
  String? updatedAt;
  // ignore: unnecessary_question_mark
  Null parent;

  Parent(
      {this.id,
      this.parentId,
      this.lft,
      this.rgt,
      this.depth,
      this.name,
      this.icon,
      this.createdAt,
      this.updatedAt,
      this.parent});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    lft = json['lft'];
    rgt = json['rgt'];
    depth = json['depth'];
    name = json['name'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['lft'] = this.lft;
    data['rgt'] = this.rgt;
    data['depth'] = this.depth;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['parent'] = this.parent;
    return data;
  }
}

class AgencyIncomplete {
  int? id;
  String? name;
  String? code;
  String? profile;
  String? address;

  AgencyIncomplete({this.id, this.name, this.code, this.profile, this.address});

  AgencyIncomplete.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    profile = json['profile'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['profile'] = this.profile;
    data['address'] = this.address;
    return data;
  }
}

class BillTypeIncomplete {
  int? id;
  String? type;

  BillTypeIncomplete({this.id, this.type});

  BillTypeIncomplete.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    return data;
  }
}

class MenuIncomplete {
  int? id;
  int? parentId;
  int? lft;
  int? rgt;
  int? depth;
  String? name;
  // ignore: unnecessary_question_mark
  Null icon;
  String? createdAt;
  String? updatedAt;
  Parent? parent;

  MenuIncomplete(
      {this.id,
      this.parentId,
      this.lft,
      this.rgt,
      this.depth,
      this.name,
      this.icon,
      this.createdAt,
      this.updatedAt,
      this.parent});

  MenuIncomplete.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    lft = json['lft'];
    rgt = json['rgt'];
    depth = json['depth'];
    name = json['name'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    parent =
        json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['lft'] = this.lft;
    data['rgt'] = this.rgt;
    data['depth'] = this.depth;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    return data;
  }
}

class CustomerIncomplete {
  int? id;
  String? icNo;
  String? firstName;
  String? lastName;

  CustomerIncomplete({this.id, this.icNo, this.firstName, this.lastName});

  CustomerIncomplete.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icNo = json['ic_no'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ic_no'] = this.icNo;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}
