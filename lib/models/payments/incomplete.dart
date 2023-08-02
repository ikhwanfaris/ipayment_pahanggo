import 'package:flutterbase/models/contents/bill.dart';
import 'package:flutterbase/models/customer/customer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutterbase/models/service/service.dart';
part 'incomplete.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class Incomplete {
  Incomplete({
    this.id,
    this.transferDetailId,
    this.userId,
    this.referenceNumber,
    this.transactionReference,
    this.amount,
    this.paymentMethod,
    this.paymentResponse,
    this.count,
    this.source,
    this.status,
    this.flag,
    this.createdAt,
    this.updatedAt,
    this.items,
    this.user,
  });

  int? id;
  dynamic transferDetailId;
  int? userId;
  String? referenceNumber;
  dynamic transactionReference;
  String? amount;
  String? paymentMethod;
  dynamic paymentResponse;
  int? count;
  String? source;
  String? status;
  dynamic flag;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<IncompleteItem>? items;
  UserDetail? user;

  factory Incomplete.fromJson(Map<String, dynamic> json) => _$IncompleteFromJson(json);

  Map<String, dynamic> toJson() => _$IncompleteToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class IncompleteItem {
  IncompleteItem({
    this.id,
    this.transactionId,
    this.billId,
    this.customerId,
    this.receiptNumber,
    this.receiptDate,
    this.originalReceiptUrl,
    this.copyReceiptUrl,
    this.paymentDescription,
    this.serviceId,
    this.amount,
    this.items,
    this.extraFields,
    this.createdAt,
    this.updatedAt,
    this.bill,
    this.service,
    this.customer,
  });

  int? id;
  int? transactionId;
  int? billId;
  int? customerId;
  dynamic receiptNumber;
  dynamic receiptDate;
  dynamic originalReceiptUrl;
  dynamic copyReceiptUrl;
  String? paymentDescription;
  int? serviceId;
  String? amount;
  List<dynamic>? items;
  List<dynamic>? extraFields;
  DateTime? createdAt;
  DateTime? updatedAt;
  Bill? bill;
  Service? service;
  Customer? customer;

  factory IncompleteItem.fromJson(Map<String, dynamic> json) => _$IncompleteItemFromJson(json);

  Map<String, dynamic> toJson() => _$IncompleteItemToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class UserDetail {
  UserDetail({
    this.id,
    this.icNo,
    this.firstName,
    this.lastName,
  });

  int? id;
  String? icNo;
  String? firstName;
  String? lastName;

  factory UserDetail.fromJson(Map<String, dynamic> json) => _$UserDetailFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailToJson(this);
}
