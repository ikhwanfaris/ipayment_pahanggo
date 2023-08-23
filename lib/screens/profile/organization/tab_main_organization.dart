import 'package:flutter/material.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/models/organizations/organization.dart';
import 'package:flutterbase/screens/profile/organization/tab/detail_organization.dart';
import 'package:flutterbase/screens/profile/organization/tab/view_member.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';

class TabMainOrganizationScreen extends StatefulWidget {
  final Organization organization;
  const TabMainOrganizationScreen(this.organization, {Key? key})
      : super(key: key);

  @override
  State<TabMainOrganizationScreen> createState() =>
      _TabMainOrganizationScreenState();
}

class _TabMainOrganizationScreenState extends State<TabMainOrganizationScreen>
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
                  text: 'Detail'.tr,
                ),
                Tab(
                  text: 'Members'.tr,
                ),
              ],
            ),
              Expanded(
                child: TabBarView(
                    controller: _tabController,
                    children: [
                      DetailOrganizationScreen(widget.organization),
                      ViewMemberScreen(widget.organization),
                    ],
                  ),
              ),
            ],
          ),
          ),
    );
  }
}
