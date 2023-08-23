import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/form/widget_menu.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/controller/favorite_controller.dart';
import 'package:flutterbase/controller/home_controller.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/models/bills/favorite.dart';
import 'package:flutterbase/models/users/inbox.dart';
import 'package:flutterbase/screens/home/hebahan_detail.dart';
import 'package:flutterbase/screens/home/menu.dart';
import 'package:flutterbase/screens/profile/send_enquiry/home_enquiry.dart';
import 'package:flutterbase/screens/services/bayaran_tanpa_bill.dart';
import 'package:flutterbase/screens/services/bayaran_tanpa_bill_dan_amaun.dart';
import 'package:flutterbase/screens/home/hebahan.dart';
import 'package:flutterbase/screens/home/favorite_screen.dart';
import 'package:flutterbase/screens/home/tnc.dart';
import 'package:flutterbase/screens/inbox/inbox.dart';
// import 'package:flutterbase/screens/pending_transactions/pending_transactions.dart';
import 'package:flutterbase/screens/search/search.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/screens/home/submenu.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/states/user_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../components/delete_button2.dart';
import '../../../components/primary_button_four.dart';
// import '../../../components/primary_button_two.dart';

// import '../shared/success.dart';

// import '../shared/success.dart';

// import '../inbox/inbox.dart';
// import '../pending_transactions/pending_transactions.dart';

