// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      chargedTo: json['charged_to'] as String,
      id: json['id'] as int,
      agency: json['agency'] == null
          ? null
          : Agency.fromJson(json['agency'] as Map<String, dynamic>),
      approvalBaAt: json['approval_ba_at'] as String?,
      billTypeId: json['bill_type_id'] as int?,
      cbyChargelines: nullableJsonDecodeList(json['cby_chargelines']),
      chargelineData: nullableJsonDecodeList(json['chargeline_data']),
      discountData: json['discount_data'] as String?,
      favourite: nullableIntCastBool(json['favourite']),
      menu: json['menu'] == null
          ? null
          : Menu.fromJson(json['menu'] as Map<String, dynamic>),
      menuId: json['menu_id'] as int?,
      name: json['name'] as String?,
      receiptType: json['receipt_type'] as String?,
      serviceChargeData: json['service_charge_data'] as String?,
      serviceReferenceNumber: json['service_reference_number'] as String?,
      status: json['status'] as String?,
      submittedAt: json['submitted_at'] as String?,
      taxData: json['tax_data'] as String?,
      withMatrix: json['with_matrix'] as bool?,
      referenceNoLabel: json['reference_no_label'] as String?,
    );

Map<String, dynamic> _$ServiceToJson(Service instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bill_type_id', instance.billTypeId);
  writeNotNull('menu_id', instance.menuId);
  val['charged_to'] = instance.chargedTo;
  writeNotNull('approval_ba_at', instance.approvalBaAt);
  writeNotNull('discount_data', instance.discountData);
  writeNotNull('name', instance.name);
  writeNotNull('receipt_type', instance.receiptType);
  writeNotNull('service_charge_data', instance.serviceChargeData);
  writeNotNull('service_reference_number', instance.serviceReferenceNumber);
  writeNotNull('status', instance.status);
  writeNotNull('submitted_at', instance.submittedAt);
  writeNotNull('tax_data', instance.taxData);
  writeNotNull('reference_no_label', instance.referenceNoLabel);
  writeNotNull('cby_chargelines', instance.cbyChargelines);
  writeNotNull('chargeline_data', instance.chargelineData);
  writeNotNull('agency', instance.agency?.toJson());
  writeNotNull('menu', instance.menu?.toJson());
  writeNotNull('favourite', instance.favourite);
  writeNotNull('with_matrix', instance.withMatrix);
  return val;
}
