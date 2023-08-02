import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';

class FormTextField extends StatelessWidget {
  FormTextField({
    Key? key,
    required this.title,
    required this.placeholder,
    required this.text,
  }) : super(key: key);

  final String title;
  final String placeholder;
  final Rx<TextEditingController> text;
  final RxBool isHide = RxBool(true);

  @override
  Widget build(BuildContext context) {
    print(title);

    return Container(
      width: Get.width * 0.9,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: styles.heading15,
          ),
          SizedBox(
            height: title == 'Alamat Penghantaran*' ? 50 : 30,
            child: TextField(
              controller: text.value,
              onChanged: (value) =>
                  (value == "") ? isHide(true) : isHide(false),
              decoration: styles.inputDecoration.copyWith(
                filled: true,
                fillColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                // contentPadding:
                //     const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xffE2E3E4)),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Obx(
            () => (isHide.value)
                ? Text("$placeholder",
                    style: TextStyle(color: Colors.red.shade300))
                : Container(),
          ),
        ],
      ),
    );
  }
}
