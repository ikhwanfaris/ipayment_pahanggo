import 'package:json_annotation/json_annotation.dart';
part 'daily_quota.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DailyQuota {
  DailyQuota({
    this.id,
    this.productId,
    this.date,
    this.remaining,
  });

  int? id;
  int? productId;
  DateTime? date;
  int? remaining;

  factory DailyQuota.fromJson(Map<String, dynamic> json) =>
      _$DailyQuotaFromJson(json);

  Map<String, dynamic> toJson() => _$DailyQuotaToJson(this);
}
