// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bill _$BillFromJson(Map<String, dynamic> json) => Bill(
      id: json['id'] as int?,
      billTypeId: json['bill_type_id'] as int?,
      serviceId: json['service_id'] as int?,
      ministryId: json['ministry_id'] as int?,
      departmentId: json['department_id'] as int?,
      agencyId: json['agency_id'] as int?,
      creatorId: json['creator_id'] as int?,
      makerPtjId: json['maker_ptj_id'] as int?,
      locationId: json['location_id'] as int?,
      sublocationId: json['sublocation_id'] as int?,
      userIdentityTypeId: json['user_identity_type_id'] as int?,
      countryId: json['country_id'] as int?,
      stateId: json['state_id'] as int?,
      cityId: json['city_id'] as int?,
      districtId: json['district_id'] as int?,
      identityCodeCategory: json['identity_code_category'] as String?,
      identityCode: json['identity_code'] as String?,
      previousIdentityCode: json['previous_identity_code'],
      customerName: json['customer_name'] as String?,
      customerReferenceNumber: json['customer_reference_number'] as String?,
      address: json['address'] as String?,
      postcode: json['postcode'] as String?,
      stateName: json['state_name'] as String?,
      cityName: json['city_name'] as String?,
      districtName: json['district_name'] as String?,
      telephone: json['telephone'] as String?,
      email: json['email'] as String?,
      detail: json['detail'] as String?,
      referenceNumber: json['reference_number'] as String?,
      billDate: json['bill_date'] == null
          ? null
          : DateTime.parse(json['bill_date'] as String),
      startAt: json['start_at'] == null
          ? null
          : DateTime.parse(json['start_at'] as String),
      endAt: json['end_at'] == null
          ? null
          : DateTime.parse(json['end_at'] as String),
      customerNote: json['customer_note'] as String?,
      source: json['source'] as String?,
      stagingBatchId: json['staging_batch_id'],
      stagingBatchContentId: json['staging_batch_content_id'],
      processCode: json['process_code'] as int?,
      dataStatus: json['data_status'] as String?,
      status: json['status'] as String?,
      firstApproverId: json['first_approver_id'],
      secondApproverId: json['second_approver_id'],
      firstApprovalAt: json['first_approval_at'],
      secondApprovalAt: json['second_approval_at'],
      taskAt: json['task_at'],
      queryRemarks: json['query_remarks'],
      billNumber: json['bill_number'] as String?,
      billMask: json['bill_mask'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'],
      nettCalculations: json['nett_calculations'] == null
          ? null
          : NettCalculations.fromJson(
              json['nett_calculations'] as Map<String, dynamic>),
      service: json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      agency: json['agency'] == null
          ? null
          : Agency.fromJson(json['agency'] as Map<String, dynamic>),
      customer: json['customer'],
      billType: json['bill_type'] == null
          ? null
          : BillType.fromJson(json['bill_type'] as Map<String, dynamic>),
      favorite: json['favorite'] as bool?,
    );

Map<String, dynamic> _$BillToJson(Bill instance) => <String, dynamic>{
      'id': instance.id,
      'bill_type_id': instance.billTypeId,
      'service_id': instance.serviceId,
      'ministry_id': instance.ministryId,
      'department_id': instance.departmentId,
      'agency_id': instance.agencyId,
      'creator_id': instance.creatorId,
      'maker_ptj_id': instance.makerPtjId,
      'location_id': instance.locationId,
      'sublocation_id': instance.sublocationId,
      'user_identity_type_id': instance.userIdentityTypeId,
      'country_id': instance.countryId,
      'state_id': instance.stateId,
      'city_id': instance.cityId,
      'district_id': instance.districtId,
      'identity_code_category': instance.identityCodeCategory,
      'identity_code': instance.identityCode,
      'previous_identity_code': instance.previousIdentityCode,
      'customer_name': instance.customerName,
      'customer_reference_number': instance.customerReferenceNumber,
      'address': instance.address,
      'postcode': instance.postcode,
      'state_name': instance.stateName,
      'city_name': instance.cityName,
      'district_name': instance.districtName,
      'telephone': instance.telephone,
      'email': instance.email,
      'detail': instance.detail,
      'reference_number': instance.referenceNumber,
      'bill_date': instance.billDate?.toIso8601String(),
      'start_at': instance.startAt?.toIso8601String(),
      'end_at': instance.endAt?.toIso8601String(),
      'source': instance.source,
      'staging_batch_id': instance.stagingBatchId,
      'staging_batch_content_id': instance.stagingBatchContentId,
      'process_code': instance.processCode,
      'data_status': instance.dataStatus,
      'status': instance.status,
      'first_approver_id': instance.firstApproverId,
      'second_approver_id': instance.secondApproverId,
      'first_approval_at': instance.firstApprovalAt,
      'second_approval_at': instance.secondApprovalAt,
      'task_at': instance.taskAt,
      'query_remarks': instance.queryRemarks,
      'bill_number': instance.billNumber,
      'bill_mask': instance.billMask,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'deleted_at': instance.deletedAt,
      'nett_calculations': instance.nettCalculations?.toJson(),
      'service': instance.service?.toJson(),
      'agency': instance.agency?.toJson(),
      'customer': instance.customer,
      'bill_type': instance.billType?.toJson(),
      'favorite': instance.favorite,
      'customer_note': instance.customerNote,
    };

BillType _$BillTypeFromJson(Map<String, dynamic> json) => BillType(
      id: json['id'] as int,
      type: json['type'] as String,
    );

Map<String, dynamic> _$BillTypeToJson(BillType instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

NettCalculations _$NettCalculationsFromJson(Map<String, dynamic> json) =>
    NettCalculations(
      roundingData: json['rounding_data'],
      changesItems: json['changes_items'] as List<dynamic>?,
      changesDraftItems: json['changes_draft_items'] as List<dynamic>?,
      paymentItems: json['payment_items'] as List<dynamic>?,
      paymentDraftItems: json['payment_draft_items'] as List<dynamic>?,
      rounding: (json['rounding'] as num?)?.toDouble(),
      original: (json['original'] as num?)?.toDouble(),
      changes: (json['changes'] as num?)?.toDouble(),
      changesDraft: (json['changes_draft'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      paid: (json['paid'] as num?)?.toDouble(),
      paidDraft: (json['paid_draft'] as num?)?.toDouble(),
      due: (json['due'] as num?)?.toDouble(),
      dueInWords: json['due_in_words'] as String?,
    );

Map<String, dynamic> _$NettCalculationsToJson(NettCalculations instance) =>
    <String, dynamic>{
      'rounding_data': instance.roundingData,
      'changes_items': instance.changesItems,
      'changes_draft_items': instance.changesDraftItems,
      'payment_items': instance.paymentItems,
      'payment_draft_items': instance.paymentDraftItems,
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
