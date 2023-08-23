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

  String get display {
    if(value.runtimeType == Rx<DateTime>) {
      return dateFormatterDisplay.format((value as Rx<DateTime>).value);
    }
    if(value.runtimeType == RxString && (value as RxString).value.isNotEmpty) {
      return (value as RxString).value;
    }
    return placeholder ?? '-';
  }

  String? get dbValue {
    if(value.runtimeType == Rx<DateTime>) {
      return dateFormatter2.format((value as Rx<DateTime>).value);
    }
    if(value.runtimeType == RxString && (value as RxString).value.isNotEmpty) {
      return (value as RxString).value;
    }
    return '';
  }

  Map<String, dynamic> toJson() => _$ExtraFieldToJson(this);
}

class ExtraFieldValue implements JsonConverter<dynamic, dynamic> {
  const ExtraFieldValue();

  @override
  dynamic fromJson(dynamic json) => json;

  @override
  dynamic toJson(dynamic object) {
    if (object.runtimeType == Rx<DateTime>) {
      return dateFormatter2.format((object as Rx<DateTime>).value);
    } else if (object.runtimeType == RxString) {
      return (object as RxString).value;
    }
    return null;
  }
}
