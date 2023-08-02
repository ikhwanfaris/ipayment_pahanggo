import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/models.dart';
import 'package:flutterbase/screens/content/cart/cart.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExtraFieldDate extends StatelessWidget {
  const ExtraFieldDate({
    Key? key,
    required this.fieldName,
    required this.field,
    required this.onChange,
  }) : super(key: key);

  final String fieldName;
  final MatrixExtraField field;
  final void Function(String value) onChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: doChangeInputDate,
      child: AbsorbPointer(
        child: FormBuilderTextField(
          name: fieldName,
          initialValue: field.value,
          readOnly: true,
          decoration: AppStyles.decoInputDate.copyWith(
            hintText: field.placeholder.isEmpty
                ? 'Select Date'.tr
                : field.placeholder,
          ),
        ),
      ),
    );
  }

  void doChangeInputDate() {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    var selectedDate =
        dateFormat.parse(field.value ?? DateTime.now().toString());

    selectedDate.isBefore(DateTime.now());

    showDatePicker(
      context: getContext(),
      locale: Get.locale?.languageCode == 'en' ? Locale("en") : Locale("ms"),
      fieldHintText: 'DD/MM/YYYY',
      fieldLabelText: 'Enter Date'.tr,
      helpText: 'Select Date'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Yes'.tr,
      initialDate: field.value != null && selectedDate.isAfter(DateTime.now())
          ? dateFormat.parse(field.value ?? DateTime.now().toString())
          : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    ).then((value) {
      if (value == null) {
        return;
      }

      String selectedDate = dateFormat.format(value);

      field.value = selectedDate;

      cartFormKey.currentState!.patchValue({
        "$fieldName": selectedDate,
      });

      onChange(selectedDate);
    });
  }
}
