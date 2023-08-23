import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/controller/history_controller.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/language/pull_to_refresh.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/screens/history/history_search.dart';
import 'package:flutterbase/screens/history/pdf_viewer.dart';
import 'package:flutterbase/screens/services/bill_detail.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TransactionHistoriesScreen extends StatefulWidget {
  TransactionHistoriesScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoriesScreen> createState() =>
      TransactionHistoriesScreenState();
}

class TransactionHistoriesScreenState extends State<TransactionHistoriesScreen> {
  final controller = Get.put(HistoryController());
  final RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HistorySearchFilters(controller),
          Expanded(
            child: Obx(() {
              Widget itemList = SizedBox();
              if(controller.searchParams.value.type == "By Transaction") {
                itemList = SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: controller.transactions.hasNextPage,
                  onRefresh: () async {
                    await controller.getData(reset: true, nextPage: false);
                    refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    await controller.getData(reset: false, nextPage: true);
                    refreshController.loadComplete();
                  },
                  header: MyWaterDropHeader(),
                  footer: MyClassicFooter(),
                  controller: refreshController,
                  child: ListView(
                    children: controller.transactions.items.map((item) => TransactionHistory(
                      item,
                      HistoryDetailsController(item),
                    )).toList(),
                  ),
                );
              } else {
                itemList = SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: controller.transactionItems.hasNextPage,
                  onRefresh: () async {
                    await controller.getData(reset: true, nextPage: false);
                    refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    await controller.getData(reset: false, nextPage: true);
                    refreshController.loadComplete();
                  },
                  header: MyWaterDropHeader(),
                  footer: MyClassicFooter(),
                  controller: refreshController,
                  child: ListView(
                    children: controller.transactionItems.items.map((item) => TransactionItemHistories(item)).toList(),
                  ),
                );
              }

              return Stack(
                children: [
                  itemList,
                  if(controller.isLoading.value)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black45
                      ),
                      child: Center(child: DefaultLoadingBar()),
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class TransactionItemHistories extends StatefulWidget {
  final HistoryItem transaction;

  const TransactionItemHistories(this.transaction);

  @override
  State<TransactionItemHistories> createState() => _TransactionItemHistoriesState();
}

class _TransactionItemHistoriesState extends State<TransactionItemHistories> {

  TextStyle get titleStyle => TextStyle(fontSize: 16, color: constants.primaryColor);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.transaction.receiptNumber ?? '-', style: titleStyle,),
              Text("RM " + moneyFormat(widget.transaction.amount)),
            ],
          ),
          SizedBox(height: 4,),
          Row(
            children: [
              Text(dateFormatterDisplay.format(widget.transaction.createdAt), style: TextStyle(fontSize: 14, color: Colors.black54),),
            ],
          ),
        ],
      ),
      expandedAlignment: Alignment.topLeft,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("iPayment Transaction No.".tr),
                    SizedBox(height: 4),
                    Text(widget.transaction.referenceNumber ?? '-', style: TextStyle(color: Colors.black54)),
                    SizedBox(height: 4),
                    if(widget.transaction.billReferenceNumber != null) ...[
                      Text("Agency Reference No.".tr),
                      SizedBox(height: 4),
                      Text(widget.transaction.billReferenceNumber ?? '-', style: TextStyle(color: Colors.black54),),
                      SizedBox(height: 4),
                    ],
                    Text("iPayment Reference No.".tr),
                    SizedBox(height: 4),
                    Text(widget.transaction.billNumber ?? '-', style: TextStyle(color: Colors.black54),),
                    SizedBox(height: 4),
                    Text("Payment Details".tr),
                    SizedBox(height: 4),
                    Text(widget.transaction.detail ?? widget.transaction.paymentDescription ?? '-', style: TextStyle(color: Colors.black54),),
                  ],
                ),
              ),
              if(widget.transaction.billTypeId != 3)
              SizedBox(
                child: IconButton(
                  onPressed: () async {
                    Get.to(() => BillDetailsScreen(), arguments: { 'id': widget.transaction.paymentId! });
                  },
                  icon: Icon(LineIcons.eye, size: 15,),
                ),
              ),
              SizedBox(
                child: IconButton(
                  padding: EdgeInsets.only(right: 8),
                  onPressed: () async {
                    String url = await api.GetDownloadReceipt(widget.transaction.id.toString());
                    if(url.isNotEmpty) {
                      navigate(
                        context,
                        PdfViewer(
                          url: url,
                          pageName: "View receipt".tr,
                        ),
                      );
                    }
                  },
                  icon: Icon(LineIcons.receipt, size: 15,),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class TransactionHistory extends StatefulWidget {
  final History transaction;
  final HistoryDetailsController controller;

  const TransactionHistory(this.transaction, this.controller);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        expandedAlignment: Alignment.topLeft,
        onExpansionChanged: (value) {
          if(value && widget.controller.transactionItems.items.isEmpty) {
            widget.controller.fetch();
          }
        },
        // childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.transaction.referenceNumber ?? '-', style: titleStyle,),
                Text("RM " + moneyFormat(widget.transaction.amount)),
              ],
            ),
            SizedBox(height: 4,),
            Row(
              children: [
                Text(dateFormatterDisplay.format(widget.transaction.createdAt), style: TextStyle(fontSize: 14, color: Colors.black54),),
              ],
            ),
          ],
        ),
        children: [
          Obx(() {
            if(widget.controller.isLoading.value) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: DefaultLoadingBar(),
              );
            }

            return Column(
              children: [
                for(var item in widget.controller.transactionItems.items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Receipt Number".tr),
                              SizedBox(height: 4),
                              Text(item.receiptNumber ?? '-', style: TextStyle(color: Colors.black54)),
                              SizedBox(height: 4),
                              if(item.billReferenceNumber != null) ...[
                                Text("Agency Reference No.".tr),
                                SizedBox(height: 4),
                                Text(item.billReferenceNumber ?? '-', style: TextStyle(color: Colors.black54),),
                                SizedBox(height: 4),
                              ],
                              Text("iPayment Reference No.".tr),
                              SizedBox(height: 4),
                              Text(item.billNumber ?? '-', style: TextStyle(color: Colors.black54),),
                              SizedBox(height: 4),
                              Text("Payment Details".tr),
                              SizedBox(height: 4),
                              Text(item.detail ?? item.paymentDescription ?? '-', style: TextStyle(color: Colors.black54),),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Text('RM ' + moneyFormat(item.amount)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if(item.billTypeId != 3)
                                  SizedBox(
                                    child: IconButton(
                                      onPressed: () async {
                                        Get.to(() => BillDetailsScreen(), arguments: { 'id': item.paymentId! });
                                      },
                                      icon: Icon(LineIcons.eye, size: 15,),
                                    ),
                                  ),
                                SizedBox(
                                  child: IconButton(
                                    padding: EdgeInsets.only(right: 8),
                                    onPressed: () async {
                                      String url = await api.GetDownloadReceipt(item.id.toString());
                                      if(url.isNotEmpty) {
                                        navigate(
                                          context,
                                          PdfViewer(
                                            url: url,
                                            pageName: "View receipt".tr,
                                          ),
                                        );
                                      }
                                    },
                                    icon: Icon(LineIcons.receipt, size: 15,),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 8),
              ],
            );
          }),
        ],
      ),
      // child: ,
    );
  }

  TextStyle get titleStyle => TextStyle(fontSize: 16, color: constants.primaryColor);
}
