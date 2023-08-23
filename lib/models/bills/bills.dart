import 'package:flutter/cupertino.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/bills/extra_fields.dart';
import 'package:flutterbase/models/shared/translatable.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';

class Bill {
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
  DateTime? billDate;
  String? postingDate;
  DateTime? startAt;
  DateTime? endAt;
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
  String? chargedTo;
  late DateTime createdAt;
  late DateTime updatedAt;
  Null deletedAt;
  late NettCalculation nettCalculations;
  bool? inCart;
  List<Chargeline> chargelines = [];
  List<BillPayment> payments = [];
  List<AmountChange> amountChanges = [];
  List<BillChargelineSummary> chargelineSummaries = [];
  late Services service;
  late Agency agency;
  Map<String, dynamic> customer = {};
  BillType? billType;
  bool? checked = false;
  String? amount1;
  String? amount = "";
  RxBool select = RxBool(false);
  final TextEditingController amount2 = TextEditingController(text: "0.00");
  RxString rounding = RxString("");
  bool canView = false;
  bool canPay = false;

  TextEditingController amountController = TextEditingController(text: "0.00");

  RxBool isSelected = false.obs;
  RxBool isFavorite = false.obs;

  String get summary {
    List<String> summaries = [];
    if (referenceNumber != null) {
      summaries.add(referenceNumber!);
    }
    if (billNumber != null) {
      summaries.add(billNumber!);
    }
    if (billDate != null) {
      summaries.add(dateFormatterDisplay.format(billDate!));
    }
    return summaries.join(' | ');
  }

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
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.inCart,
    required this.service,
    required this.agency,
    required this.customer,
    this.billType,
    this.amount1,
    this.checked,
    this.amount,
  });

  double get amountAfterRounding =>
      amountBeforeRounding + nettCalculations.rounding;

  double get amountBeforeRounding {
    double amt = 0;
    for (var item in chargelineSummaries) {
      amt += item.originalAmount;
      for (var change in item.changes) {
        amt += change.amount;
      }
    }
    return amt;
  }

  static Future<Bill> fetch(int id) async {
    var response = await api.getBill(id);
    return Bill.fromJson(response.data);
  }

  Bill.fromJson(Map<String, dynamic> json) {
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
    billDate =
        json['bill_date'] != null ? DateTime.parse(json['bill_date']) : null;
    postingDate = json['posting_date'];
    startAt =
        json['start_at'] != null ? DateTime.parse(json['start_at']) : null;
    endAt = json['end_at'] != null ? DateTime.parse(json['end_at']) : null;
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
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    amount1 = json['amount'];
    nettCalculations = json['nett_calculations'] != null
        ? NettCalculation.fromJson(json['nett_calculations'])
        : NettCalculation();
    isFavorite.value = json['favorite'].toString() == 'true';
    inCart = json['in_cart'];
    canView = json['can_view'] ?? true;
    canPay = json['can_pay'] ?? true;
    if (json['chargelines'] != null) {
      chargelines = <Chargeline>[];
      json['chargelines'].forEach((v) {
        chargelines.add(new Chargeline.fromJson(v));
      });
    }
    if (json['payments'] != null) {
      payments = <BillPayment>[];
      json['payments'].forEach((v) {
        payments.add(new BillPayment.fromJson(v));
      });
    }
    if (json['amount_changes'] != null) {
      amountChanges = <AmountChange>[];
      json['amount_changes'].forEach((v) {
        amountChanges.add(new AmountChange.fromJson(v));
      });
    }

    chargedTo = json['service']['charged_to'];

    service = Services.fromJson(json['service']);
    agency = Agency.fromJson(json['agency']);
    customer = json['customer'] != null ? json['customer'] : {};
    billType = json['bill_type'] != null
        ? new BillType.fromJson(json['bill_type'])
        : null;

    for (var item in chargelines) {
      mergeChargeline(item);
    }

    for (var item in amountChanges) {
      mergeAmountChange(item);
    }
  }

  mergeChargeline(Chargeline item) {
    try {
      chargelineSummaries
          .where(
            (cl) => cl.code == item.classificationCode.code,
          )
          .first;
    } catch (e) {
      var cc = BillChargelineSummary(item.classificationCode.code,
          item.classificationCode.description, item.amount);
      chargelineSummaries.add(cc);
    }
  }

  mergeAmountChange(AmountChange amountChange) {
    for (var item in amountChange.charges) {
      BillChargelineSummary? cc;
      try {
        cc = chargelineSummaries
            .where(
              (cl) => cl.code == item.code,
            )
            .first;
      } catch (e) {
        cc = BillChargelineSummary(item.code, item.description, 0);
        chargelineSummaries.add(cc);
      }

      cc.changes.add(
        ChargelineSummaryAmountChanges(
            item.code,
            item.description,
            amountChange.referenceNumber,
            amountChange.agencyReferenceNumber,
            item.amount),
      );
    }
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
    data['nett_calculations'] = this.nettCalculations.toJson();
    data['in_cart'] = this.inCart;
    data['chargelines'] = this.chargelines.map((v) => v.toJson()).toList();

    data['payments'] = this.payments.map((v) => v.toJson()).toList();

    data['amount_changes'] = this.amountChanges.map((v) => v.toJson()).toList();

    data['service'] = this.service.toJson();
    data['agency'] = this.agency.toJson();

    data['customer'] = this.customer;
    if (this.billType != null) {
      data['bill_type'] = this.billType!.toJson();
    }
    data['favorite'] = this.isFavorite.value;
    return data;
  }

  bool contains(String value) {
    return ((detail ?? '') + (referenceNumber ?? '') + (billNumber ?? ''))
        .toLowerCase()
        .contains(value.toLowerCase());
  }
}

