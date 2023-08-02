import 'package:flutter/material.dart';
import 'package:flutterbase/components/field/rounded_amount_input.dart';
import 'package:flutterbase/controller/bill/bill_detail_controller.dart';
import 'package:flutterbase/screens/content/home/menu.dart';
import 'package:flutterbase/components/bottom_bar.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../components/payment_summary.dart';

class BillDetail extends StatelessWidget {
  final controller = Get.put(BillDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf9f9f9),
        appBar: AppBar(
          backgroundColor: Color(0xFFf9f9f9),
          iconTheme: IconThemeData(
            color: constants.primaryColor,
          ),
          title: Center(
            child: Text(
              controller.bill?.service?.name ?? '',
              style: styles.heading5,
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => Get.offAll(() => MenuScreen()),
              icon: Icon(LineIcons.times),
            ),
          ],
        ),
        body: Obx(() => controller.isLoading.value ? Center(
                  child: DefaultLoadingBar(),
                ) : Padding(
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
                            controller.bill?.agency?.ministry.ministryName ?? "-",
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
                            controller.bill?.agency?.department.departmentName ?? "-",
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
                            controller.bill?.agency?.name ?? "-",
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          (controller.bill?.service?.referenceNoLabel ?? '-') != '-' ?
                            controller.bill!.service!.referenceNoLabel! :
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
                            controller.bill?.service?.menu?.name.toString() ??
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
                      ListTile(
                        title: Text(
                          "Bill Reference Date".tr,
                          style: styles.heading10bold,
                        ),
                        subtitle: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            DateFormat.yMd()
                                .format(controller.bill?.startAt ??
                                    DateTime.now())
                                .toString(),
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Payment Due Date".tr,
                          style: styles.heading10bold,
                        ),
                        subtitle: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            DateFormat.yMd()
                                .format(
                                    controller.bill?.endAt ?? DateTime.now())
                                .toString(),
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
                            controller.bill?.service?.chargedTo ?? "",
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
                        if(
                          controller.bill?.billTypeId == 2 ||
                          controller.bill?.billTypeId == 4
                        )
                        RoundedAmountInput("Payment Amount".tr, (amount) => {
                          controller.barController.change(billId:controller.bill!.id, amount)
                        }),
                    ],
                  ),
                ),
                if(controller.bill?.billTypeId == 1)
                  PaymentSummary(controller: controller),
              ],
            ),
          ),
        )),
        bottomNavigationBar: BottomBar(controller.barController),
    );
  }
}
