// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rounding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rounding _$RoundingFromJson(Map<String, dynamic> json) => Rounding(
      setting: Setting.fromJson(json['setting'] as Map<String, dynamic>),
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$RoundingToJson(Rounding instance) => <String, dynamic>{
      'setting': instance.setting.toJson(),
      'value': instance.value,
    };

Setting _$SettingFromJson(Map<String, dynamic> json) => Setting(
      id: json['id'] as int,
      roundingValue: json['rounding_value'] as int,
      roundDownValue: json['round_down_value'] as int,
      isFund: json['is_fund'] as int,
      fundVoteId: json['fund_vote_id'],
      accountCodeId: json['account_code_id'] as int?,
      isActive: json['is_active'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      accountCode: json['account_code'] == null
          ? null
          : AccountCode.fromJson(json['account_code'] as Map<String, dynamic>),
      fundVote: json['fund_vote'],
    );

Map<String, dynamic> _$SettingToJson(Setting instance) => <String, dynamic>{
      'id': instance.id,
      'rounding_value': instance.roundingValue,
      'round_down_value': instance.roundDownValue,
      'is_fund': instance.isFund,
      'fund_vote_id': instance.fundVoteId,
      'account_code_id': instance.accountCodeId,
      'is_active': instance.isActive,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'account_code': instance.accountCode?.toJson(),
      'fund_vote': instance.fundVote,
    };

AccountCode _$AccountCodeFromJson(Map<String, dynamic> json) => AccountCode(
      id: json['id'] as int,
      financialYear: json['financial_year'] as String,
      code: json['code'] as String,
      ptjGroupId: json['ptj_group_id'] as int,
      description: json['description'] as String,
      isActive: json['is_active'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$AccountCodeToJson(AccountCode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'financial_year': instance.financialYear,
      'code': instance.code,
      'ptj_group_id': instance.ptjGroupId,
      'description': instance.description,
      'is_active': instance.isActive,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
