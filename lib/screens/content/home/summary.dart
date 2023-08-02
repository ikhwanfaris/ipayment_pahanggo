// import 'dart:developer';

import 'package:date_format/date_format.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/controller/bill/bayaran_tanpa_bill_controller.dart';
import 'package:flutterbase/controller/summary_controller.dart';
import 'package:flutterbase/screens/content/home/menu.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../models/contents/bank.dart';

class Summary extends StatelessWidget {
  final controller = Get.put(SummaryController());

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
            "Payment Summary".tr,
            style: styles.heading5,
          ),
        ),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            // ignore: unrelated_type_equality_checks
            if (controller.billType == 5) {
              Get.find<BayaranTanpaBillController>().total.value =
                  controller.jumlah.value;
            }
            Get.back();
          },
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => MenuScreen()),
            icon: Icon(LineIcons.times),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                controller.title,
                style: TextStyle(fontSize: 18, color: constants.primaryColor),
              ),
              ExtraFieldsForm(controller: controller),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Obx(() {
                      List<Widget> children = [SizedBox(height: 5)];
                      for (var i = 0;
                          i < controller.summaryDetails.length;
                          i++) {
                        children.add(
                          SummaryTile(
                            total: controller.jumlah,
                            onChangeAmaun: controller.billType.value == 2 ||
                                    controller.billType.value == 4
                                ? controller.onChangeAmaun
                                : null,
                            amaunController: controller.billType.value == 2 ||
                                    controller.billType.value == 4
                                ? controller.totalBilTanpaAmaun[i]
                                : null,
                            summary: controller.summaryDetails[i],
                            billTypeId: controller.billType.value,
                          ),
                        );
                        // children.add(SizedBox(height: 10));
                        // if (i != controller.summaryDetails.length - 1) {
                        //   children.addAll([
                        //     DottedLine(dashColor: Colors.grey.shade300),
                        //     SizedBox(height: 10)
                        //   ]);
                        // }
                      }
                      children.add(SizedBox(height: 10));

                      // return Column(
                      //   children: children,
                      // );
                      // if (controller.billType.value == 5) {
                      //   List<Widget> children = [SizedBox(height: 5)];
                      //   for (var product in controller.products) {
                      //     if (product.select == true) {
                      //       children.add(Text(product.name + " 5"));
                      //     }

                      // for (var subitem in matrix.subitems) {
                      //   children.add(Text(subitem.headers.last.name ?? ""));
                      //   for (var quantity in subitem.quantities) {
                      //     children.add(Row(
                      //       mainAxisAlignment:
                      //           MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Column(
                      //           children: [
                      //             Text(quantity.rate.title ?? ""),
                      //             Text(quantity.unit.value ?? ""),
                      //           ],
                      //         ),
                      //         Row(
                      //           children: [
                      //             Text(quantity.amount.toString()),
                      //             Text("x RM ${quantity.rate.value}"),
                      //           ],
                      //         ),
                      //       ],
                      //     ));
                      //   }
                      // }
                      //   }
                      // }
                      return Column(
                        children: children,
                      );
                    }),
                    DottedLine(
                        dashColor: Colors.grey.shade300, dashGapLength: 0),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          "Payment Total".tr,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Obx(
                          () => Text(
                            "RM ${controller.jumlah.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              RingkasanBayaran(controller: controller)
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: PrimaryButton(
            onPressed: () => controller.pay(),
            text: "Pay".tr,
          ),
        ),
      ),
    );
  }
}

