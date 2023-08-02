import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';

class Language extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 55),
            child: Text(
              'Bahasa',
              style: styles.heading1sub,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("English"),
            onTap: () async {
              Locale locale = new Locale("en");
              log("Current: ${Get.locale?.languageCode}");
              Get.updateLocale(locale);
              log("New: ${Get.locale?.languageCode}");
              ErrorResponse response = await api.setLanguage("en");
              if (response.isSuccessful) {
                Get.snackbar(
                  snackPosition: SnackPosition.TOP,
                  "Success".tr,
                  response.message,
                  backgroundColor: Color(0xFF33A36D),
                  colorText: Colors.white,
                );
              }
            },
          ),
          ListTile(
            title: Text("Malaysia"),
            onTap: () async {
              Locale locale = new Locale("ms_MY");
              log("Current: ${Get.locale?.languageCode}");
              Get.updateLocale(locale);
              log("New: ${Get.locale?.languageCode}");
              ErrorResponse response = await api.setLanguage("ms_MY");
              if (response.isSuccessful) {
                Get.snackbar(
                  snackPosition: SnackPosition.TOP,
                  "Success".tr,
                  response.message,
                  backgroundColor: Color(0xFF33A36D),
                  colorText: Colors.white,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
