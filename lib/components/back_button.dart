import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Get.back(),
      icon: Icon(
        Icons.arrow_back_ios,
        color: constants.primaryColor,
      ),
    );
  }
}