class ChargelineSummaryAmountChanges {
  String code;
  String description;
  String referenceNumber;
  String agencyReferenceNumber;
  double amount;

  ChargelineSummaryAmountChanges(
    this.code,
    this.description,
    this.referenceNumber,
    this.agencyReferenceNumber,
    this.amount,
  );
}

class BillChargelineSummary {
  String code;
  String description;
  double originalAmount;
  List<ChargelineSummaryAmountChanges> changes = [];

  BillChargelineSummary(this.code, this.description, this.originalAmount);
}

class BillPayment {
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
  late DateTime paymentDate;
  String? source;
  String? status;
  String? cashierName;
  int? firstApproverId;
  Null secondApproverId;
  String? firstApprovalAt;
  Null secondApprovalAt;
  String? taskAt;
  double amount = 0;
  late DateTime createdAt;
  late DateTime updatedAt;

  BillPayment(
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
      required this.paymentDate,
      this.source,
      this.status,
      this.cashierName,
      this.firstApproverId,
      this.secondApproverId,
      this.firstApprovalAt,
      this.secondApprovalAt,
      this.taskAt,
      required this.createdAt,
      required this.updatedAt});

  BillPayment.fromJson(Map<String, dynamic> json) {
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
    paymentDate = DateTime.parse(json['payment_date']);
    source = json['source'];
    status = json['status'];
    cashierName = json['cashier_name'];
    firstApproverId = json['first_approver_id'];
    secondApproverId = json['second_approver_id'];
    firstApprovalAt = json['first_approval_at'];
    secondApprovalAt = json['second_approval_at'];
    taskAt = json['task_at'];
    amount = double.parse(json['amount'].toString());
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
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

class Payment {
  var referenceNumber;

  var status;

  var createdAt;

  var amount;

  var items;

  var id;

  Bill? bill;

  Services? service;

  var gatewayId;

  Payment.fromJson(item) {
    referenceNumber = item['reference_number'];
    status = item['status'];
    createdAt = item['created_at'];
    amount = item['amount'];
    id = item['id'];
  }
}

class Matrix {
  List<List<MatrixFilter>> filters = [];
  List<Product> products = [];
  Matrix.fromJson(item) {
    filters.clear();
    for (var _item in item['filters']) {
      List<MatrixFilter> levelFilter = [];
      for (var _subItem in _item) {
        levelFilter.add(MatrixFilter.fromJson(_subItem));
      }
      filters.add(levelFilter);
    }

    products.clear();
    for (var _item in item['products']) {
      products.add(Product.fromJson(_item));
    }
  }
}

class MatrixFilter {
  late int id;
  late String name;
  List<Chain> chains = [];

  MatrixFilter.fromJson(item) {
    id = int.parse(item['id'].toString());
    name = item['name'];
    // chains.clear();
    for (var json in item['chains']) {
      chains.add(Chain.fromJson(json));
    }
  }
}

class Chain {
  late int id;
  late String name;

  Chain.fromJson(item) {
    id = item['id'];
    name = item['name'];
  }
}

class Product {
  double amount = 0;
  List<Chain> chains = [];
  int stock = 0;
  int dailyQuota = 0;
  int quotaGroup = 0;

  late String name;
  late String unit;
  late double price;
  late bool checkStock;
  late bool checkQuota;
  late int id;

  Product.fromJson(item) {
    id = item['id'];
    name = item['name'];
    unit = item['unit'] ?? '';
    stock = item['stock'] ?? 0;
    checkStock = item['check_stock'] ?? '';
    checkQuota = item['check_quota'] ?? '';
    dailyQuota = int.tryParse(item['daily_quota'].toString()) ?? 0;
    quotaGroup = int.tryParse(item['quota_group'].toString()) ?? 0;
    price = double.tryParse(item['price'].toString()) ?? 0;
    for (var json in item['chains']) {
      chains.add(Chain.fromJson(json));
    }
  }
}

class PaymentItem {
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

  var items;

  PaymentItem(
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

  PaymentItem.fromJson(Map<String, dynamic> json) {
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

class Chargeline {
  late int id;
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
  double amount = 0;
  String? createdAt;
  String? updatedAt;
  AccountCode? accountCode;
  FundVote? fundVote;
  ProgramActivity? programActivity;
  Project? project;
  late ClassificationCode classificationCode;

  Chargeline({
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
    this.createdAt,
    this.updatedAt,
    this.accountCode,
    this.fundVote,
    this.programActivity,
    this.project,
  });

  Chargeline.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
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
    amount = double.parse(json['amount'].toString());
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
    classificationCode =
        ClassificationCode.fromJson(json['classification_code']);
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

    data['classification_code'] = this.classificationCode.toJson();

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
  late String code;
  String description = '';
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
    id = int.parse(json['id'].toString());
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

class AmountChangeChargeline {
  final String code;
  final String description;
  final double amount;

  AmountChangeChargeline(this.code, this.description, this.amount);
}

class AmountChange {
  int? id;
  int? paymentId;
  int? paymentChargelineId;
  int? userId;
  late String referenceNumber;
  late String agencyReferenceNumber;
  String? agencyApprovalDate;
  String? changeAmountReason;
  String? source;
  String? status;
  int? firstApproverId;
  int? secondApproverId;
  String? firstApprovalAt;
  String? secondApprovalAt;
  String? taskAt;
  late double amount;
  String? createdAt;
  String? updatedAt;
  List<AmountChangeChargeline> charges = [];

  AmountChange(
      {this.id,
      this.paymentId,
      this.paymentChargelineId,
      this.userId,
      this.agencyApprovalDate,
      this.changeAmountReason,
      this.source,
      this.status,
      this.firstApproverId,
      this.secondApproverId,
      this.firstApprovalAt,
      this.secondApprovalAt,
      this.taskAt,
      this.createdAt,
      this.updatedAt});

  AmountChange.fromJson(Map<String, dynamic> json) {
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
    amount = double.parse(json['amount'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    for (var item in (json['payment_amount_change_chargelines'] ?? [])) {
      charges.add(AmountChangeChargeline(
        item['classification_code']['code'],
        item['classification_code']['description'],
        double.parse((item['amount'] ?? '0').toString()),
      ));
    }
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

class NettCalculation {
  late RoundingData roundingData;
  List<ChangeItem> changesItems = [];
  double rounding = 0;
  double original = 0;
  double changes = 0;
  double changesDraft = 0;
  double total = 0;
  double paid = 0;
  double paidDraft = 0;
  double due = 0;
  String dueInWords = '';

  NettCalculation();

  NettCalculation.fromJson(Map<String, dynamic> json) {
    roundingData = json['roundingData'] != null
        ? RoundingData.fromJson(json['roundingData'])
        : RoundingData();
    if (json['changes_items'] != null) {
      json['changes_items'].forEach((v) {
        changesItems.add(new ChangeItem.fromJson(v));
      });
    }

    rounding = double.parse(json['rounding'].toString());
    original = double.tryParse(json['original'].toString()) ?? 0;
    changes = double.tryParse(json['changes'].toString()) ?? 0;
    changesDraft = double.tryParse(json['changes_draft'].toString()) ?? 0;
    total = double.tryParse(json['total'].toString()) ?? 0;
    paid = double.tryParse(json['paid'].toString()) ?? 0;
    paidDraft = double.tryParse(json['paid_draft'].toString()) ?? 0;
    due = double.tryParse(json['due'].toString()) ?? 0.0;
    dueInWords = json['due_in_words'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roundingData'] = this.roundingData;
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
  late double amount;
  late int fundVoteId;
  late int accountCodeId;

  RoundingData();

  RoundingData.fromJson(Map<String, dynamic> json) {
    amount = double.parse(json['amount'].toString());
    fundVoteId = json['fund_vote_id'] ?? 0;
    accountCodeId = json['account_code_id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['fund_vote_id'] = this.fundVoteId;
    data['account_code_id'] = this.accountCodeId;
    return data;
  }
}

class ChangeItem {
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

  ChangeItem(
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

  ChangeItem.fromJson(Map<String, dynamic> json) {
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
    amount = json['amount'].toString();
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

class Services {
  late int id;
  late int menuId;
  late int billTypeId;
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
  Menu? menu;

  late Matrix? matrix;
  late List<ExtraField> extraFields;
  late BillType billType;
  late Agency agency;
  late Ministry ministry;
  late bool favorite;
  RxBool isFavorite = false.obs;

  Services(
      {required this.id,
      required this.menuId,
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

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id']!;
    name = json['name'];
    billTypeId = json['bill_type_id'];
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
    agency = Agency.fromJson(json['agency']);
    billType = BillType.fromJson(json['bill_type']);
    favorite = json['favorite'].toString() == 'true';
    isFavorite.value = favorite;

    extraFields = <ExtraField>[].obs;

    if (json.containsKey('matrix') && json['matrix'] != null) {
      matrix = Matrix.fromJson(json['matrix']);
    }

    try {
      if (json.containsKey('extra_fields') && json['extra_fields'] != null) {
        for (var item in json['extra_fields']) {
          extraFields.add(ExtraField.fromJson(item));
        }
      }
    } catch (_) {
      print(_);
      print(json['extra_fields']);
    }

    if (json['menu'] != null) {
      menu = Menu.fromJson(json['menu']);
    }
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

  bool contains(String value) {
    return (name! + (menu?.name ?? '') + serviceReferenceNumber!)
        .toLowerCase()
        .contains(value.toLowerCase());
  }
}

class Agency {
  late int id;
  late String name;
  String? shortName;
  String? code;
  String? profile;
  String? address;
  late int ministryId;
  late int departmentId;
  late Department department;
  late Ministry ministry;

  Agency(
      {required this.id,
      required this.name,
      this.shortName,
      this.code,
      this.profile,
      this.address,
      required this.ministryId,
      required this.departmentId,
      required this.department,
      required this.ministry});

  Agency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['short_name'];
    code = json['code'];
    profile = json['profile'];
    address = json['address'];
    ministryId = json['ministry_id']!;
    departmentId = json['department_id']!;
    department = Department.fromJson(json['department']);
    ministry = Ministry.fromJson(json['ministry']);
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
    data['department'] = this.department.toJson();
    data['ministry'] = this.ministry.toJson();
    return data;
  }
}

class Department {
  late int id;
  late String departmentName;
  late String deptReferenceNo;

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
  Bank? selectedBank;

  bool get requiresBankSelected => id == 2 || id == 4;

  // could be original name or translated name
  String? title;

  var translatables;

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
    var tran =
        ((json['translatables'] ?? []) as List<dynamic>).firstWhereOrNull(
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

    if (logo != null) {
      logo = ENDPOINT + '/storage/' + logo!;
    }

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

class Bank {
  late String code;
  late String name;
  late String browser;
  late String iosApplicationId;
  late String androidApplicationId;
  late String url;
  late String type;

  Bank();

  Bank.fromJson(String type, String url, Map<String, dynamic> json) {
    code = json['code'] ?? '';
    name = json['name'] ?? '';
    browser = json['browser'] ?? '';
    iosApplicationId = json['iosApplicationId'] ?? '';
    androidApplicationId = json['androidApplicationId'] ?? '';
    this.type = type == 'COR' ? 'Corporate' : 'Retail';
    this.url = url;
  }

  Bank.fromEwalletJson(json) {
    code = json['id'].toString();
    name = json['name'];
    browser = '';
    iosApplicationId = '';
    androidApplicationId = '';
    url = '';
    type = '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['browser'] = this.browser;
    data['iosApplicationId'] = this.iosApplicationId;
    data['androidApplicationId'] = this.androidApplicationId;
    return data;
  }
}

class Bank2 {
  late String? code;
  late String? name;
  late String? browser;
  late String? iosApplicationId;
  late String? androidApplicationId;
  late String? url;
  late String? type;
  late List? redirectUrls;

  Bank2(
      {this.code,
      this.name,
      this.browser,
      this.iosApplicationId,
      this.androidApplicationId,
      this.url,
      this.type,
      this.redirectUrls});

  Bank2.fromJson(String type, String url, Map<String, dynamic> json) {
    code = json['code'] ?? '';
    name = json['name'] ?? '';
    browser = json['browser'] ?? '';
    iosApplicationId = json['iosApplicationId'] ?? '';
    androidApplicationId = json['androidApplicationId'] ?? '';
    this.type = type == 'COR' ? 'Corporate' : 'Retail';
    this.url = url;
  }

  Bank2.fromEwalletJson(json) {
    code = json['id'].toString();
    name = json['name'];
    browser = '';
    iosApplicationId = '';
    androidApplicationId = '';
    url = '';
    type = '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['browser'] = this.browser;
    data['iosApplicationId'] = this.iosApplicationId;
    data['androidApplicationId'] = this.androidApplicationId;
    return data;
  }
}

class RedirectUrl {
  String? type;
  String? url;

  RedirectUrl({this.type, this.url});

  RedirectUrl.fromJson(Map<String, dynamic> json) {
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
  double amount = 0;
  late DateTime createdAt;
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
    amount = double.parse(json['amount'].toString());
    createdAt = DateTime.parse(json['created_at']);
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
  String? referenceNumber;
  String? transactionReference;
  late double amount;
  String? paymentMethod;
  String? paymentResponse;
  int? count;
  String? source;
  String? customerName;
  String? customerEmail;
  String? customerPhoneNo;
  String? status;
  String? flag;
  late DateTime createdAt;
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
      this.referenceNumber,
      this.transactionReference,
      this.paymentMethod,
      this.paymentResponse,
      this.count,
      this.source,
      this.customerName,
      this.customerEmail,
      this.customerPhoneNo,
      this.status,
      this.flag,
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
    referenceNumber = json['reference_number'];
    transactionReference = json['transaction_reference'];
    amount = double.parse(json['amount'].toString());
    paymentMethod = json['payment_method'];
    paymentResponse = json['payment_response'];
    count = json['count'];
    source = json['source'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerPhoneNo = json['customer_phone_no'];
    status = json['status'];
    flag = json['flag'];
    createdAt = DateTime.parse(json['created_at']);
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
  Bill? bill;
  Services? service;
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
    bill = json['bill'] != null ? new Bill.fromJson(json['service']) : null;

    service =
        json['service'] != null ? new Services.fromJson(json['service']) : null;
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
  late Bill bill;

  var payment;

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
    bill =
        (json['payment'] != null ? new Bill.fromJson(json['payment']) : null)!;
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

class Menu {
  int? id;
  String? name;
  int? parentId;
  Menu? parent;
  List<Translatables> translatables = [];

  var iconClass;

  Menu({required this.id, this.name, this.parentId, this.parent});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id']!;
    name = json['name'];
    parentId = json['parent_id'];
    iconClass = json['icon_class'];
    parent = json['parent'] != null ? new Menu.fromJson(json['parent']) : null;
    if (json['translatables'] != null) {
      for (var item in json['translatables']) {
        translatables.add(Translatables.fromJson(item));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['icon_class'] = this.iconClass;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    return data;
  }
}
