import 'package:get/get.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../api/api.dart';
import '../../../../helpers.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/helpers.dart';
import 'package:flutterbase/models/bills/bills.dart' as model;

class BayaranTanpaBillDetail extends StatefulWidget {
  final String amount;
  const BayaranTanpaBillDetail(this.amount, {super.key});

  @override
  State<BayaranTanpaBillDetail> createState() => _BayaranTanpaBillDetailState();
}

class _BayaranTanpaBillDetailState extends State<BayaranTanpaBillDetail> {
  String amount = "";
  List<model.Bills> _enquiryModel2 = [];
  bool isloading = true;
  @override
  void initState() {
    super.initState();
    initApp();
  }

  initApp() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    setState(() {
      amount = widget.amount;
    });
    print(amount);
    _enquiryModel2 = await api.getBillDetail(amount);

    print(_enquiryModel2);
    Future.delayed(const Duration(seconds: 0)).then(
      (value) => setState(
        () {
          isloading = false;
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Bill Details".tr,
          style: styles.heading4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: isloading == false
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    // Text(
                    //   _enquiryModel2[0].billNumber ?? "-",
                    //   style: TextStyle(
                    //       fontSize: 18, color: constants.primaryColor),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        // elevation: 10,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          side: BorderSide(width: 1, color: Colors.black26),
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
                                _enquiryModel2[0]
                                    .service!
                                    .refNoLabel
                                    .toString(),
                                style: styles.heading12bold,
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                                child: Text(
                                  _enquiryModel2[0].referenceNumber ?? "-",
                                  style: styles.heading12sub,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "iPayment Ref. No.".tr,
                                style: styles.heading12bold,
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                                child: Text(
                                  _enquiryModel2[0].billNumber ?? "-",
                                  style: styles.heading12sub,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Service Category".tr,
                                style: styles.heading12bold,
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                                child: Text(
                                  _enquiryModel2[0]
                                          .service
                                          ?.menu
                                          ?.name
                                          .toString() ??
                                      "-",
                                  style: styles.heading12sub,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Payment Details".tr,
                                style: styles.heading12bold,
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                                child: Text(
                                  _enquiryModel2[0].detail ?? "-",
                                  style: styles.heading12sub,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Agency Name".tr,
                                style: styles.heading12bold,
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                                child: Text(
                                  _enquiryModel2[0].agency?.name ?? "-",
                                  style: styles.heading12sub,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Bill Reference Date".tr,
                                style: styles.heading12bold,
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                                child: _enquiryModel2[0].startAt == "" ||
                                        _enquiryModel2[0].startAt.toString() ==
                                            "null"
                                    ? Text(
                                        "No date".tr,
                                        style: styles.heading12sub,
                                      )
                                    : Text(
                                        formatDate(
                                          DateTime.parse(_enquiryModel2[0]
                                              .startAt!
                                              .toString()),
                                          [dd, '/', mm, '/', yyyy],
                                        ),
                                        style: styles.heading12sub,
                                      ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Due On".tr,
                                style: styles.heading12bold,
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                                child: _enquiryModel2[0].endAt.toString() ==
                                            "" ||
                                        _enquiryModel2[0].endAt.toString() ==
                                            "null"
                                    ? Text(
                                        "No date".tr,
                                        style: styles.heading12sub,
                                      )
                                    : Text(
                                        formatDate(
                                          DateTime.parse(
                                              _enquiryModel2[0].endAt!),
                                          [dd, '/', mm, '/', yyyy],
                                        ),
                                        style: styles.heading12sub,
                                      ),
                              ),
                            ),
                            _enquiryModel2[0].identityCodeCategory ==
                                    "Organisasi"
                                ? ListTile(
                                    title: Text(
                                      "Customer Name".tr,
                                      style: styles.heading12bold,
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 8.0, 8.0, 8.0),
                                      child: Text(
                                        _enquiryModel2[0]
                                            .customerName
                                            .toString(),
                                        style: styles.heading12sub,
                                      ),
                                    ),
                                  )
                                : Container(),
                            ListTile(
                              title: Text(
                                "User Category".tr,
                                style: styles.heading12bold,
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                                child: Text(
                                  _enquiryModel2[0].service?.chargedTo ?? "",
                                  style: styles.heading12sub,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Chargelines".tr,
                                style: styles.heading12bold,
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8.0, 8.0, 0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: ListView.builder(
                                    reverse: true,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        _enquiryModel2[0].chargelines!.length,
                                    itemBuilder: (context, index) {
                                      return Text(
                                        _enquiryModel2[0]
                                            .chargelines![index]
                                            .classificationCode!
                                            .description
                                            .toString(),
                                        style: styles.heading12sub,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            _enquiryModel2[0].payments!.length != 0
                                ? ListTile(
                                    title: Text(
                                      "List of bil payments".tr,
                                      style: styles.heading12bold,
                                    ),
                                    subtitle: ListView.builder(
                                      reverse: true,
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          _enquiryModel2[0].payments!.length,
                                      itemBuilder: (context, indexA) {
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Date".tr,
                                                style: styles.heading11bold,
                                              ),
                                              Text(
                                                _enquiryModel2[0]
                                                            .payments![indexA]
                                                            .receiptDocumentDate
                                                            .toString() !=
                                                        'null'
                                                    ? formatDate(
                                                        DateTime.parse(
                                                            _enquiryModel2[0]
                                                                .payments![
                                                                    indexA]
                                                                .receiptDocumentDate
                                                                .toString()),
                                                        [
                                                          dd,
                                                          '/',
                                                          mm,
                                                          '/',
                                                          yyyy
                                                        ],
                                                      )
                                                    : '-',
                                              ),
                                              Text(
                                                "Receipt Number".tr,
                                                style: styles.heading11bold,
                                              ),
                                              Text(
                                                  _enquiryModel2[0]
                                                      .payments![indexA]
                                                      .referenceNumber
                                                      .toString(),
                                                  style: styles.heading11),
                                              Text(
                                                "Amount".tr,
                                                style: styles.heading11bold,
                                              ),
                                              Text(
                                                  "RM " +
                                                      moneyFormat(double.parse(
                                                          _enquiryModel2[0]
                                                              .payments![indexA]
                                                              .amount
                                                              .toString())),
                                                  style: styles.heading11),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Container(),
                            _enquiryModel2[0]
                                        .nettCalculations!
                                        .roundingData
                                        .toString() !=
                                    "null"
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Rounding Value".tr,
                                        style: styles.heading12bold,
                                      ),
                                      Text(
                                        "RM " +
                                            moneyFormat(double.parse(
                                              _enquiryModel2[0]
                                                  .nettCalculations!
                                                  .roundingData!
                                                  .amount
                                                  .toString(),
                                            )),
                                        style: styles.heading12bold,
                                      ),
                                    ],
                                  )
                                : Container(),
                            _enquiryModel2[0].amountChanges!.length != 0
                                ? ListTile(
                                    title: Text(
                                      "List of amount changes".tr,
                                      style: styles.heading12bold,
                                    ),
                                    subtitle: ListView.builder(
                                      reverse: true,
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _enquiryModel2[0]
                                          .amountChanges!
                                          .length,
                                      itemBuilder: (context, indexA) {
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Date".tr,
                                                style: styles.heading11bold,
                                              ),
                                              Text(
                                                  formatDate(
                                                    DateTime.parse(
                                                        _enquiryModel2[0]
                                                            .amountChanges![
                                                                indexA]
                                                            .agencyApprovalDate
                                                            .toString()),
                                                    [dd, '/', mm, '/', yyyy],
                                                  ),
                                                  style: styles.heading11),
                                              Text(
                                                "Reference Number".tr,
                                                style: styles.heading11bold,
                                              ),
                                              Text(
                                                  _enquiryModel2[0]
                                                      .amountChanges![indexA]
                                                      .referenceNumber
                                                      .toString(),
                                                  style: styles.heading11),
                                              Text(
                                                "Amount".tr,
                                                style: styles.heading11bold,
                                              ),
                                              _enquiryModel2[0]
                                                          .amountChanges![
                                                              indexA]
                                                          .amount
                                                          .toString() ==
                                                      "null"
                                                  ? Text(" - ")
                                                  : Text(
                                                      "RM " +
                                                          moneyFormat(
                                                              double.parse(
                                                            _enquiryModel2[0]
                                                                .amountChanges![
                                                                    indexA]
                                                                .amount
                                                                .toString(),
                                                          )),
                                                      style: styles.heading11),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Container(),
                            _enquiryModel2[0].customerNote.toString() ==
                                        "null" ||
                                    _enquiryModel2[0].customerNote.toString() ==
                                        ""
                                ? Container()
                                : ListTile(
                                    title: Text(
                                      "Note to payer".tr,
                                      style: styles.heading12bold,
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 8.0, 8.0, 8.0),
                                      child: Text(
                                        _enquiryModel2[0]
                                            .customerNote
                                            .toString(),
                                        style: styles.heading12sub,
                                      ),
                                    ),
                                  ),

                            // if (controller.bill?.billTypeId == 1)
                            //   ListTile(
                            //     title: Text(
                            //       "Amount Due (after settlement)".tr,
                            //       style: styles.heading10bold,
                            //     ),
                            //     subtitle: Padding(
                            //       padding:
                            //           const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                            //       child: Text(
                            //         "RM ${controller.bill?.nettCalculations?.total ?? 0}",
                            //         style: styles.heading12sub,
                            //       ),
                            //     ),
                            //   ),
                            // ListTile(
                            //   title: Text(
                            //     "Pihak Tanggung Caj",
                            //     style: styles.heading10bold,
                            //   ),
                            //   subtitle: Padding(
                            //     padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                            //     child: Text(
                            //       controller.bill?.service.chargedTo ?? "-",
                            //       style: styles.heading12sub,
                            //     ),
                            //   ),
                            // ),
                            // controller.bill?.service?.chargedTo == "Pelanggan"
                            //     ? ListTile(
                            //         leading: Icon(Icons.info),
                            //         title: Text(
                            //           "(Note: Transaction charge will be borne by customer for this payment.)"
                            //               .tr,
                            //           style: styles.heading10bold,
                            //         ),
                            //       )
                            //     : Container(),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/dist/aduan.svg',
                            height: MediaQuery.of(context).size.width / 3),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            '',
                            style: styles.heading5,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
