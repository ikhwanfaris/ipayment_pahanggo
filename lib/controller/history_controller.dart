

import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:get/get.dart';

class HistoryDetailsController extends RxController {
  final History history;
  RxBool isLoading = false.obs;

  HistoryDetailsController(this.history);

  HistoryItemList transactionItems = HistoryItemList();

  Future fetch() async {
    isLoading.value = true;
    transactionItems.clear();
    await api.GetTransactionItems(history.id!, transactionItems);
    isLoading.value = false;
  }
}

class HistoryController extends RxController {
  RxBool isLoading = true.obs;
  TextEditingController searchTextController = TextEditingController();
  HistoryList transactions = HistoryList();
  HistoryItemList transactionItems = HistoryItemList();
  DateTime? fromDate;
  DateTime? toDate;
  TextEditingController fromTextController = TextEditingController();
  TextEditingController toTextController = TextEditingController();
  String type = "By Transaction";
  Rx<HistorySearchParams> searchParams = Rx(HistorySearchParams("By Transaction", '', null, null));

  @override
  void onInit() {
    super.onInit();
    getData();

    debounce(
      searchParams,
      (_) => getData(reset: true),
      time: Duration(milliseconds: 0)
    );
  }

  getData({
    bool reset = false,
    bool nextPage = false,
  }) async {
    isLoading.value = true;
    if(searchParams.value.type == "By Transaction") {
      await api.GetPaymentHistoryByTransaction(searchParams.value, transactions, reset: reset, nextPage: nextPage);
    } else {
      await api.GetPaymentHistoryByTransactionItem(searchParams.value, transactionItems, reset: reset, nextPage: nextPage);
    }

    isLoading.value = false;
  }

  Future<String> getPdfUrl() async {
    return '';
    // return await api.GetPaymentHistoryByTransactionItem(searchParams.value);
  }

  void setSearchType(String type) {
    this.type = type;
    searchParams.value = HistorySearchParams(
      type,
      searchTextController.text,
      fromDate,
      toDate,
    );
  }

  void setSearchQuery(String search) {
    searchParams.value = HistorySearchParams(
      type,
      searchTextController.text,
      fromDate,
      toDate,
    );
  }

  void setSearchFromDate(DateTime? fromDate) {
    this.fromDate = fromDate;
    searchParams.value = HistorySearchParams(
      type,
      searchTextController.text,
      fromDate,
      toDate,
    );
    print(searchParams.value.from);
  }

  void setSearchToDate(DateTime? toDate) {
    this.toDate = toDate;
    searchParams.value = HistorySearchParams(
      type,
      searchTextController.text,
      fromDate,
      toDate,
    );
  }

  void resetSearch() {
    searchTextController.clear();
    fromTextController.clear();
    toTextController.clear();
    fromDate = null;
    toDate = null;
    searchParams.value = HistorySearchParams(
      type,
      searchTextController.text,
      fromDate,
      toDate,
    );
  }
}
