// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bill _$BillFromJson(Map<String, dynamic> json) => Bill(
      id: json['id'] as int,
      paidAmount: json['paid_amount'] as String?,
      changedAmout: json['changed_amout'] as String?,
      amountWithoutTax: json['amount_without_tax'] as String?,
      discountType: json['discount_type'] as String?,
      discountAmount: json['discount_amount'] as String?,
      amountWithDiscount: json['amount_with_discount'] as String?,
      taxAmount: json['tax_amount'] as String?,
      amountWithTax: json['amount_with_tax'] as String?,
      roundingAdjustment: json['rounding_adjustment'] as String?,
      startAt: json['start_at'] as String?,
      endAt: json['end_at'] as String?,
      stagingPaymentId: json['staging_payment_id'] as int?,
      serviceId: json['service_id'] as int?,
      billTypeId: json['bill_type_id'] as int?,
      ministryId: json['ministry_id'] as int?,
      makerControllingOfficerId: json['maker_controlling_officer_id'] as int?,
      makerPtjGroupId: json['maker_ptj_group_id'] as int?,
      makerPtjId: json['maker_ptj_id'] as int?,
      makerAccountingOfficeId: json['maker_accounting_office_id'] as int?,
      chargedControllingOfficerId:
          json['charged_controlling_officer_id'] as int?,
      chargedPtjGroupId: json['charged_ptj_group_id'] as int?,
      chargedPtjId: json['charged_ptj_id'] as int?,
      departmentId: json['department_id'] as int?,
      agencyId: json['agency_id'] as int?,
      productId: json['product_id'] as int?,
      subproductId: json['subproduct_id'] as int?,
      billType: json['bill_type'] == null
          ? null
          : BillType.fromJson(json['bill_type'] as Map<String, dynamic>),
      processCode: json['process_code'] as int?,
      referenceNumber: json['reference_number'] as String?,
      detail: json['detail'] as String?,
      entityCode: json['entity_code'] as String?,
      identityCode: json['identity_code'] as String?,
      name1: json['name1'] as String?,
      name2: json['name2'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      address3: json['address3'] as String?,
      postcode: json['postcode'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      telephone: json['telephone'] as String?,
      fax: json['fax'] as String?,
      email: json['email'] as String?,
      description: json['description'] as String?,
      collectionLocation: json['collection_location'] as String?,
      centralisedLocation: json['centralised_location'] as String?,
      centralisedSublocation: json['centralised_sublocation'] as String?,
      billMask: json['bill_mask'] as String?,
      billNumber: json['bill_number'] as String?,
      calculations: nullableJsonDecode(json['calculations']),
      creatorId: json['creator_id'] as int?,
      validationErrors: json['validation_errors'] as List<dynamic>?,
      remarks: json['remarks'] as String?,
      payerId: json['payer_id'] as int?,
      customerId: json['customer_id'] as int?,
      customerCharge: json['customer_charge'] as int?,
      cancellationCategory: json['cancellation_category'] as String?,
      cancellationReason: json['cancellation_reason'] as String?,
      queryRemarks: json['query_remarks'] as String?,
      status: json['status'] as String?,
      source: json['source'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      service: json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      agency: json['agency'] == null
          ? null
          : Agency.fromJson(json['agency'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      favorite: json['favorite'] as int?,
    )
      ..actualAmount = json['actual_amount'] as String?
      ..nettCalculations = json['nett_calculations'] == null
          ? null
          : NettCalculation.fromJson(
              json['nett_calculations'] as Map<String, dynamic>);

Map<String, dynamic> _$BillToJson(Bill instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('staging_payment_id', instance.stagingPaymentId);
  writeNotNull('service_id', instance.serviceId);
  writeNotNull('bill_type_id', instance.billTypeId);
  writeNotNull('ministry_id', instance.ministryId);
  writeNotNull(
      'maker_controlling_officer_id', instance.makerControllingOfficerId);
  writeNotNull('maker_ptj_group_id', instance.makerPtjGroupId);
  writeNotNull('maker_ptj_id', instance.makerPtjId);
  writeNotNull('maker_accounting_office_id', instance.makerAccountingOfficeId);
  writeNotNull(
      'charged_controlling_officer_id', instance.chargedControllingOfficerId);
  writeNotNull('charged_ptj_group_id', instance.chargedPtjGroupId);
  writeNotNull('charged_ptj_id', instance.chargedPtjId);
  writeNotNull('department_id', instance.departmentId);
  writeNotNull('agency_id', instance.agencyId);
  writeNotNull('product_id', instance.productId);
  writeNotNull('subproduct_id', instance.subproductId);
  writeNotNull('process_code', instance.processCode);
  writeNotNull('reference_number', instance.referenceNumber);
  writeNotNull('detail', instance.detail);
  writeNotNull('entity_code', instance.entityCode);
  writeNotNull('identity_code', instance.identityCode);
  writeNotNull('name1', instance.name1);
  writeNotNull('name2', instance.name2);
  writeNotNull('address1', instance.address1);
  writeNotNull('address2', instance.address2);
  writeNotNull('address3', instance.address3);
  writeNotNull('postcode', instance.postcode);
  writeNotNull('city', instance.city);
  writeNotNull('district', instance.district);
  writeNotNull('state', instance.state);
  writeNotNull('country', instance.country);
  writeNotNull('telephone', instance.telephone);
  writeNotNull('fax', instance.fax);
  writeNotNull('email', instance.email);
  writeNotNull('description', instance.description);
  writeNotNull('actual_amount', instance.actualAmount);
  writeNotNull('paid_amount', instance.paidAmount);
  writeNotNull('changed_amout', instance.changedAmout);
  writeNotNull('amount_without_tax', instance.amountWithoutTax);
  writeNotNull('discount_type', instance.discountType);
  writeNotNull('discount_amount', instance.discountAmount);
  writeNotNull('amount_with_discount', instance.amountWithDiscount);
  writeNotNull('tax_amount', instance.taxAmount);
  writeNotNull('amount_with_tax', instance.amountWithTax);
  writeNotNull('rounding_adjustment', instance.roundingAdjustment);
  writeNotNull('nett_calculations', instance.nettCalculations?.toJson());
  writeNotNull('collection_location', instance.collectionLocation);
  writeNotNull('centralised_location', instance.centralisedLocation);
  writeNotNull('centralised_sublocation', instance.centralisedSublocation);
  writeNotNull('start_at', instance.startAt);
  writeNotNull('end_at', instance.endAt);
  writeNotNull('bill_mask', instance.billMask);
  writeNotNull('bill_number', instance.billNumber);
  writeNotNull('creator_id', instance.creatorId);
  writeNotNull('validation_errors', instance.validationErrors);
  writeNotNull('remarks', instance.remarks);
  writeNotNull('payer_id', instance.payerId);
  writeNotNull('customer_id', instance.customerId);
  writeNotNull('customer_charge', instance.customerCharge);
  writeNotNull('cancellation_category', instance.cancellationCategory);
  writeNotNull('cancellation_reason', instance.cancellationReason);
  writeNotNull('query_remarks', instance.queryRemarks);
  writeNotNull('status', instance.status);
  writeNotNull('source', instance.source);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('updated_at', instance.updatedAt);
  writeNotNull('calculations', instance.calculations);
  writeNotNull('bill_type', instance.billType?.toJson());
  writeNotNull('service', instance.service?.toJson());
  writeNotNull('agency', instance.agency?.toJson());
  writeNotNull('customer', instance.customer?.toJson());
  writeNotNull('favorite', instance.favorite);
  return val;
}

NettCalculation _$NettCalculationFromJson(Map<String, dynamic> json) =>
    NettCalculation(
      rounding: (json['rounding'] as num?)?.toDouble() ?? 0,
      original: (json['original'] as num?)?.toDouble() ?? 0,
      changes: (json['changes'] as num?)?.toDouble() ?? 0,
      changesDraft: (json['changes_draft'] as num?)?.toDouble() ?? 0,
      total: (json['total'] as num?)?.toDouble() ?? 0,
      paid: (json['paid'] as num?)?.toDouble() ?? 0,
      paidDraft: (json['paid_draft'] as num?)?.toDouble() ?? 0,
      due: (json['due'] as num?)?.toDouble() ?? 0,
      dueInWords: json['due_in_words'] as String? ?? '',
    );

Map<String, dynamic> _$NettCalculationToJson(NettCalculation instance) =>
    <String, dynamic>{
      'rounding': instance.rounding,
      'original': instance.original,
      'changes': instance.changes,
      'changes_draft': instance.changesDraft,
      'total': instance.total,
      'paid': instance.paid,
      'paid_draft': instance.paidDraft,
      'due': instance.due,
      'due_in_words': instance.dueInWords,
    };
