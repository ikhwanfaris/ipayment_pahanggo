// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incomplete.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Incomplete _$IncompleteFromJson(Map<String, dynamic> json) => Incomplete(
      id: json['id'] as int?,
      transferDetailId: json['transfer_detail_id'],
      userId: json['user_id'] as int?,
      referenceNumber: json['reference_number'] as String?,
      transactionReference: json['transaction_reference'],
      amount: json['amount'] as String?,
      paymentMethod: json['payment_method'] as String?,
      paymentResponse: json['payment_response'],
      count: json['count'] as int?,
      source: json['source'] as String?,
      status: json['status'] as String?,
      flag: json['flag'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => IncompleteItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: json['user'] == null
          ? null
          : UserDetail.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IncompleteToJson(Incomplete instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('transfer_detail_id', instance.transferDetailId);
  writeNotNull('user_id', instance.userId);
  writeNotNull('reference_number', instance.referenceNumber);
  writeNotNull('transaction_reference', instance.transactionReference);
  writeNotNull('amount', instance.amount);
  writeNotNull('payment_method', instance.paymentMethod);
  writeNotNull('payment_response', instance.paymentResponse);
  writeNotNull('count', instance.count);
  writeNotNull('source', instance.source);
  writeNotNull('status', instance.status);
  writeNotNull('flag', instance.flag);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  writeNotNull('items', instance.items?.map((e) => e.toJson()).toList());
  writeNotNull('user', instance.user?.toJson());
  return val;
}

IncompleteItem _$IncompleteItemFromJson(Map<String, dynamic> json) =>
    IncompleteItem(
      id: json['id'] as int?,
      transactionId: json['transaction_id'] as int?,
      billId: json['bill_id'] as int?,
      customerId: json['customer_id'] as int?,
      receiptNumber: json['receipt_number'],
      receiptDate: json['receipt_date'],
      originalReceiptUrl: json['original_receipt_url'],
      copyReceiptUrl: json['copy_receipt_url'],
      paymentDescription: json['payment_description'] as String?,
      serviceId: json['service_id'] as int?,
      amount: json['amount'] as String?,
      items: json['items'] as List<dynamic>?,
      extraFields: json['extra_fields'] as List<dynamic>?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      bill: json['bill'] == null
          ? null
          : Bill.fromJson(json['bill'] as Map<String, dynamic>),
      service: json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IncompleteItemToJson(IncompleteItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('transaction_id', instance.transactionId);
  writeNotNull('bill_id', instance.billId);
  writeNotNull('customer_id', instance.customerId);
  writeNotNull('receipt_number', instance.receiptNumber);
  writeNotNull('receipt_date', instance.receiptDate);
  writeNotNull('original_receipt_url', instance.originalReceiptUrl);
  writeNotNull('copy_receipt_url', instance.copyReceiptUrl);
  writeNotNull('payment_description', instance.paymentDescription);
  writeNotNull('service_id', instance.serviceId);
  writeNotNull('amount', instance.amount);
  writeNotNull('items', instance.items);
  writeNotNull('extra_fields', instance.extraFields);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  writeNotNull('bill', instance.bill?.toJson());
  writeNotNull('service', instance.service?.toJson());
  writeNotNull('customer', instance.customer?.toJson());
  return val;
}

UserDetail _$UserDetailFromJson(Map<String, dynamic> json) => UserDetail(
      id: json['id'] as int?,
      icNo: json['ic_no'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
    );

Map<String, dynamic> _$UserDetailToJson(UserDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('ic_no', instance.icNo);
  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  return val;
}
