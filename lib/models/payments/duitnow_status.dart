import 'package:json_annotation/json_annotation.dart';
part 'duitnow_status.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DuitnowStatus {
  DuitnowStatus({
    this.amount,
    this.bizMsgId,
    this.creditDtTm,
    this.respCd,
    this.respDesc,
    this.status,
  });

  String? amount;
  String? bizMsgId;
  String? creditDtTm;
  String? respCd;
  List<String?>? respDesc;
  String? status;

  factory DuitnowStatus.fromJson(Map<String, dynamic> json) =>
      _$DuitnowStatusFromJson(json);

  Map<String, dynamic> toJson() => _$DuitnowStatusToJson(this);
}
