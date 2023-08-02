// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_incomplete.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceIncompletes _$ServiceIncompletesFromJson(Map<String, dynamic> json) =>
    ServiceIncompletes(
      id: json['id'] as int?,
      agencyId: json['agency_id'] as int?,
      ministryId: json['ministry_id'] as int?,
      name: json['name'] as String?,
      menuId: json['menu_id'] as int?,
      serviceReferenceNumber: json['service_reference_number'] as String?,
      billTypeId: json['bill_type_id'] as int?,
      serviceGroupId: json['service_group_id'] as int?,
      agencySystemId: json['agency_system_id'],
      systemSupportingDocumentPath: json['system_supporting_document_path'],
      systemApprovalLetterDate: json['system_approval_letter_date'],
      systemApprovalLetterRef: json['system_approval_letter_ref'],
      systemDescription: json['system_description'],
      systemLogo: json['system_logo'],
      systemName: json['system_name'],
      productLabelDisplay: json['product_label_display'],
      matrix: Matrix.fromJson(json['matrix'] as Map<String, dynamic>),
      extraFields: json['extra_fields'] as List<dynamic>?,
      fileExtensions: json['file_extensions'],
      maxFileSize: json['max_file_size'],
      refNoLabel: json['ref_no_label'] as String?,
      allowCby: json['allow_cby'] as int?,
      cbyChargelines: json['cby_chargelines'] as String?,
      receiptType: json['receipt_type'] as String?,
      allowPartialPayment: json['allow_partial_payment'] as int?,
      isSensitive: json['is_sensitive'] as int?,
      isSendIgfmas: json['is_send_igfmas'] as int?,
      isInvoiceIGfmas: json['is_invoice_i_gfmas'] as int?,
      allowThirdPartyPayment: json['allow_third_party_payment'] as String?,
      thirdPartySearchTypes: json['third_party_search_types'],
      serviceMode: json['service_mode'],
      integrationData: json['integration_data'] as String?,
      serviceChargeData: json['service_charge_data'] as String?,
      taxData: json['tax_data'] as String?,
      discountData: json['discount_data'] as String?,
      chargelineData: json['chargeline_data'] as String?,
      collectionChannels: json['collection_channels'],
      preparerLocations: json['preparer_locations'] as List<dynamic>?,
      usageMode: json['usage_mode'] as String?,
      collectionType: json['collection_type'] as String?,
      chargedTo: json['charged_to'] as String?,
      status: json['status'] as String?,
      creatorId: json['creator_id'] as int?,
      hasModified: json['has_modified'] as int?,
      submittedAt: json['submitted_at'] == null
          ? null
          : DateTime.parse(json['submitted_at'] as String),
      approvalAgencyAt: json['approval_agency_at'] as String?,
      approvalAgencyBy: json['approval_agency_by'] as int?,
      approvalAgencyRemarks: json['approval_agency_remarks'],
      approvalBaRemarks: json['approval_ba_remarks'],
      approvalBaAt: json['approval_ba_at'] as String?,
      approvalBaBy: json['approval_ba_by'] as int?,
      janmChecker: json['janm_checker'] as int?,
      approvalJanmFungsianAt: json['approval_janm_fungsian_at'] as String?,
      approvalJanmFungsianRemarks: json['approval_janm_fungsian_remarks'],
      approvalJanmFungsianBy: json['approval_janm_fungsian_by'] as int?,
      approvalJanmTeknikalAt: json['approval_janm_teknikal_at'] as String?,
      approvalJanmTeknikalRemarks: json['approval_janm_teknikal_remarks'],
      approvalJanmTeknikalBy: json['approval_janm_teknikal_by'] as int?,
      operationManagement: json['operation_management'],
      skipPaymentApproval: json['skip_payment_approval'] as int?,
      isActive: json['is_active'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      serviceCategory: json['service_category'] as String?,
      products: json['products'] as String?,
      agency: json['agency'] == null
          ? null
          : Agency.fromJson(json['agency'] as Map<String, dynamic>),
      menu: json['menu'] == null
          ? null
          : Menu.fromJson(json['menu'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceIncompletesToJson(ServiceIncompletes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'agency_id': instance.agencyId,
      'ministry_id': instance.ministryId,
      'name': instance.name,
      'menu_id': instance.menuId,
      'service_reference_number': instance.serviceReferenceNumber,
      'bill_type_id': instance.billTypeId,
      'service_group_id': instance.serviceGroupId,
      'agency_system_id': instance.agencySystemId,
      'system_supporting_document_path': instance.systemSupportingDocumentPath,
      'system_approval_letter_date': instance.systemApprovalLetterDate,
      'system_approval_letter_ref': instance.systemApprovalLetterRef,
      'system_description': instance.systemDescription,
      'system_logo': instance.systemLogo,
      'system_name': instance.systemName,
      'product_label_display': instance.productLabelDisplay,
      'matrix': instance.matrix.toJson(),
      'extra_fields': instance.extraFields,
      'file_extensions': instance.fileExtensions,
      'max_file_size': instance.maxFileSize,
      'ref_no_label': instance.refNoLabel,
      'allow_cby': instance.allowCby,
      'cby_chargelines': instance.cbyChargelines,
      'receipt_type': instance.receiptType,
      'allow_partial_payment': instance.allowPartialPayment,
      'is_sensitive': instance.isSensitive,
      'is_send_igfmas': instance.isSendIgfmas,
      'is_invoice_i_gfmas': instance.isInvoiceIGfmas,
      'allow_third_party_payment': instance.allowThirdPartyPayment,
      'third_party_search_types': instance.thirdPartySearchTypes,
      'service_mode': instance.serviceMode,
      'integration_data': instance.integrationData,
      'service_charge_data': instance.serviceChargeData,
      'tax_data': instance.taxData,
      'discount_data': instance.discountData,
      'chargeline_data': instance.chargelineData,
      'collection_channels': instance.collectionChannels,
      'preparer_locations': instance.preparerLocations,
      'usage_mode': instance.usageMode,
      'collection_type': instance.collectionType,
      'charged_to': instance.chargedTo,
      'status': instance.status,
      'creator_id': instance.creatorId,
      'has_modified': instance.hasModified,
      'submitted_at': instance.submittedAt?.toIso8601String(),
      'approval_agency_at': instance.approvalAgencyAt,
      'approval_agency_by': instance.approvalAgencyBy,
      'approval_agency_remarks': instance.approvalAgencyRemarks,
      'approval_ba_remarks': instance.approvalBaRemarks,
      'approval_ba_at': instance.approvalBaAt,
      'approval_ba_by': instance.approvalBaBy,
      'janm_checker': instance.janmChecker,
      'approval_janm_fungsian_at': instance.approvalJanmFungsianAt,
      'approval_janm_fungsian_remarks': instance.approvalJanmFungsianRemarks,
      'approval_janm_fungsian_by': instance.approvalJanmFungsianBy,
      'approval_janm_teknikal_at': instance.approvalJanmTeknikalAt,
      'approval_janm_teknikal_remarks': instance.approvalJanmTeknikalRemarks,
      'approval_janm_teknikal_by': instance.approvalJanmTeknikalBy,
      'operation_management': instance.operationManagement,
      'skip_payment_approval': instance.skipPaymentApproval,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'service_category': instance.serviceCategory,
      'products': instance.products,
      'agency': instance.agency?.toJson(),
      'menu': instance.menu?.toJson(),
    };

Agency _$AgencyFromJson(Map<String, dynamic> json) => Agency(
      id: json['id'] as int?,
      ministryId: json['ministryId'] as int?,
      departmentId: json['departmentId'] as int?,
      depth: json['depth'] as int?,
      rgt: json['rgt'] as int?,
      lft: json['lft'] as int?,
      parentId: json['parentId'] as int?,
      name: json['name'] as String?,
      shortName: json['shortName'] as String?,
      code: json['code'] as String?,
      logoPath: json['logoPath'],
      profile: json['profile'] as String?,
      address: json['address'] as String?,
      isActive: json['isActive'] as int?,
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AgencyToJson(Agency instance) => <String, dynamic>{
      'id': instance.id,
      'ministryId': instance.ministryId,
      'departmentId': instance.departmentId,
      'depth': instance.depth,
      'rgt': instance.rgt,
      'lft': instance.lft,
      'parentId': instance.parentId,
      'name': instance.name,
      'shortName': instance.shortName,
      'code': instance.code,
      'logoPath': instance.logoPath,
      'profile': instance.profile,
      'address': instance.address,
      'isActive': instance.isActive,
      'endDate': instance.endDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

ServiceIncompletesMatrix _$ServiceIncompletesMatrixFromJson(
        Map<String, dynamic> json) =>
    ServiceIncompletesMatrix(
      name: json['name'] as String?,
      dailyQuota: json['dailyQuota'] as int?,
      basis: json['basis'] as int?,
      matrix: (json['matrix'] as List<dynamic>?)
          ?.map((e) => e as List<dynamic>)
          .toList(),
    );

Map<String, dynamic> _$ServiceIncompletesMatrixToJson(
        ServiceIncompletesMatrix instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dailyQuota': instance.dailyQuota,
      'basis': instance.basis,
      'matrix': instance.matrix,
    };

MatrixMatrixClass _$MatrixMatrixClassFromJson(Map<String, dynamic> json) =>
    MatrixMatrixClass(
      title: json['title'] as String?,
      unit: json['unit'] as String?,
      classification: json['classification'] as String?,
      stock: json['stock'] as int?,
    );

Map<String, dynamic> _$MatrixMatrixClassToJson(MatrixMatrixClass instance) =>
    <String, dynamic>{
      'title': instance.title,
      'unit': instance.unit,
      'classification': instance.classification,
      'stock': instance.stock,
    };

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      id: json['id'] as int?,
      parentId: json['parentId'],
      lft: json['lft'] as int?,
      rgt: json['rgt'] as int?,
      depth: json['depth'] as int?,
      name: json['name'] as String?,
      icon: json['icon'],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      parent: json['parent'],
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'lft': instance.lft,
      'rgt': instance.rgt,
      'depth': instance.depth,
      'name': instance.name,
      'icon': instance.icon,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'parent': instance.parent,
    };

ServiceItem _$ServiceItemFromJson(Map<String, dynamic> json) => ServiceItem(
      id: json['id'] as int?,
      price: json['price'],
      quantity: json['quantity'] as int?,
      totalPrice: json['total_price'] as num?,
      title: json['title'] as String?,
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$ServiceItemToJson(ServiceItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'quantity': instance.quantity,
      'total_price': instance.totalPrice,
      'title': instance.title,
      'unit': instance.unit,
    };
