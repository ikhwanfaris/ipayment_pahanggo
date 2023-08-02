import 'package:json_annotation/json_annotation.dart';
part 'rounding.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Rounding {
  Rounding({
    required this.setting,
    required this.value,
  });

  Setting setting;
  double value;

  factory Rounding.fromJson(Map<String, dynamic> json) =>
      _$RoundingFromJson(json);

  Map<String, dynamic> toJson() => _$RoundingToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Setting {
  Setting({
    required this.id,
    required this.roundingValue,
    required this.roundDownValue,
    required this.isFund,
    required this.fundVoteId,
    required this.accountCodeId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.accountCode,
    required this.fundVote,
  });

  int id;
  int roundingValue;
  int roundDownValue;
  int isFund;
  dynamic fundVoteId;
  int? accountCodeId;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;
  AccountCode? accountCode;
  dynamic fundVote;

  factory Setting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class AccountCode {
  AccountCode({
    required this.id,
    required this.financialYear,
    required this.code,
    required this.ptjGroupId,
    required this.description,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String financialYear;
  String code;
  int ptjGroupId;
  String description;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;

  factory AccountCode.fromJson(Map<String, dynamic> json) =>
      _$AccountCodeFromJson(json);

  Map<String, dynamic> toJson() => _$AccountCodeToJson(this);
}
