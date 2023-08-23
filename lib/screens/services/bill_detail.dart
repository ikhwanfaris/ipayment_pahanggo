import 'package:flutter/material.dart';
import 'package:flutterbase/components/field/rounded_amount_input.dart';
import 'package:flutterbase/components/loading_blocker.dart';
import 'package:flutterbase/controller/bill/bill_detail_controller.dart';
import 'package:flutterbase/components/bottom_bar.dart';
import 'package:flutterbase/controller/favorite_controller.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../../components/payment_summary.dart';

class BillDetailsScreen extends StatefulWidget {
  @override
  State<BillDetailsScreen> createState() => _BillDetailsScreenState();
}

class _BillDetailsScreenState extends State<BillDetailsScreen> {
  late BillDetailController controller;
  double amount = 0;

  @override
  initState() {
    var args = Get.arguments as Map<String, dynamic>;
    if(args.containsKey('amount')) {
      amount = args['amount'];
    }
    controller = Get.put(BillDetailController(amount: amount));
    super.initState();
    loadingBlocker.bind(controller.isLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf9f9f9),
        appBar: AppBar(
          backgroundColor: Color(0xFFf9f9f9),
          iconTheme: IconThemeData(
            color: constants.primaryColor,
          ),
          title: Obx(() => controller.isLoading.value ? SizedBox() : Center(
            child: Text(
              controller.bill?.service.name ?? '',
              style: styles.heading5,
            ),
          )),
          elevation: 0,
          actions: [
            Obx(() => controller.isLoading.value ? SizedBox() : IconButton(
              onPressed: () async {
                controller.bill!.isFavorite.value = !controller.bill!.isFavorite.value;
                if(controller.bill!.isFavorite.value) {
                  await favorites.addFavorite(billId: controller.bill!.id, context: context);
                } else {
                  await favorites.removeFavorite(billId: controller.bill!.id, context: context);
                }
              },
              icon: controller.bill!.isFavorite.value ? Icon(Icons.favorite) : Icon(LineIcons.heart),
            )),
          ],
        ),
        body: Obx(() => controller.isLoading.value ? SizedBox() : !controller.bill!.canView ? Container(
                  child: Center(child: Text('You do not have access to this record.'.tr))
                )  : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                    side: BorderSide(width: 1, color: Colors.black12),
                  ),
                  color: constants.paleWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          "Ministry".tr,
                          style: styles.heading10bold,
                        ),
                        subtitle: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            controller.bill?.agency.ministry.ministryName ?? "-",
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Department".tr,
                          style: styles.heading10bold,
                        ),
                        subtitle: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            controller.bill?.agency.department.departmentName ?? "-",
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Agency".tr,
                          style: styles.heading10bold,
                        ),
                        subtitle: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            controller.bill?.agency.name ?? "-",
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Service".tr,
                              style: styles.heading10bold,
                            ),
                              Pill(
                                child: Text(
                                  (controller.bill?.service.status ?? '-') == 'Disahkan' ? 'Aktif' : 'Tidak Aktif',
                                  style: TextStyle(color: Colors.white, fontSize: 10),
                                ),
                              ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            controller.bill?.service.name ?? "-",
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      if(controller.bill?.referenceNumber != null)
                        ListTile(
                          title: Text(
                            (controller.bill?.service.refNoLabel ?? '-') != '-' ?
                              controller.bill!.service.refNoLabel! :
                              "Agency Bill Ref. No.".tr,
                            style: styles.heading10bold,
                          ),
                          subtitle: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                            child: Text(
                              controller.bill?.referenceNumber ?? "-",
                              style: styles.heading12sub,
                            ),
                          ),
                        ),
                      ListTile(
                        title: Text(
                          "iPayment Ref. No.".tr,
                          style: styles.heading10bold,
                        ),
                        subtitle: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            controller.bill?.billNumber.toString() ?? "-",
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Service Category".tr,
                          style: styles.heading10bold,
                        ),
                        subtitle: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            controller.bill?.service.menu?.name.toString() ??
                                "-",
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Payment Details".tr,
                          style: styles.heading10bold,
                        ),
                        subtitle: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            controller.bill?.detail ?? "-",
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      if(controller.bill?.billDate != null)
                        ListTile(
                          title: Text(
                            "Bill Reference Date".tr,
                            style: styles.heading10bold,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                            child: Text(
                              dateFormatterDisplay.format(controller.bill!.billDate!),
                              style: styles.heading12sub,
                            ),
                          ),
                        ),
                      if(controller.bill?.startAt != null)
                        ListTile(
                          title: Text(
                            "Payment Start Date".tr,
                            style: styles.heading10bold,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                            child: Text(
                              dateFormatterDisplay.format(controller.bill!.startAt!),
                              style: styles.heading12sub,
                            ),
                          ),
                        ),
                      if(controller.bill?.endAt != null)
                      ListTile(
                        title: Text(
                          "Payment Due Date".tr,
                          style: styles.heading10bold,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            dateFormatterDisplay.format(controller.bill!.endAt!),
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      if(controller.bill?.customerNote != null)
                        ListTile(
                          title: Text(
                            "Customer Note".tr,
                            style: styles.heading10bold,
                          ),
                          subtitle: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                            child: Text(
                              controller.bill?.customerNote ?? "",
                              style: styles.heading12sub,
                            ),
                          ),
                        ),
                      ListTile(
                        title: Text(
                          "Charged To".tr,
                          style: styles.heading10bold,
                        ),
                        subtitle: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            controller.bill?.service.chargedTo ?? "",
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Status".tr,
                          style: styles.heading10bold,
                        ),
                        subtitle: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            (controller.bill?.status ?? '-') == 'Aktif' ? 'Aktif' : 'Tidak Aktif',
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      (controller.bill!.canPay && (controller.bill!.billTypeId == 2 || controller.bill!.billTypeId == 4)) ?
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: RoundedAmountInput("Payment Amount".tr, (amount) => {
                            controller.barController.change(billId:controller.bill!.id, amount)
                          }, initialValue: amount, autoFocus: false,),
                        )
                      : SizedBox(height: 10),
                    ],
                  ),
                ),
                if(
                  [1, 5].contains(controller.bill?.billTypeId)
                )
                  PaymentSummary(controller: controller),
              ],
            ),
          ),
        )),
        bottomNavigationBar: BottomBar(controller.barController),
    );
  }
}

class Pill extends StatelessWidget {
  final Widget child;
  final Color color;

  const Pill({super.key, required this.child, this.color = const Color(0XFFF045B62)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: color,
        ),
        child: child,
      ),
    );
  }
}
