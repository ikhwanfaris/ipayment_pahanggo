import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/bills/bills.dart';
import '../../../states/app_state.dart';
import '../../../utils/constants.dart';

class PlaceholderHistoryDetailScreen extends StatefulWidget {
  final enquiryModel2;
  const PlaceholderHistoryDetailScreen(this.enquiryModel2, {super.key});

  @override
  State<PlaceholderHistoryDetailScreen> createState() =>
      _PlaceholderHistoryDetailScreenState();
}

class _PlaceholderHistoryDetailScreenState
    extends State<PlaceholderHistoryDetailScreen> {
  late HistoryItem _enquiryModel3;
  @override
  void initState() {
    super.initState();
    initApp();
  }

  initApp() async {
    // SchedulerBinding.instance
    //     .addPostFrameCallback((_) => showLoadingBar(context));
    setState(() {
      _enquiryModel3 = widget.enquiryModel2;
    });

    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Constants().primaryColor,
          onPressed: () async {
            Navigator.pop(context, true);
          },
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right:55),
            child: Text(
              "Bill Details".tr,
              style: styles.heading5,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                    side: BorderSide(width: 1, color: Colors.green),
                  ),
                  color: Colors.white70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _enquiryModel3.detail.toString() != "null"
                          ? ListTile(
                              title: Text(
                                "Receipt Number".tr,
                                style: styles.heading12bold,
                              ),
                              subtitle: Text(
                                _enquiryModel3.receiptNumber.toString(),
                                style: styles.heading12sub,
                              ),
                            )
                          : Container(),
                      ListTile(
                        title: Text(
                          "Agency Bill Ref. No.".tr,
                          style: styles.heading12bold,
                        ),
                        subtitle: Text(
                          _enquiryModel3.referenceNumber!.toString(),
                          style: styles.heading12sub,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "iPayment Ref. No.".tr,
                          style: styles.heading12bold,
                        ),
                        subtitle: Text(
                          _enquiryModel3.billNumber!.toString(),
                          style: styles.heading12sub,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Bill Reference Date".tr,
                          style: styles.heading12bold,
                        ),
                        subtitle: Text(
                          _enquiryModel3.createdAt.toString() != "null"
                              ? formatDate(
                                  DateTime.parse(
                                      _enquiryModel3.createdAt.toString()),
                                  [dd, '/', mm, '/', yyyy],
                                )
                              : "No date".tr,
                          style: styles.heading12sub,
                        ),
                      ),
                      state.user.firstName!.toUpperCase().toString() +
                                  " " +
                                  state.user.lastName!
                                      .toUpperCase()
                                      .toString() !=
                              _enquiryModel3.userName!.toUpperCase().toString()
                          ? ListTile(
                              title: Text(
                                "Customer Name".tr,
                                style: styles.heading12bold,
                              ),
                              subtitle: Text(
                                _enquiryModel3.userName!.toString(),
                                style: styles.heading12sub,
                              ),
                            )
                          : Container(),
                      _enquiryModel3.amount.toString() != "null"
                          ? ListTile(
                              title: Text(
                                "Amount".tr,
                                style: styles.heading12bold,
                              ),
                              subtitle: Text(
                                "RM " + _enquiryModel3.amount.toString(),
                                style: styles.heading12sub,
                              ),
                            )
                          : Container(),
                      _enquiryModel3.detail.toString() != "null"
                          ? ListTile(
                              title: Text(
                                "Payment Detail".tr,
                                style: styles.heading12bold,
                              ),
                              subtitle: Text(
                                _enquiryModel3.detail.toString(),
                                maxLines: 10,
                                style: styles.heading12sub,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
