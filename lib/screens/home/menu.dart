import 'package:flutter/material.dart';
import 'package:flutterbase/controller/cart_counter_controller.dart';
import 'package:flutterbase/screens/bill/bills.dart';
// import 'package:flutterbase/screens/bill/placeholder_bill.dart';
import 'package:flutterbase/screens/cart/cart.dart';
import 'package:flutterbase/screens/profile/my_profile/profile.dart';
import 'package:flutterbase/screens/profile/organization/tab/tab_history.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/states/user_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:get/get.dart';

import '../bill/placeholder_bill.dart';
import 'home.dart';

// ignore: must_be_immutable
class MenuScreen extends StatefulWidget {
  final int initialHistoryPage;
  MenuScreen({Key? key, this.initalPage, this.initialHistoryPage = 0})
      : super(key: key);

  int? initalPage = 0;

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

late TabController mainTabController;

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  int initialHistoryPage = 0;

  @override
  void initState() {
    initialHistoryPage = widget.initialHistoryPage;
    mainTabController = TabController(length: 5, vsync: this);
    mainTabController.animateTo(widget.initalPage ?? 0);
    cartCount.refreshCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: state.value.userState,
        builder: (context, UserDataState value, child) {
          // if(value.data.id == 0) {
          //   return HomeScreen();
          // }
          return DefaultTabController(
            initialIndex: widget.initalPage ?? 0,
            length: 5,
            child: Scaffold(
              extendBody: false,
              body: TabBarView(
                controller: mainTabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  HomeScreen(tabController: mainTabController),
                  PlaceholderBillingScreen(),
                  // BillsScreen(),
                  CartScreen(),
                  TabHistoryScreen(initialPage: initialHistoryPage),
                  ProfileScreen(),
                ],
              ),
              bottomNavigationBar: Container(
                padding: const EdgeInsets.only(bottom: 15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: TabBar(
                  controller: mainTabController,
                  indicatorColor: Colors.transparent,
                  labelColor: constants.primaryColor,
                  unselectedLabelColor: const Color(0xffAAAAAA),
                  labelStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                  ),
                  onTap: (value) {
                    setState(() {
                      initialHistoryPage = 0;
                      mainTabController.animateTo(value);
                    });
                  },
                  tabs: [
                    Tab(
                      icon: Icon(getIcon('house')),
                      text: 'Main'.tr,
                    ),
                    Tab(
                      icon: Icon(getIcon('article')),
                      text: 'Bill'.tr,
                    ),
                    Tab(
                      icon: Stack(
                        children: [
                          Icon(getIcon('shopping-cart')),
                          Obx(() => Positioned(
                                top: 0.0,
                                right: 0.0,
                                child: ClipOval(
                                  child: cartCount.count.value == 0
                                      ? null
                                      : Container(
                                          height: 16,
                                          width: 16,
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                          ),
                                          child: cartCount.count.value > 9
                                              ? Center(
                                                  child: Text(
                                                      cartCount.toString(),
                                                      style: styles
                                                          .badgeCounterDoubleDigit),
                                                )
                                              : Center(
                                                  child: Text(
                                                      cartCount.toString(),
                                                      style: styles
                                                          .badgeCounterDoubleDigit),
                                                ),
                                        ),
                                ),
                              )),
                        ],
                      ),
                      text: 'Cart'.tr,
                    ),
                    Tab(
                      icon: Icon(getIcon('files')),
                      text: 'Payment'.tr,
                    ),
                    Tab(
                      icon: Icon(getIcon('user')),
                      text: 'Profile'.tr,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
