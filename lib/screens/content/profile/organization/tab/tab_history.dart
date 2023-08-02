import 'package:flutter/material.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/screens/content/history/placeholder_history.dart';
import 'package:flutterbase/screens/content/pending_transactions/pending_transactions.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';

class TabHistoryScreen extends StatefulWidget {
  const TabHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TabHistoryScreen> createState() => _TabHistoryScreenState();
}

class _TabHistoryScreenState extends State<TabHistoryScreen>
    with TickerProviderStateMixin {
  bool isOnline = true;
  bool showLoader = true;

  int tabIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        tabIndex = _tabController.index;
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
        body: (!isOnline)
            ? Center(
                child: !isOnline
                    ? const Text('Offline')
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width / 1.7),
                          child: DefaultLoadingBar(),
                        ),
                      ))
            : Column(
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
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        PlaceholderHistoryScreen(),
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
