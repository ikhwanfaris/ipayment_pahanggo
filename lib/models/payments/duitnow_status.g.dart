// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duitnow_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DuitnowStatus _$DuitnowStatusFromJson(Map<String, dynamic> json) =>
    DuitnowStatus(
      amount: json['amount'] as String?,
      bizMsgId: json['biz_msg_id'] as String?,
      creditDtTm: json['credit_dt_tm'] as String?,
      respCd: json['resp_cd'] as String?,
      respDesc: (json['resp_desc'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$DuitnowStatusToJson(DuitnowStatus instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'biz_msg_id': instance.bizMsgId,
      'credit_dt_tm': instance.creditDtTm,
      'resp_cd': instance.respCd,
      'resp_desc': instance.respDesc,
      'status': instance.status,
    };
