import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:get/get.dart';

class FormDatePicker extends StatelessWidget {
  const FormDatePicker({
    Key? key,
    required this.title,
    required this.selectedDate,
    required this.placeholder,
    required this.isFirst,
  }) : super(key: key);

  final String title;
  final String placeholder;
  final Rx<DateTime> selectedDate;
  final RxBool isFirst;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        selectedDate.value = await showDatePicker(
              context: context,
              locale: Get.locale?.languageCode == 'en'
                  ? Locale("en")
                  : Locale("ms"),
              fieldHintText: 'DD/MM/YYYY',
              fieldLabelText: 'Enter Date'.tr,
              helpText: 'Select Date'.tr,
              cancelText: 'Cancel'.tr,
              confirmText: 'Yes'.tr,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              errorInvalidText: "Out of range.".tr,
              errorFormatText: "Invalid format.".tr,
            ) ??
            selectedDate.value;
        isFirst(false);
      },
      child: Container(
        width: Get.width * 0.9,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: styles.heading15,
            ),
            Obx(
              () => SizedBox(
                height: 30,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  enabled: false,
                 decoration: styles.inputDecoration.copyWith(
                  filled: true,
                  fillColor: Colors.white,
                    errorBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.red, width: 0.0),
                    ),
                    suffixIcon: Icon(
                      getIcon('calendar'), color: Colors.black,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    // contentPadding:
                    //     const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    hintText: !isFirst.value
                        ? dateFormatterDisplay.format(selectedDate.value)
                        : "",
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Obx(
              () => isFirst.value
                  ? Text("$placeholder",
                      style: TextStyle(color: Colors.red.shade300))
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}

class FormTimePicker extends StatelessWidget {
  const FormTimePicker({
    Key? key,
    required this.title,
    required this.selectedTime,
  }) : super(key: key);

  final String title;
  final Rx<TimeOfDay> selectedTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        selectedTime.value = await showTimePicker(
                context: context, initialTime: TimeOfDay.now()) ??
            selectedTime.value;
      },
      child: Container(
        width: Get.width * 0.9,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                title,
                style: const TextStyle(color: Color(0xFF686777)),
              ),
            ),
            Obx(
              () => TextField(
                enabled: false,
                decoration: InputDecoration(
                  suffixIcon: const ImageIcon(
                    AssetImage('assets/images/Date.png'),
                    color: Color(0xFF686777),
                    size: 1,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  hintText: selectedTime.value.format(context),
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xffE2E3E4)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
