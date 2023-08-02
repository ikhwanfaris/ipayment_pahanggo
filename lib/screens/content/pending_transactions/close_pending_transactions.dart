import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/payments/payments.dart';
import 'package:flutterbase/screens/content/home/menu.dart';
import 'package:flutterbase/screens/content/home/payment.dart';
import 'package:flutterbase/screens/content/pending_transactions/pending_transaction_details.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import '../../../components/primary_button_three.dart';
import '../../../utils/helpers.dart';
import 'package:flutterbase/models/bills/bills.dart' as model;

// class ClosePendingTransactions extends StatelessWidget {

class ClosePendingTransactions extends StatefulWidget {
  @override
  State<ClosePendingTransactions> createState() => _ClosePendingTransactionsState();
}

class _ClosePendingTransactionsState extends State<ClosePendingTransactions> {
  // List<Incomplete> _enquiryModel2 = [];
  List<model.Incomplete> _enquiryModel2 = [];

  // ignore: unused_field
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    print("yessss");
    _enquiryModel2 = await api.GetIncomplete();
    setState(() {
      _enquiryModel2 = _enquiryModel2;
    });

    Future.delayed(const Duration(seconds: 0)).then(
      (value) => setState(
        () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: constants.primaryColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
         title: Center(
          child: Padding(
            padding: const EdgeInsets.only(left:55),
            child: Text(
              "Pending Transaction".tr,
              style: styles.heading1sub,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => MenuScreen()),
            icon: Icon(LineIcons.times),
          ),
        ],
       ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _enquiryModel2.isEmpty
                  ? Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width / 3),
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/dist/aduan.svg',
                                height: MediaQuery.of(context).size.width / 3),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                'You have no pending transaction.'.tr,
                                style: styles.heading5,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _enquiryModel2.length,
                //  _organizationModel.length,
                itemBuilder: (context, index) {
                  return _enquiryModel2[index].status! == "Incomplete" ||
                          _enquiryModel2[index].status! == "Cancelled" ||
                          _enquiryModel2[index].status! == "Failed"
                      ? Dismissible(
                          key: Key('${_enquiryModel2[index].id}'),
                          background: Container(
                            color: Colors.red.shade400,
                            child: LineIcon.trash(
                              color: Colors.white,
                            ),
                          ),
                          confirmDismiss: (direction) => onConfirmDismiss(
                              direction, _enquiryModel2[index]),
                          onDismissed: (direction) {
                            onConfirmDismiss(direction, _enquiryModel2[index]);
                          },
                          child: Card(
                            elevation: 0,
                            color: Color(0xFFF5F6F9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Text(
                                        //   _enquiryModel2[0]['bill']
                                        //           ['reference_number']
                                        //       .toString(),
                                        //   style: styles.heading6bold,
                                        // ),

                                        _enquiryModel2[index].referenceNumber !=
                                                null
                                            ? Text(
                                                _enquiryModel2[index]
                                                    .referenceNumber
                                                    .toString(),
                                                style: styles.heading6bold,
                                              )
                                            : Text("No Reference Number"),
                                        Row(
                                          children: [
                                            _enquiryModel2[index]
                                                        .status
                                                        ?.toLowerCase()
                                                        .toString() !=
                                                    "pending"
                                                ? SizedBox(
                                                    width: 80,
                                                    child: PrimaryButton3(
                                                      onPressed: () {
                                                        print(_enquiryModel2[
                                                                index]
                                                            .items
                                                            ?.length
                                                            .toString());
                                                        billDetails(
                                                            _enquiryModel2[
                                                                index]);

                                                        print(billDetails(
                                                            _enquiryModel2[
                                                                index]));
                                                      },
                                                      text: 'Pay'.tr,
                                                    ),
                                                  )
                                                : Container(),
                                            // Padding(
                                            //   padding: const EdgeInsets.all(1.0),
                                            //   child: IconButton(
                                            //     icon: Icon(Icons.delete_forever),
                                            //     color: Constants().primaryColor,
                                            //     onPressed: () async {
                                            //       await api.cancelPayemnt(
                                            //           _enquiryModel2[index]
                                            //               .referenceNumber
                                            //               .toString());
                                            //       snack(context,
                                            //           "Successfully deleted.".tr);
                                            //       await _getData();
                                            //     },
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Total Amount'.tr + ":"),
                                            // Text('iPayment Bill Ref. No.'.tr + ":"),
                                            Text(
                                                'Bill Reference Date'.tr + ":"),
                                            Text('Status'.tr + ":"),
                                            // Text('Items :'),
                                            // Text('Count :'),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'RM ' +
                                                  moneyFormat(double.parse(
                                                      _enquiryModel2[index]
                                                          .amount
                                                          .toString())),
                                            ),
                                            // _enquiryModel2[index]
                                            //             .transactionReference !=
                                            //         null
                                            //     ? Text(
                                            //         _enquiryModel2[index]
                                            //             .transactionReference
                                            //             .toString(),
                                            //       )
                                            //     : Text("Tiada No Rujukan"),
                                            Text(
                                              formatDate(
                                                DateTime.parse(
                                                    _enquiryModel2[index]
                                                        .createdAt
                                                        .toString()),
                                                [dd, '/', mm, '/', yyyy],
                                              ),
                                            ),
                                            //Tak translate lagi
                                            Text(fixStatus(
                                                _enquiryModel2[index].status!)),
                                            // Text(
                                            //   _enquiryModel2[index]
                                            //       .items!
                                            //       .length
                                            //       .toString(),
                                            // ),
                                            // Text(
                                            //   index.toString(),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : _enquiryModel2[index].status! == "Pending"
                          ? Card(
                              elevation: 0,
                              color: Color(0xFFF5F6F9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Text(
                                          //   _enquiryModel2[0]['bill']
                                          //           ['reference_number']
                                          //       .toString(),
                                          //   style: styles.heading6bold,
                                          // ),

                                          _enquiryModel2[index]
                                                      .referenceNumber !=
                                                  null
                                              ? Text(
                                                  _enquiryModel2[index]
                                                      .referenceNumber
                                                      .toString(),
                                                  style: styles.heading6bold,
                                                )
                                              : Text("No Reference Number"),
                                          Row(
                                            children: [
                                              _enquiryModel2[index]
                                                          .status
                                                          ?.toLowerCase()
                                                          .toString() !=
                                                      "pending"
                                                  ? SizedBox(
                                                      width: 80,
                                                      child: PrimaryButton3(
                                                        onPressed: () {
                                                          print(_enquiryModel2[
                                                                  index]
                                                              .items
                                                              ?.length
                                                              .toString());
                                                          billDetails(
                                                              _enquiryModel2[
                                                                  index]);
                                                        },
                                                        text: 'Pay'.tr,
                                                      ),
                                                    )
                                                  : Container(),
                                              // Padding(
                                              //   padding: const EdgeInsets.all(1.0),
                                              //   child: IconButton(
                                              //     icon: Icon(Icons.delete_forever),
                                              //     color: Constants().primaryColor,
                                              //     onPressed: () async {
                                              //       await api.cancelPayemnt(
                                              //           _enquiryModel2[index]
                                              //               .referenceNumber
                                              //               .toString());
                                              //       snack(context,
                                              //           "Successfully deleted.".tr);
                                              //       await _getData();
                                              //     },
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Total Amount'.tr + ":"),
                                              // Text('iPayment Bill Ref. No.'.tr + ":"),
                                              Text('Bill Reference Date'.tr +
                                                  ":"),
                                              Text('Status'.tr + ":"),
                                              // Text('Items :'),
                                              // Text('Count :'),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                                   Text(
                                                'RM ' +
                                                    moneyFormat(double.parse(
                                                        _enquiryModel2[index]
                                                            .amount
                                                            .toString())),
                                              ),
                                              // _enquiryModel2[index]
                                              //             .transactionReference !=
                                              //         null
                                              //     ? Text(
                                              //         _enquiryModel2[index]
                                              //             .transactionReference
                                              //             .toString(),
                                              //       )
                                              //     : Text("Tiada No Rujukan"),
                                              Text(
                                                formatDate(
                                                  DateTime.parse(
                                                      _enquiryModel2[index]
                                                          .createdAt
                                                          .toString()),
                                                  [dd, '/', mm, '/', yyyy],
                                                ),
                                              ),
                                              //Tak translate lagi
                                              Text(fixStatus(
                                                  _enquiryModel2[index]
                                                      .status!)),
                                              // Text(
                                              //   _enquiryModel2[index]
                                              //       .items!
                                              //       .length
                                              //       .toString(),
                                              // ),
                                              // Text(
                                              //   index.toString(),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  billDetails(enquiryModel2) async {
    // ignore: unused_local_variable
    bool init = await navigate(context, PendingDetailsScreen(enquiryModel2));
    if (init) _getData();
  }

  Future<bool?> onConfirmDismiss(direction, item) async {
    return confirmDeleteCart(item);
  }

  Future<bool?> confirmDeleteCart(model.Incomplete item) async {
    var isDeleted = true;
    var isConfirm = await appDialogDelete(
      "Are you sure to cancel this transaction ?".tr,
      "Would you like to continue delete this cart item?".tr,
    );

    xlog(isConfirm.toString());

    if (isConfirm != true) {
      return false;
    }

    await api.cancelPayemnt(item.referenceNumber.toString());
    snack(context, "Successfully deleted.".tr);
    await _getData();

    return isDeleted;
  }

  Future? b() {
    print("b");
    return null;
  }
}

pay(_enquiryModel2) async {
  bool? value = await Get.defaultDialog<bool>(
    radius: 14,
    title: "",
    titlePadding: EdgeInsets.zero,
    content: Column(
      children: [
        Icon(
          Icons.info,
          color: constants.eightColor,
          size: 50,
        ),
        SizedBox(height: 10),
        Text(
          "Teruskan Pembayaran ? ",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
        Text(
          "Anda akan dibawa ke halaman gerbang pembayaran kami.",
          textAlign: TextAlign.center,
        ),
      ],
    ),
    // middleText: "Teruskan Pembayaran?",
    textConfirm: "Ya",
    confirmTextColor: Colors.white,
    textCancel: "Tidak",
    contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 20),
    onConfirm: () => Get.back(result: true),
  );

  if (value != null) {
    List checkout = [];

    Map transactionItems = {
      "items": {
        _enquiryModel2.referenceNumber: [
          {
            "unit": "1",
            "price": double.parse(_enquiryModel2.amount.toString()),
            "title": "Kadar (RM)",
            "quantity": 1,
            "total_price": _enquiryModel2.amount.toString()
          }
        ]
      },
      "bill_id": null,
      "service_id": _enquiryModel2.serviceId,
      "payment_description": _enquiryModel2.referenceNumber,
      "extra_fields": {"type": "date", "value": ""},
      "amount": _enquiryModel2.amount.toString()
    };
    checkout.add(transactionItems);

    print(jsonEncode([transactionItems]));
    ErrorResponse response = await api.payments(
      PaymentsRequest(
          amount: _enquiryModel2.amount!.toString(),
          source: "mobile",
          transactionItems: jsonEncode([transactionItems]),
          paymentMethod: _enquiryModel2.payment_method,
          referenceNumber: _enquiryModel2.transaction_reference),
    );
    print("response.data");
    print(response.data);
    Get.to(() => Payment(), arguments: response.data["redirect"]);
  }
}

class BillTile extends StatelessWidget {
  const BillTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("1.", style: TextStyle(fontSize: 16)),
              SizedBox(width: 8),
              Chip(
                backgroundColor: Color(0xFFD0E7DC),
                label: Text(
                  "Organisasi",
                  style: TextStyle(
                    color: Color(0xFF34A36D),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Chip(
                backgroundColor: Color(0xFFFFDADA),
                label: Text(
                  "Accepted - Forward",
                  style: TextStyle(
                    color: Color(0xFFFF5354),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("PENDIDIKAN", style: TextStyle(color: Colors.grey)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Taska As-Syifa Malaysia",
                style: TextStyle(color: Colors.black, fontSize: 18)),
          ),
          SizedBox(height: 10),
          BillDetail(title: 'No. Rujukan Bill', detail: 'A00000'),
          BillDetail(title: 'No. Rujukan iPayment', detail: 'IP001222289'),
          BillDetail(title: 'Tarikh Ruj. Bill', detail: 'A00000'),
          BillDetail(title: 'Tarikh Akhir Bayaran', detail: 'A00000'),
          BillDetail(title: 'Jumlah Bayaran', detail: 'A00000'),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  LineIcons.edit,
                  color: constants.primaryColor,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: Get.width * 0.3,
                height: 50,
                child: PrimaryButton(
                  text: "Bayar",
                  onPressed: () {},
                ),
              )
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}

class BillDetail extends StatelessWidget {
  const BillDetail({
    Key? key,
    required this.title,
    required this.detail,
  }) : super(key: key);

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 4),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Text(
              title,
              style: TextStyle(fontSize: 15),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              ":",
              style: TextStyle(fontSize: 15),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              detail,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
