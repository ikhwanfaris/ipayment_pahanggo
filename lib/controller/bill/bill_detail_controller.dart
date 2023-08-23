import 'package:flutter/material.dart';
import 'package:flutterbase/controller/bottom_bar_controller.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:get/get.dart';

class BillDetailController extends GetxController {
  String title = "";
  double jumlah = 0;
  List<DropdownMenuItem<BankType>> listDropdown = [];
  Rx<BankType> selectedBank =
      BankType(code: '', name: '', type: '', url: '').obs;
  Rx<PaymentGateway> paymentType = PaymentGateway(id: 1).obs;
  RxList<PaymentGateway> paymentGateways = <PaymentGateway>[].obs;
  Bill? bill;
  List<Map> transactionItems = [];
  RxDouble roundingAmount = 0.0.obs;
  RxBool isLoading = RxBool(false);
  BottomBarController barController = BottomBarController(false);
  double amount = 0;

  BillDetailController({ this.amount = 0 });

  @override
  void onInit() async {
    isLoading.value = true;
    bill = await Bill.fetch(Get.arguments['id']);
    isLoading.value = false;
    barController.clear();
    if(bill!.canView && bill!.canPay) {
      barController.add(bill!.chargedTo!, billId: bill!.id, amount > 0 ? amount : bill!.nettCalculations.due);
    }
    super.onInit();
  }
}

// enum PaymentType {
//   duitNowQR(
//       "DuitNow QR",
//       ImageIcon(
//         AssetImage("assets/dist/DuitNowQR_Primary.png"),
//         size: 30,
//       ),
//       1),
//   card("Kad", Icon(Icons.credit_card), 2),
//   duitNowTransfer(
//       "DuitNow Online Banking",
//       ImageIcon(
//         AssetImage("assets/dist/DuitNowQR_Primary.png"),
//         size: 30,
//       ),
//       5);

//   const PaymentType(this.name, this.icon, this.value);
//   final String name;
//   final Widget icon;
//   final num value;
// }

class BankType {
  final String code;
  final String name;
  final String type;
  final String url;

  BankType({
    required this.code,
    required this.name,
    required this.type,
    required this.url,
  });
}