class HomeScreen extends StatefulWidget {
  final TabController? tabController;
  HomeScreen({Key? key, this.tabController}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String billIndividu = '';
String billOrganization = '';
String enquiryActive = '';
String serviceFavourite = '';
String billFavourite = '';
String paymentPending = '';

class _HomeScreenState extends State<HomeScreen> {
  String _tncUpdated = store.getItem('tncUpdatedLS').toString();

  List<FavBill> _enquiryModel2 = [];
  DateTime starttime = DateTime.now();

  final controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    if (_tncUpdated == 'true') {
      _getData();
    }

    _getData2();
    _getWidgetMenu();
  }

  void _getData() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showAlertDialogTnc(context));
    _enquiryModel2 = await api.GetFavBills();
    if (mounted) {
      setState(() {
        _enquiryModel2 = _enquiryModel2;
      });
    }
    print(_enquiryModel2.length.toString());
    await api.getConfigTnc();
  }

  _getData2() async {
    _enquiryModel2 = await api.GetFavBills();
    if (mounted) {
      setState(() {
        _enquiryModel2 = _enquiryModel2;
      });
    }
    print(_enquiryModel2.length.toString());
  }

  _getWidgetMenu() async {
    await api.widgetMenu();
    setState(() {
      billIndividu = store.getItem('bilIndividualLS').toString();
      billOrganization = store.getItem('billOrganizationLS').toString();
      enquiryActive = store.getItem('enquiryActiveLS').toString();
      paymentPending = store.getItem('paymentPendingLS').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Stack(
              children: [
                Material(
                  color: constants.primaryColor,
                  shape: MyShapeBorder(-20),
                  child: Container(
                    height: 20,
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 0,
                  child: SizedBox(
                    height: AppBar().preferredSize.height,
                    width: MediaQuery.of(context).size.width,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [],
                    ),
                  ),
                )
              ],
            ),
            Heading(),
            Padding(
              padding: const EdgeInsets.fromLTRB(12,5,12,12),
              child: ValueListenableBuilder(
                valueListenable: state.value.userState,
                builder:
                    (BuildContext context, UserDataState value, Widget? child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome'.tr, style: styles.heading14sub),
                      SizedBox(height: 10),
                      WidgetMenu(widget.tabController),
                      SizedBox(height: 10),
                      //! Search Bar
                      Row(
                        children: [
                          Expanded(
                            flex: 11,
                            child: GestureDetector(
                              onTap: () => Get.to(
                                () => Search(),
                                duration: Duration(milliseconds: 400),
                                transition: Transition.fadeIn,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Hero(
                                  tag: "search",
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Search Services...".tr,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () => Get.to(
                                () => Search(),
                                duration: Duration(milliseconds: 400),
                                transition: Transition.fadeIn,
                              ),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: constants.fiveColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Icon(getIcon('magnifying-glass'),
                                        color: Colors.white, size: 20),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      //!Close-SeachBar
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Services'.tr, style: styles.titleHome),
                            Text(
                                'Choose a service menu that is listed below or search the related keywords.'
                                    .tr,
                                style: styles.descHome,
                                textAlign: TextAlign.justify),
                            Divider(
                              color: constants.sixColor,
                              thickness: 5,
                              endIndent:
                                  MediaQuery.of(context).size.width / 1.3,
                            ),
                          ],
                        ),
                      ),
                      // ? Menu
                      MainMenu(controller: controller),
                      // Bulletin
                      SizedBox(height: 20),
                      CarouselSlider(
                        carouselController: controller.carousel,
                        options: CarouselOptions(
                          aspectRatio: controller.bulletinList.length > 1
                              ? 22 / 9
                              : 16 / 9,
                          viewportFraction:
                              controller.bulletinList.length > 1 ? 0.8 : 1.0,
                          initialPage: 0,
                          autoPlayInterval: Duration(
                              seconds: controller.bulletinList.isEmpty
                                  ? 0
                                  : controller.bulletinList[0].duration),
                          autoPlay: controller.bulletinList.length == 1
                              ? false
                              : true,
                          enlargeCenterPage:
                              controller.bulletinList.length > 1 ? true : false,
                          enableInfiniteScroll:
                              controller.bulletinList.length > 1 ? true : false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          onPageChanged: (index, reason) {
                            controller.currentSlide.value = index;
                          },
                        ),
                        items: controller.bulletinList.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    width: controller.bulletinList.length > 1
                                        ? MediaQuery.of(context).size.width /
                                            1.4
                                        : MediaQuery.of(context).size.width /
                                            1.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(i.imageUrl!),
                                        fit: controller.bulletinList.length > 1
                                            ? BoxFit.cover
                                            : BoxFit.fill,
                                      ),
                                    ),
                                    // child: Material(
                                    //   color: Colors.transparent,
                                    //   // borderRadius: BorderRadius.circular(14),
                                    //   child: InkWell(
                                    //     // borderRadius: BorderRadius.circular(14),
                                    //     onTap: () {},
                                    //   ),
                                    // ),
                                  ),
                                ],
                              );
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10),
                      //! Indicator carousel
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: controller.bulletinList
                              .asMap()
                              .entries
                              .map((entry) {
                            return GestureDetector(
                              onTap: () {
                                controller.carousel.animateToPage(entry.key);
                              },
                              child: Container(
                                width: 12.0,
                                height: 12.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Constants().primaryColor)
                                      .withOpacity(
                                          controller.currentSlide.value ==
                                                  entry.key
                                              ? 0.9
                                              : 0.4),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Announcements'.tr, style: styles.titleHome),
                          Divider(
                            color: constants.sixColor,
                            thickness: 5,
                            endIndent: MediaQuery.of(context).size.width / 1.3,
                          ),
                        ],
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(12),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.7,
                        ),
                        itemCount: controller.hebahanList.length +
                            1, // Add 1 for the "Show More" card
                        itemBuilder: (context, index) {
                          if (index < controller.hebahanList.length) {
                            var hebahan = controller.hebahanList[index];
                            final starttime = DateTime.parse(controller
                                    .hebahanList[index].createdAt
                                    .toString())
                                .toLocal();
                            return Container(
                              width: MediaQuery.of(context).size.width / 1.4,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Constants().reverseWhiteColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    navigate(
                                        context,
                                        HebahanDetailScreen(
                                            controller.hebahanList,
                                            bulletinId: controller
                                                .hebahanList[index].id));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          hebahan.translatables?.first
                                                  .content ??
                                              "",
                                          style: styles.contentTitle,
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                        Container(
                                          child: Text(
                                            DateFormat('dd/MM/yyyy')
                                                .format(starttime),
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Constants().eightColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            // This is the "Show More" card
                            if (controller.hebahanList.length >= 3) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(12),
                                  color: constants.primaryColor,
                                  dashPattern: [4, 4],
                                  child: Material(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () {
                                        navigate(context, HebahanScreen());
                                      },
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                'assets/dist/see_all.svg',
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    10),
                                            SizedBox(height: 5),
                                            Text(
                                              "See all".tr,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          }
                        },
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

// Terms & condition
  showAlertDialogTnc(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: constants.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Center(
          child: Text(
        'New Terms and Conditions of iPayment'.tr,
        style: styles.raisedButtonTextWhite,
        textAlign: TextAlign.center,
      )),
      content: PrimaryButton4(
        text: 'View terms and conditions'.tr,
        onPressed: () {
          navigate(context, TncScreen());
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: DeleteButton2(
                  onPressed: () => logout(context),
                  text: 'Log Out'.tr,
                ),
              ),
              const SizedBox(width: 5),
              Flexible(
                flex: 1,
                child: PrimaryButton(
                  onPressed: () async {
                    print(store.getItem('tncIdLS'));
                    await api.updateTnc(store.getItem('tncIdLS'));
                    Navigator.pop(context);
                    if (mounted) {
                      setState(() {
                        api.resume();
                      });
                    }
                  },
                  text: 'Accept'.tr,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class WidgetMenu extends StatefulWidget {
  final TabController? tabController;
  WidgetMenu(this.tabController);

  @override
  _WidgetMenuState createState() => _WidgetMenuState();
}

class _WidgetMenuState extends State<WidgetMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: constants.reverseWhiteColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomWidgetMenu(
                      counterTextStyle: styles.widgetMenuCounter,
                      backgroundColor: constants.primaryColor,
                      counter: billIndividu,
                      title: "Individual\n Bill".tr,
                      onTap: () {
                        widget.tabController?.animateTo(1);
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomWidgetMenu(
                      counterTextStyle: styles.widgetMenuCounterWhite,
                      backgroundColor: constants.widgetTwoColor,
                      counter: billOrganization,
                      title: "Organization\n Bill".tr,
                      onTap: () {
                        widget.tabController?.animateTo(1);
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomWidgetMenu(
                      counterTextStyle: styles.widgetMenuCounter,
                      backgroundColor: constants.widgetThreeColor,
                      counter: enquiryActive,
                      title: "Active\n Enquiry".tr,
                      onTap: () {
                        navigate(context, HomeEnquiryScreen());
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(() => CustomWidgetMenu(
                          counterTextStyle: styles.widgetMenuCounterWhite,
                          backgroundColor: constants.widgetThreeColor,
                          counter: favoriteCount.services.value.toString(),
                          title: "Favourite\n Service".tr,
                          onTap: () =>
                              Get.to(() => FavoritesScreen("services")),
                        )),
                  ),
                  Expanded(
                    child: Obx(() => CustomWidgetMenu(
                          counterTextStyle: styles.widgetMenuCounter,
                          backgroundColor: constants.primaryColor,
                          counter: favoriteCount.bills.value.toString(),
                          title: "Favourite\n Bill".tr,
                          onTap: () => Get.to(() => FavoritesScreen('bills')),
                        )),
                  ),
                  Expanded(
                    child: CustomWidgetMenu(
                        counterTextStyle: styles.widgetMenuCounterWhite,
                        backgroundColor: constants.widgetTwoColor,
                        counter: paymentPending,
                        title: "Pending\n Payment".tr,
                        onTap: () {
                          navigate(context, MenuScreen(initalPage: 3, initialHistoryPage: 1));
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Heading extends StatefulWidget {
  Heading({Key? key}) : super(key: key);

  @override
  State<Heading> createState() => _HeadingState();
}

class _HeadingState extends State<Heading> {
  String _token = store.getItem(kStoreUserToken).toString();
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    if (_token.isNotEmpty) {
      isLoggedIn = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: ValueListenableBuilder(
        valueListenable: state.value.userState,
        builder: (BuildContext context, UserDataState value, Widget? child) {
          return Row(
            children: [
              SizedBox(
                width: AppStyles.u1 * 13,
                child: Row(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 8,
                      width: MediaQuery.of(context).size.width / 8,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MenuScreen(initalPage: 4)),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/dist/user_profile_portal.jpg'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(state.user.firstName!,
                    style: styles.heading13Primary),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(() => InboxScreen()),
                    child: SizedBox(
                      child: ValueListenableBuilder(
                        valueListenable: state.value.inboxState,
                        builder: (BuildContext context, List<ServerInbox> value,
                            Widget? child) {
                          var _isNotReadCount =
                              value.where((element) => !element.isRead).length;

                          return value
                                  .where((element) => !element.isRead)
                                  .isNotEmpty
                              ? Stack(children: [
                                  Icon(getIcon('bell-ringing'), size: 30),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: ClipOval(
                                      child: _isNotReadCount == 0
                                          ? null
                                          : Container(
                                              height: 16,
                                              width: 16,
                                              decoration: BoxDecoration(
                                                color: Colors.redAccent,
                                              ),
                                              child: _isNotReadCount > 9
                                                  ? Center(
                                                    child: Text(
                                                        _isNotReadCount
                                                            .toString(),
                                                        style: styles
                                                            .badgeCounterDoubleDigit),
                                                  )
                                                  : Center(
                                                    child: Text(
                                                        _isNotReadCount
                                                            .toString(),
                                                        style: styles
                                                            .badgeCounterDoubleDigit),
                                                  ),
                                            ),
                                    ),
                                  )
                                ])
                              : Icon(getIcon('bell'), size: 30);
                        },
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () => Get.to(() => SuccessPayment(), arguments: {
                  //     "reference_number": "B2303S00141000026",
                  //     "amount": "200.00"
                  //   }),
                  //   child: SizedBox(
                  //     child: ValueListenableBuilder(
                  //       valueListenable: state.value.inboxState,
                  //       builder: (BuildContext context, List<ServerInbox> value,
                  //           Widget? child) {
                  //         return value
                  //                 .where((element) => !element.isRead)
                  //                 .isNotEmpty
                  //             ? Stack(children: const [
                  //                 Icon(LineIcons.envelope),
                  //                 Positioned(
                  //                   top: 0.0,
                  //                   right: 0.0,
                  //                   child: Icon(Icons.brightness_1,
                  //                       size: 8.0, color: Colors.redAccent),
                  //                 )
                  //               ])
                  //             : const Icon(LineIcons.envelopeOpen);
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

class ListFavorite extends StatelessWidget {
  const ListFavorite({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Text(
                "Favorite Service".tr +
                    " (${controller.favoriteServices.where((p0) => p0.service != null).length})",
                style: AppStyles().heading12sub,
              ),
            ),
            controller.favoriteServices.length > 0
                ? TextButton(
                    child: Text(
                      "See all".tr,
                      style:
                          TextStyle(color: constants.primaryColor, height: 2),
                    ),
                    onPressed: () => Get.to(() => FavoritesScreen('services')),
                  )
                : Container(),
          ],
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 260,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              children: [
                Obx(
                  () => Column(
                    children: controller.favoriteServices
                        .where((p0) => p0.service != null)
                        .map((element) => FavoriteTile(favorite: element))
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FavoriteTile extends StatelessWidget {
  const FavoriteTile({
    Key? key,
    required this.favorite,
  }) : super(key: key);

  final Favorite favorite;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        ListTile(
          isThreeLine: false,
          leading: CircleAvatar(
            backgroundColor: Color(0xFFE2EFE8),
            child: Text(
              favorite.service!.name!.split(" ").first.capitalizeFirst![0] +
                  ((favorite.service!.name!.split(" ").asMap().containsKey(1))
                      ? favorite.service!.name!
                          .split(" ")[1]
                          .capitalizeFirst![0]
                      : ""),
              style: TextStyle(color: Color(0xFF8C9791)),
            ),
          ),
          title: Text(
            favorite.service!.name!,
            style: TextStyle(
                color: Color(0xFF282B29), fontWeight: FontWeight.w600),
          ),
          onTap: () async {
            print(jsonEncode(favorite.service));
            switch (favorite.service!.billTypeId) {
              case 1:
                // Get.to(() => BillScreen.BillMainScreen(), arguments: {
                //   "serviceRefNum": favorite.service!.serviceReferenceNumber,
                //   "amountRequired": false
                // });
                break;
              case 2:
                // Get.to(() => BillScreen.BillMainScreen(), arguments: {
                //   "serviceRefNum": favorite.service!.serviceReferenceNumber,
                //   "amountRequired": true
                // });
                break;
              case 3:
                Get.to(() => BayaranTanpaBilServiceScreen(), arguments: {
                  "serviceRefNum": favorite.service!.serviceReferenceNumber,
                  "serviceId": favorite.service!.id,
                  "billType": favorite.service!.billTypeId,
                });
                break;
              case 4:
                Get.to(() => BayaranTanpaBillDanAmaunServiceScreen(),
                    arguments: {
                      "serviceRefNum": favorite.service!.serviceReferenceNumber,
                      "agencyName": favorite.service?.agency.name ?? "",
                    });
                break;
              case 5:
                Get.to(() => BayaranTanpaBilServiceScreen(), arguments: {
                  "serviceRefNum": favorite.service!.serviceReferenceNumber,
                  "serviceId": favorite.service!.id,
                  "billType": favorite.service!.billTypeId,
                });
                break;
              default:
            }
          },
        ),
        Divider(thickness: 1.2, indent: 10, endIndent: 10),
      ],
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _itemsPerPage = 6;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: constants.reverseWhiteColor,
          height: MediaQuery.of(context).size.height / 4.5,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount:
                        (widget.controller.menuList.length / _itemsPerPage)
                            .ceil(),
                    itemBuilder: (context, pageIndex) {
                      final startIndex = pageIndex * _itemsPerPage;
                      final endIndex = (pageIndex + 1) * _itemsPerPage;
                      final pageItems = widget.controller.menuList.sublist(
                        startIndex,
                        endIndex.clamp(0, widget.controller.menuList.length),
                      );

                      return _buildGridView(pageItems);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0;
                          i <
                              (widget.controller.menuList.length /
                                      _itemsPerPage)
                                  .ceil();
                          i++)
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          margin: EdgeInsets.all(4),
                          width: _currentPage.clamp(
                                      0,
                                      (widget.controller.menuList.length /
                                              _itemsPerPage)
                                          .ceil()) ==
                                  i
                              ? 8
                              : 6,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage.clamp(
                                        0,
                                        (widget.controller.menuList.length /
                                                _itemsPerPage)
                                            .ceil()) ==
                                    i
                                ? constants.primaryColor
                                : constants.secondaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildGridView(List<Menu> items) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        childAspectRatio: 1.8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items[index];
        return InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            // store.setItem('fromLoginLS', false);
            // print(store.getItem('fromLoginLS'));
            // log(jsonEncode(item));
            Get.to(() => SubmenuScreen(), arguments: item);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                getIcon(item.iconClass.toString()),
                color: constants.primaryColor,
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Text(
                  widget.controller.handleTranslation(item)?.toTitleCase() ??
                      "N/A",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