class RingkasanBayaran extends StatelessWidget {
  const RingkasanBayaran({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SummaryController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: Get.width * 0.9,
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            color: constants.secondaryColor,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Payment Summary".tr,
            //   style: TextStyle(color: constants.primaryColor),
            // ),
            // SizedBox(height: 15),
            // Row(
            //   children: [
            //     Text(
            //       "Actual Amount".tr,
            //       style: TextStyle(fontSize: 18),
            //     ),
            //     Spacer(),
            //     Obx(
            //       () => (controller.actualAmount.value != "")
            //           ? Text(
            //               "RM${controller.actualAmount.value}",
            //               style: TextStyle(fontSize: 18),
            //             )
            //           : Container(),
            //     )
            //   ],
            // ),
            SizedBox(height: 10),
            Obx(
              () => (controller.roundingAmount.value != "")
                  ? Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Adjustment amount".tr,
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              width: Get.width * 0.6,
                              child: Text(
                                "The amount is adjusted based on the Malaysia Treasury Circular."
                                    .tr,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(
                          "RM${controller.roundingAmount.value}",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    )
                  : Container(),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   child: DottedLine(),
            // ),
            // Row(
            //   children: [
            //     Text(
            //       "Payment Total".tr,
            //       style: TextStyle(fontSize: 18),
            //     ),
            //     Spacer(),
            //     Obx(
            //       () => Text(
            //         "RM${controller.jumlah.toStringAsFixed(2)}",
            //         style: TextStyle(fontSize: 18),
            //       ),
            //     )
            //   ],
            // ),
            // SizedBox(height: 10),
            // DottedLine(dashColor: Colors.white, dashGapLength: 0),
            // SizedBox(height: 20),
            Text(
              "Choose Payment Method".tr,
              style: TextStyle(color: constants.primaryColor),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: constants.secondaryColor.shade100,
                  borderRadius: BorderRadius.circular(10)),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  // Flexible(
                  //   flex: 1,
                  //   fit: FlexFit.tight,
                  //   child:
                  //       Obx(() => controller.paymentType.value.icon),
                  // ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 5,
                    child: Obx(
                      () => Text(
                        controller
                            .setupGatewayName(controller.paymentType.value),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: IconButton(
                      onPressed: () {
                        Get.bottomSheet(
                          PaymentTypeList(controller: controller),
                          isScrollControlled: true,
                        );
                      },
                      icon: Icon(Icons.edit_outlined),
                      color: constants.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => (controller.paymentType.value.id == 2)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "List of Banks/E-wallet".tr,
                          style: TextStyle(color: constants.primaryColor),
                        ),
                        // Container(
                        //   margin: EdgeInsets.symmetric(vertical: 10),
                        //   padding: EdgeInsets.symmetric(horizontal: 10),
                        //   decoration: BoxDecoration(
                        //       color: constants.secondaryColor.shade100,
                        //       borderRadius: BorderRadius.circular(10)),
                        //   child: Row(
                        //     children: [
                        //       SizedBox(width: 10),
                        //       Icon(Icons.location_city_rounded),
                        //       SizedBox(width: 10),
                        //       Expanded(
                        //         child: Obx(
                        //           () => DropdownButton<BankType>(
                        //             value: controller.selectedBank.value,
                        //             isExpanded: true,
                        //             items: controller.listDropdown,
                        //             onChanged: (value) {
                        //               controller.selectedBank.value = value!;
                        //             },
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          decoration: BoxDecoration(
                            color: Constants().secondaryColor,
                            border: Border.all(
                              color: Constants().secondaryColor,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 6,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 1.0),
                                  child: SizedBox(
                                    height: 300,
                                    child: ListView(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(1.0),
                                          child: Column(
                                            children: <Widget>[
                                              TypeAheadFormField(
                                                  textFieldConfiguration:
                                                      TextFieldConfiguration(
                                                    controller: controller
                                                        .typeAheadController,
                                                    decoration: InputDecoration(
                                                        labelText: controller
                                                            .bankText.value),
                                                  ),
                                                  suggestionsCallback:
                                                      (pattern) {
                                                    return controller
                                                        .getSuggestions(
                                                      pattern,
                                                    );
                                                  },
                                                  itemBuilder:
                                                      (context, suggestion) {
                                                    return ListTile(
                                                      title: Text(
                                                        suggestion.toString(),
                                                      ),
                                                    );
                                                  },
                                                  transitionBuilder: (context,
                                                      suggestionsBox,
                                                      controller) {
                                                    return suggestionsBox;
                                                  },
                                                  onSuggestionSelected:
                                                      (suggestion) {
                                                    controller
                                                            .typeAheadController
                                                            .text =
                                                        suggestion.toString();

                                                    controller.bank.value =
                                                        suggestion.toString();

                                                    print(" ad " +
                                                        suggestion.toString());

                                                    controller.cor.value = [];
                                                    controller.ret.value = [];

                                                    for (var v = 0;
                                                        v <
                                                            controller
                                                                .enquiryModel4
                                                                .length;
                                                        v++) {
                                                      for (var q = 0;
                                                          q <
                                                              controller
                                                                  .enquiryModel4[
                                                                      v]
                                                                  .redirectUrls!
                                                                  .length;
                                                          q++) {
                                                        if (controller
                                                                .enquiryModel4[
                                                                    v]
                                                                .name ==
                                                            suggestion
                                                                .toString()) {
                                                          print("yes");
                                                          print(controller
                                                              .enquiryModel4[v]
                                                              .name);
                                                          if (controller
                                                                  .enquiryModel4[
                                                                      v]
                                                                  .redirectUrls![
                                                                      q]
                                                                  .type
                                                                  .toString() ==
                                                              "RET") {
                                                            controller.ret.add(
                                                              Bank(
                                                                active: true,
                                                                code: controller
                                                                    .enquiryModel4[
                                                                        v]
                                                                    .code,
                                                                name: controller
                                                                    .enquiryModel4[
                                                                        v]
                                                                    .name,
                                                                redirectUrls: [
                                                                  RedirectUrl(
                                                                      type: controller
                                                                          .enquiryModel4[
                                                                              v]
                                                                          .redirectUrls![
                                                                              q]
                                                                          .type,
                                                                      url: controller
                                                                          .enquiryModel4[
                                                                              v]
                                                                          .redirectUrls![
                                                                              q]
                                                                          .url)
                                                                ],
                                                              ),
                                                            );
                                                          }
                                                          if (controller
                                                                  .enquiryModel4[
                                                                      v]
                                                                  .redirectUrls![
                                                                      q]
                                                                  .type
                                                                  .toString() ==
                                                              "COR") {
                                                            controller.cor.add(
                                                              Bank(
                                                                active: true,
                                                                code: controller
                                                                    .enquiryModel4[
                                                                        v]
                                                                    .code,
                                                                name: controller
                                                                    .enquiryModel4[
                                                                        v]
                                                                    .name,
                                                                redirectUrls: [
                                                                  RedirectUrl(
                                                                      type: controller
                                                                          .enquiryModel4[
                                                                              v]
                                                                          .redirectUrls![
                                                                              q]
                                                                          .type,
                                                                      url: controller
                                                                          .enquiryModel4[
                                                                              v]
                                                                          .redirectUrls![
                                                                              q]
                                                                          .url)
                                                                ],
                                                              ),
                                                            );
                                                          }
                                                        }
                                                      }
                                                    }
                                                    print(
                                                        "ret.length.toString()" +
                                                            controller
                                                                .ret.length
                                                                .toString());
                                                    print(
                                                        "cor.length.toString()" +
                                                            controller
                                                                .cor.length
                                                                .toString());
                                                    print(
                                                        "controller.bank.toString() " +
                                                            controller.bank
                                                                .toString());
                                                  },
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please select a bank';
                                                    }
                                                    return 'Please select a bank';
                                                  },
                                                  onSaved: (value) {
                                                    print(value.toString());

                                                    controller.selectedCity =
                                                        value!;

                                                    print(controller
                                                        .selectedCity
                                                        .toString());
                                                  }),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Text("Retail"),
                                                controller.ret.length > 0
                                                    ? Container(
                                                        color: Colors.white,
                                                        width: 150,
                                                        child: ListView.builder(
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: controller
                                                              .ret.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return ListTile(
                                                              title: Text(
                                                                  controller
                                                                      .ret[
                                                                          index]
                                                                      .name),
                                                              onTap: () {
                                                                print(controller
                                                                    .ret[index]
                                                                    .name);
                                                                print(controller
                                                                    .ret[index]
                                                                    .redirectUrls!
                                                                    .first
                                                                    .type
                                                                    .toString());
                                                                controller.bank
                                                                        .value =
                                                                    controller
                                                                        .ret[
                                                                            index]
                                                                        .name
                                                                        .toString();
                                                                controller
                                                                        .bankCode
                                                                        .value =
                                                                    controller
                                                                        .ret[
                                                                            index]
                                                                        .code
                                                                        .toString();
                                                                controller
                                                                        .bankLink
                                                                        .value =
                                                                    controller
                                                                        .ret[
                                                                            index]
                                                                        .redirectUrls!
                                                                        .last
                                                                        .url
                                                                        .toString();
                                                                controller
                                                                        .bankType
                                                                        .value =
                                                                    controller
                                                                        .ret[
                                                                            index]
                                                                        .redirectUrls!
                                                                        .first
                                                                        .type
                                                                        .toString();
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 150,
                                                        child: ListTile(
                                                          title: Text(""),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text("Corporate"),
                                                controller.cor.length > 0
                                                    ? Container(
                                                        color: Colors.white,
                                                        width: 150,
                                                        child: ListView.builder(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: controller
                                                              .cor.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return ListTile(
                                                              title: Text(
                                                                  controller
                                                                      .cor[
                                                                          index]
                                                                      .name),
                                                              onTap: () {
                                                                print(controller
                                                                    .cor[index]
                                                                    .name);
                                                                print(controller
                                                                    .cor[index]
                                                                    .redirectUrls!
                                                                    .first
                                                                    .type
                                                                    .toString());
                                                                controller.bank
                                                                        .value =
                                                                    controller
                                                                        .cor[
                                                                            index]
                                                                        .name
                                                                        .toString();
                                                                controller
                                                                        .bankCode
                                                                        .value =
                                                                    controller
                                                                        .cor[
                                                                            index]
                                                                        .code
                                                                        .toString();
                                                                controller
                                                                        .bankLink
                                                                        .value =
                                                                    controller
                                                                        .cor[
                                                                            index]
                                                                        .redirectUrls!
                                                                        .last
                                                                        .url
                                                                        .toString();
                                                                controller
                                                                        .bankType
                                                                        .value =
                                                                    controller
                                                                        .cor[
                                                                            index]
                                                                        .redirectUrls!
                                                                        .first
                                                                        .type
                                                                        .toString();
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 150,
                                                        child: ListTile(
                                                          title: Text(""),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // ignore: unrelated_type_equality_checks
                                        controller.bank != ""
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text("Anda memilih : "),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(controller.bank +
                                                            " "),
                                                        Text(controller.bankType
                                                                    .toString() ==
                                                                "RET"
                                                            ? "Retail"
                                                            : controller.bankType
                                                                        .toString() ==
                                                                    "COR"
                                                                ? "Corporate"
                                                                : ""),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}

class PaymentTypeList extends StatelessWidget {
  const PaymentTypeList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SummaryController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 200),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //       vertical: 15.0),
            //   child: Text(
            //     "Payment Options",
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            // ),
            AppBar(
              backgroundColor: constants.secondaryColor,
              centerTitle: true,
              leading: Container(),
              title: Text(
                "Payment Options".tr,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.close_rounded),
                )
              ],
            ),

            ListView(
              shrinkWrap: true,
              children: [
                for (var payment in controller.paymentGateways)
                  ListTile(
                    leading: payment.logo != null
                        ? Image.network(
                            "https://internal-ipayment.anm.gov.my/storage/" +
                                payment.logo,
                            // width: 60,
                            // height: 50,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Icon(
                                Icons.money,
                                size: 30,
                              );
                            },
                          )
                        : Container(
                            width: 1,
                            height: 1,
                          ),
                    title: Text(controller.setupGatewayName(payment)),
                    onTap: () {
                      controller.paymentType.value = payment;
                      Get.back();
                    },
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SummaryTile extends StatelessWidget {
  SummaryTile({
    Key? key,
    required this.summary,
    required this.billTypeId,
    required this.total,
    this.amaunController,
    this.onChangeAmaun,
  }) : super(key: key);

  final SummaryDetail summary;
  final int billTypeId;
  final RxNum total;
  final Function(String)? onChangeAmaun;
  final TextEditingController? amaunController;
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    print("billTypeId: $billTypeId");
    // print("AMAUN: ${amaunController!.text}");
    return summary.title != ""
        ? Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    flex: billTypeId == 5 ? 90 : 5,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          summary.title,
                          style: TextStyle(fontSize: 16),
                        ),
                        (summary.subTitle != null)
                            ? billTypeId == 5
                                ? Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      "RM " + summary.subTitle!,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : billTypeId == 3
                                    ? Text(
                                        summary.subTitle ?? "",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      )
                                    : Text(
                                        summary.subTitle ?? "",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      )
                            : Container(),
                        (summary.subsubTitle!.length > 0)
                            ? SizedBox(
                                height: 50,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: summary.subsubTitle!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Row(
                                      children: [
                                        Text(summary.subsubTitle![index].name!),
                                        if (index > 0) Text(" >")
                                      ],
                                    );
                                  },
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                  billTypeId == 2 || billTypeId == 4
                      ? Flexible(
                          flex: 3,
                          child: TextField(
                            enabled: billTypeId == 4 ? false : true,
                            controller: amaunController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(prefixText: "RM "),
                            onChanged: (value) {
                              String newValue =
                                  value.replaceAll(',', '').replaceAll('.', '');
                              if (value.isEmpty || newValue == '00') {
                                amaunController?.clear();
                                isFirst = true;
                                // total.value = 0;
                                return;
                              }
                              double value1 = double.parse(newValue);
                              if (!isFirst) value1 = value1 * 100;
                              value = NumberFormat.currency(
                                      customPattern: '######.##')
                                  .format(value1 / 100);

                              amaunController?.value = TextEditingValue(
                                text: value,
                                selection: TextSelection.collapsed(
                                  offset: value.length,
                                ),
                              );
                              onChangeAmaun!(value);
                            },
                          ),
                        )
                      : Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: Obx(
                            () => summary.total.toStringAsFixed(2) != "0.00"
                                ? Text(
                                    textAlign: TextAlign.end,
                                    "RM ${summary.total.toStringAsFixed(2)}",
                                    style: TextStyle(fontSize: 16),
                                  )
                                : Text(""),
                          ),
                        ),
                ],
              ),
              SizedBox(height: 15),
              for (var itemQty in summary.itemQtys)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemQty.name,
                    ),
                    Flex(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      children: [
                        // Flexible(
                        //   flex: 4,
                        //   fit: FlexFit.tight,
                        //   child: Text(
                        //     itemQty.a,
                        //     style: TextStyle(color: Colors.grey),
                        //   ),
                        // ),
                        SizedBox(width: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Obx(
                            () => Text(
                              "${itemQty.amount} X ",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Text(
                            "RM ${itemQty.price}",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
            ],
          )
        : Container();
  }
}

class ExtraFieldsForm extends StatelessWidget {
  const ExtraFieldsForm({
    super.key,
    required this.controller,
  });

  final SummaryController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: controller.extraFields.map(
          (element) {
            print(element.type.toString());
            if (element.type.toString() == "textarea" ||
                element.type.toString() == "text") {
              print(element.value.value.text.toString());
            }
            // print(element.value.text.value.toString());
            switch (element.type) {
              case "date":
                return Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        element.source.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        formatDate(
                          DateTime.parse(element.value.toString()),
                          [dd, '/', mm, '/', yyyy],
                        ),
                      ),
                    ],
                  ),
                );
              case "textarea":
                return Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        element.source.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        element.value.value.text.toString(),
                      ),
                    ],
                  ),
                );
              case "text":
                return Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        element.source.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        element.value.value.text.toString(),
                      ),
                    ],
                  ),
                );
              default:
                return Container();
            }
          },
        ).toList(),
      ),
    );
  }
}
