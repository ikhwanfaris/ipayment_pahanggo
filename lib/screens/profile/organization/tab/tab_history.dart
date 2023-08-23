import 'package:flutter/material.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/screens/history/transaction_history.dart';
import 'package:flutterbase/screens/pending_transactions/pending_transactions.dart';
import 'package:get/get.dart';

class TabHistoryScreen extends StatefulWidget {
  final int initialPage;

  const TabHistoryScreen({Key? key, this.initialPage = 0}) : super(key: key);

  @override
  State<TabHistoryScreen> createState() => _TabHistoryScreenState();
}

class _TabHistoryScreenState extends State<TabHistoryScreen>
    with TickerProviderStateMixin {
  // int tabIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialPage);

    _tabController.addListener(() {
      setState(() {
        // tabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const curveHeight = -20.0;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          shape: const MyShapeBorder(curveHeight),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Column(
          children: [
            TabBar(
              indicatorWeight: 5.0,
              controller: _tabController,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: 'Complete'.tr,
                ),
                Tab(
                  text: 'Pending'.tr,
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  TransactionHistoriesScreen(),
                  PendingTransactions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
