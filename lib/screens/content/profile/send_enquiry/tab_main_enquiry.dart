import 'package:flutter/material.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/screens/content/profile/send_enquiry/home_enquiry.dart';
import 'package:flutterbase/screens/content/profile/send_enquiry/reassign_enquiry.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';

class TabMainEnquiryScreen extends StatefulWidget {

  const TabMainEnquiryScreen({Key? key})
      : super(key: key);

  @override
  State<TabMainEnquiryScreen> createState() =>
      _TabMainEnquiryScreenState();
}

class _TabMainEnquiryScreenState extends State<TabMainEnquiryScreen>
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
          // automaticallyImplyLeading: false,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      body: (!isOnline)
          ? Center(
              child: !isOnline
                  ? const Text('Offline')
                  :  Center(child: Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.width / 1.7),
                    child: DefaultLoadingBar(),
                  ),))
          : Column(
            children: [
              TabBar(
              indicatorWeight: 5.0,
              controller: _tabController,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: 'List'.tr,
                ),
                Tab(
                  text: 'Reassign'.tr,
                ),
              ],
            ),
              Expanded(
                child: TabBarView(
                    controller: _tabController,
                    children: [
                      HomeEnquiryScreen(),
                      ReassignEnquiryScreen(),
                    ],
                  ),
              ),
            ],
          ),
          ),
    );
  }
}
