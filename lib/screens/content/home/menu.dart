import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterbase/api/barrel/api_cart.dart';
import 'package:flutterbase/events/event.dart';
import 'package:flutterbase/models/cart/cart_count_response.dart';
import 'package:flutterbase/screens/content/bill/placeholder_bill.dart';
import 'package:flutterbase/screens/content/cart/cart.dart';
import 'package:flutterbase/screens/content/profile/my_profile/profile.dart';
import 'package:flutterbase/screens/content/profile/organization/tab/tab_history.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/states/user_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:get/get.dart';

import 'home.dart';

// ignore: must_be_immutable
class MenuScreen extends StatefulWidget {
  MenuScreen({Key? key, this.initalPage}) : super(key: key);

  int? initalPage = 0;

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  late TabController tabController;

  late StreamSubscription onCartUpdated;
  late Future<CartCountResponse?> cartCountFuture;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    tabController.animateTo(widget.initalPage ?? 0);
    super.initState();

    cartCountFuture = Future.value(null);

    onCartUpdated = eventBus.on<CartUpdatedEvent>().listen((event) {
      setState(() {
        cartCountFuture = ApiCart().getCount();
      });
    });

    // fire once to get latest cart item counts
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => eventBus.fire(
        CartUpdatedEvent(),
      ),
    );
  }

  @override
  void dispose() {
    onCartUpdated.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: state.value.userState,
        builder: (context, UserDataState value, child) {
          if(value.data.id == 0) {
            return HomeScreen();
          }
          return DefaultTabController(
            initialIndex: widget.initalPage ?? 0,
            length: 5,
            child: Scaffold(
              extendBody: false,
              body: TabBarView(
                controller: tabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  HomeScreen(),
                  PlaceholderBillingScreen(),
                  CartScreen(),
                  TabHistoryScreen(),
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
                  controller: tabController,
                  indicatorColor: Colors.transparent,
                  labelColor: constants.primaryColor,
                  unselectedLabelColor: const Color(0xffAAAAAA),
                  labelStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                  ),
                  onTap: (value) {
                    log(value.toString());
                    setState(() {
                      tabController.animateTo(value);
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
                      icon: FutureBuilder<CartCountResponse?>(
                        future: cartCountFuture,
                        builder: (context, future) {
                          if (future.connectionState != ConnectionState.done) {
                            return SizedBox.shrink();
                          }

                          if (future.data == null) {
                            return SizedBox.shrink();
                          }

                          int cartCount = future.data?.count ?? 0;
                          String cartCountText =
                              cartCount > 100 ? "$cartCount+" : "$cartCount";

                          return Stack(children: [
                                  Icon(getIcon('shopping-cart')),
                                  Positioned(
                                    top: 0.0,
                                    right: 0.0,
                                    child: ClipOval(
                                      child: cartCount == 0
                                       ? null 
                                       : Container(
                                          height: 16,
                                          width: 16,
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                          ),
                                          child: cartCount > 9
                                              ? Center(
                                                child: Text(
                                                    cartCountText,
                                                    style: styles
                                                        .badgeCounterDoubleDigit),
                                              )
                                              : Center(
                                                  child: Text(
                                                      cartCountText,
                                                      style: styles
                                                          .badgeCounterDoubleDigit),
                                                ),
                                        ),
                                ),
                              )
                            ],
                          );
                        },
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
