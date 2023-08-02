import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/payments/duitnow_status.dart';
import 'package:flutterbase/models/payments/payments.dart';
import 'package:flutterbase/screens/content/shared/fail.dart';
import 'package:flutterbase/screens/content/shared/success.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class DuitnowQRController extends GetxController {
  Payments payments = Get.arguments["payments"];
  Timer? timer;
  double timerEnd = Duration(minutes: 10).inSeconds / 5;

  @override
  void onInit() {
    log(jsonEncode(payments));
    pollQrStatus();
    super.onInit();
  }

  pollQrStatus() {
    timer = Timer.periodic(
      Duration(seconds: 5),
      (Timer t) async {
        log(t.tick.toString());
        if (t.tick == timerEnd) {
          t.cancel();
          Get.to(() => FailPayment());
        }
        var response =
            await api.getDuitNowStatus(payments.referenceNumber ?? "");

        if (response.isSuccessful) {
          DuitnowStatus duitnowStatus = DuitnowStatus.fromJson(response.data);
          if (duitnowStatus.status == "S") {
            t.cancel();
            Get.to(() => SuccessPayment(), arguments: {
              "reference_number": payments.referenceNumber,
              "amount": duitnowStatus.amount
            });
          }
        }
      },
    );
  }

  shareQr() async {
    final appDir = await syspaths.getTemporaryDirectory();
    File file = File('${appDir.path}/duitnow-qr.jpg');
    await file.writeAsBytes(Get.arguments["image"]);
    Share.shareXFiles([XFile(file.path)]);
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
