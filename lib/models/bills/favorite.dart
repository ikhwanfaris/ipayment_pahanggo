import 'package:flutterbase/models/bills/bills.dart';
import 'package:json_annotation/json_annotation.dart';
part 'favorite.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Favorite {
  Favorite({
    required this.id,
    required this.userId,
    this.serviceId,
    required this.billId,
    required this.createdAt,
    required this.updatedAt,
    this.service,
    this.bill,
  });

  int id;
  int userId;
  int? serviceId;
  int? billId;
  DateTime createdAt;
  DateTime updatedAt;
  Services? service;
  Bill? bill;

  String get secondaryLine {
    List<String> parts = [];
    if(service != null) {
      if(service?.serviceReferenceNumber != null) {
        parts.add(service!.serviceReferenceNumber!);
      }
      if(service?.menu != null) {
        parts.add(service!.menu!.name!);
      }
    }
    if(bill != null) {
      if(bill!.referenceNumber != null && bill!.referenceNumber!.isNotEmpty) {
        parts.add(bill!.referenceNumber!);
      }
      parts.add(bill!.billNumber!);
    }
    return parts.join(' | ');
  }

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteToJson(this);
}
