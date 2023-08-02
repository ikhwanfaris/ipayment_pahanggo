import 'package:flutter/material.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
part 'extra_fields.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ExtraField {
  ExtraField({
    this.source,
    this.placeholder,
    this.type,
    this.fieldId,
    this.value,
  });

  String? source;
  String? placeholder;
  String? type;
  String? fieldId;
  @ExtraFieldValue()
  dynamic value;

  factory ExtraField.fromJson(Map<String, dynamic> json) =>
      _$ExtraFieldFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraFieldToJson(this);
}

class ExtraFieldValue implements JsonConverter<dynamic, dynamic> {
  const ExtraFieldValue();

  @override
  dynamic fromJson(dynamic json) => json;

  @override
  dynamic toJson(dynamic object) {
    if (object.runtimeType == Rx<DateTime>) {
      return dateFormatter.format((object as Rx<DateTime>).value);
    } else if (object.runtimeType == TextEditingController) {
      return (object as TextEditingController).text;
    }
    return null;
  }
}
