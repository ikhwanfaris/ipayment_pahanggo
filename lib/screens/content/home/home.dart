import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
// import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/api/barrel/barrel.dart';
// import 'package:flutterbase/components/delete_button.dart';
import 'package:flutterbase/components/form/widget_menu.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/controller/home_controller.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/bills/bills.dart' as model;
import 'package:flutterbase/models/contents/favorite.dart';
import 'package:flutterbase/models/models.dart';
import 'package:flutterbase/models/users/inbox.dart';
import 'package:flutterbase/screens/content/bill/bill_details.dart';
import 'package:flutterbase/screens/content/bill/placeholder_bill.dart';
import 'package:flutterbase/screens/content/home/bill/bill.dart' as BillScreen;
import 'package:flutterbase/screens/content/home/bill/bayaran_tanpa_bill.dart';
import 'package:flutterbase/screens/content/home/bill/bayaran_tanpa_bill_dan_amaun.dart';
import 'package:flutterbase/screens/content/home/hebahan/hebahan.dart';
import 'package:flutterbase/screens/content/home/favorite_service.dart';
import 'package:flutterbase/screens/content/home/tnc.dart';
import 'package:flutterbase/screens/content/inbox/inbox.dart';
import 'package:flutterbase/screens/content/pending_transactions/pending_transactions.dart';
import 'package:flutterbase/screens/content/search/search.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/screens/content/home/submenu.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/states/user_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:intl/intl.dart';

import 'package:flutterbase/events/event.dart';

import '../../../components/delete_button2.dart';
import '../../../components/primary_button_four.dart';
// import '../../../components/primary_button_two.dart';
import '../profile/send_enquiry/tab_main_enquiry.dart';

// import '../shared/success.dart';

// import '../shared/success.dart';

// import '../inbox/inbox.dart';
// import '../pending_transactions/pending_transactions.dart';

part 'parts/cart_button.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

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

  List<model.FavBills> _enquiryModel2 = [];
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
    // SchedulerBinding.instance
    //     .addPostFrameCallback((_) => showAlertDialogTnc(context));
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
      serviceFavourite = store.getItem('serviceFavouriteLS').toString();
      billFavourite = store.getItem('billFavouriteLS').toString();
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
              padding: const EdgeInsets.fromLTRB(10, 10, 22, 10),
              child: ValueListenableBuilder(
                valueListenable: state.value.userState,
                builder:
                    (BuildContext context, UserDataState value, Widget? child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome'.tr, style: styles.heading14sub),
                      SizedBox(height: 10),
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
                      SizedBox(height: 10),
                      //! Widget
                      WidgetMenu(),
                      //!Closed-Widget
                      Padding(
                        padding: const EdgeInsets.all(16),
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
                              endIndent: 250,
                            ),
                          ],
                        ),
                      ),
                      // ? Menu
                      MainMenu(controller: controller),
                      // Bulletin
                      SizedBox(height: 10),
                      CarouselSlider(
                        carouselController: controller.carousel,
                        options: CarouselOptions(
                          aspectRatio: 22 / 9,
                          // viewportFraction: 0.2,
                          initialPage: 0,
                          autoPlayInterval: Duration(seconds: 3),
                          // autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlay: controller.bulletinList.length == 1
                              ? false
                              : true,
                          enlargeCenterPage: true,
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
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(i.imageUrl!),
                                          fit: BoxFit.scaleDown),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      // borderRadius: BorderRadius.circular(14),
                                      child: InkWell(
                                        // borderRadius: BorderRadius.circular(14),
                                        onTap: () {},
                                      ),
                                    ),
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
                      //! Closed-Indicator carousel

                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10),
                      //   child: Image.asset('assets/dist/home_header_cut.jpg'),
                      // ),

                      // ? Perkhidmatan kegemaran
                      // _token == 'null'
                      //     ? Container()
                      //     : ListFavorite(controller: controller),
                      // SizedBox(height: 10),
                      // _token == 'null'
                      //     ? Container()
                      //     : Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             "Favorite Bills".tr +
                      //                 " (" +
                      //                 _enquiryModel2.length.toString() +
                      //                 ")",
                      //             style: AppStyles().heading12sub,
                      //           ),
                      //           _enquiryModel2.length > 0
                      //               ? TextButton(
                      //                   child: Text(
                      //                     "See all".tr,
                      //                     style: TextStyle(
                      //                         color: constants.primaryColor,
                      //                         height: 2),
                      //                   ),
                      //                   onPressed: () {
                      //                     store.setItem('fromLoginLS', false);
                      //                     Get.to(
                      //                         () => FavoriteService("Bills"));
                      //                   })
                      //               : Container(),
                      //         ],
                      //       ),

                      // ! Bil kegemaran
                      // _token == 'null'
                      //     ? Container()
                      //     : _enquiryModel2.length > 0
                      //         ? ConstrainedBox(
                      //             constraints: BoxConstraints(
                      //               maxHeight: 260,
                      //             ),
                      //             child: Container(
                      //               margin: const EdgeInsets.symmetric(
                      //                   vertical: 20),
                      //               color: Colors.white,
                      //               child: ListView.builder(
                      //                 physics: AlwaysScrollableScrollPhysics(),
                      //                 shrinkWrap: true,
                      //                 itemCount: _enquiryModel2.length,
                      //                 //  _organizationModel.length,
                      //                 itemBuilder: (context, index) {
                      //                   return Card(
                      //                     elevation: 0,
                      //                     color:
                      //                         _enquiryModel2[index].payment !=
                      //                                     null &&
                      //                                 _enquiryModel2[index]
                      //                                         .payment!
                      //                                         .status ==
                      //                                     "Aktif"
                      //                             ? Color(0xFFF5F6F9)
                      //                             : Colors.grey,
                      //                     shape: RoundedRectangleBorder(
                      //                       borderRadius:
                      //                           BorderRadius.circular(8),
                      //                     ),
                      //                     child: Padding(
                      //                       padding: const EdgeInsets.all(10),
                      //                       child: Container(
                      //                         child: Column(
                      //                           crossAxisAlignment:
                      //                               CrossAxisAlignment.start,
                      //                           children: [
                      //                             // for (var item in bills)
                      //                             Row(
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment.end,
                      //                               children: [
                      //                                 Padding(
                      //                                   padding:
                      //                                       const EdgeInsets
                      //                                           .all(8.0),
                      //                                   child: IconButton(
                      //                                     icon: Icon(
                      //                                         Icons.visibility),
                      //                                     color: Constants()
                      //                                         .primaryColor,
                      //                                     onPressed: () async {
                      //                                       billDetails(
                      //                                           _enquiryModel2[
                      //                                                   index]
                      //                                               .payment);
                      //                                     },
                      //                                   ),
                      //                                 ),
                      //                                 Padding(
                      //                                   padding:
                      //                                       const EdgeInsets
                      //                                           .all(8.0),
                      //                                   child: IconButton(
                      //                                     icon: Icon(
                      //                                         Icons.favorite),
                      //                                     color: Constants()
                      //                                         .primaryColor,
                      //                                     onPressed: () async {
                      //                                       await api.favABill(
                      //                                           _enquiryModel2[
                      //                                                   index]
                      //                                               .billId
                      //                                               .toString());
                      //                                       snack(
                      //                                           context,
                      //                                           "Successfully removed from favorites list."
                      //                                               .tr,
                      //                                           level: SnackLevel
                      //                                               .Success);

                      //                                       await _getData2();
                      //                                     },
                      //                                   ),
                      //                                 ),
                      //                                 _enquiryModel2[index]
                      //                                                 .payment !=
                      //                                             null &&
                      //                                         _enquiryModel2[
                      //                                                     index]
                      //                                                 .payment!
                      //                                                 .status ==
                      //                                             "Aktif"
                      //                                     ? Padding(
                      //                                         padding:
                      //                                             const EdgeInsets
                      //                                                 .all(8),
                      //                                         child: IconButton(
                      //                                           icon: Icon(Icons
                      //                                               .shopping_cart),
                      //                                           color: Constants()
                      //                                               .primaryColor,
                      //                                           onPressed:
                      //                                               () async {
                      //                                             print(_enquiryModel2[
                      //                                                     index]
                      //                                                 .payment!
                      //                                                 .billTypeId
                      //                                                 .toString());
                      //                                             if (_enquiryModel2[index]
                      //                                                         .payment !=
                      //                                                     null &&
                      //                                                 _enquiryModel2[index]
                      //                                                         .payment!
                      //                                                         .billTypeId ==
                      //                                                     1) {
                      //                                               double
                      //                                                   sum2 =
                      //                                                   0.0;
                      //                                               sum2 = double.parse(_enquiryModel2[
                      //                                                       index]
                      //                                                   .payment!
                      //                                                   .nettCalculations!
                      //                                                   .total
                      //                                                   .toString());
                      //                                               print(sum2
                      //                                                   .toString());
                      //                                               String? a =
                      //                                                   await confirmAddtoCart(
                      //                                                 context,
                      //                                                 sum2,
                      //                                                 [
                      //                                                   RichText(
                      //                                                     textAlign:
                      //                                                         TextAlign.center,
                      //                                                     text:
                      //                                                         TextSpan(
                      //                                                       style:
                      //                                                           const TextStyle(
                      //                                                         fontSize: 16.0,
                      //                                                         color: Colors.black,
                      //                                                       ),
                      //                                                       children: [
                      //                                                         TextSpan(
                      //                                                           text: "Jumlah bil ke troli ialah RM " + sum2.toStringAsFixed(2).toString(),
                      //                                                           style: TextStyle(
                      //                                                             color: constants.primaryColor,
                      //                                                             fontWeight: FontWeight.bold,
                      //                                                           ),
                      //                                                         ),
                      //                                                       ],
                      //                                                     ),
                      //                                                   ),
                      //                                                 ],
                      //                                               );
                      //                                               print("a");
                      //                                               print(a);
                      //                                               if (a ==
                      //                                                   'yes') {
                      //                                                 List a = [
                      //                                                   {
                      //                                                     "service_id":
                      //                                                         null,
                      //                                                     "bill_id": _enquiryModel2[index]
                      //                                                         .payment!
                      //                                                         .id,
                      //                                                     "amount": _enquiryModel2[index]
                      //                                                         .payment!
                      //                                                         .nettCalculations!
                      //                                                         .total!
                      //                                                         .toStringAsFixed(2)
                      //                                                         .toString(),
                      //                                                     "details":
                      //                                                         {}
                      //                                                   },
                      //                                                 ];
                      //                                                 ErrorResponse
                      //                                                     response =
                      //                                                     await api.addToCartIkhwan(
                      //                                                         "",
                      //                                                         "",
                      //                                                         "",
                      //                                                         "",
                      //                                                         jsonEncode(a));
                      //                                                 print(
                      //                                                     "response.data");
                      //                                                 print(response
                      //                                                     .message);
                      //                                                 print(response
                      //                                                     .data);
                      //                                                 print(response
                      //                                                     .isSuccessful);
                      //                                                 if (response
                      //                                                         .isSuccessful ==
                      //                                                     true) {
                      //                                                   snack(
                      //                                                       context,
                      //                                                       "Added to cart successfully.".tr);
                      //                                                 }
                      //                                                 await _getData2();
                      //                                               }
                      //                                             } else if (_enquiryModel2[index]
                      //                                                         .payment !=
                      //                                                     null &&
                      //                                                 _enquiryModel2[index]
                      //                                                         .payment!
                      //                                                         .billTypeId ==
                      //                                                     2) {
                      //                                               bool a = await navigate(
                      //                                                   context,
                      //                                                   TestingBill2(
                      //                                                       _enquiryModel2[index]));
                      //                                               if (a) {
                      //                                                 _getData2();
                      //                                               }
                      //                                             }
                      //                                           },
                      //                                         ),
                      //                                       )
                      //                                     : Container(),
                      //                               ],
                      //                             ),
                      //                             Row(
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment
                      //                                       .spaceBetween,
                      //                               children: [
                      //                                 _enquiryModel2[index]
                      //                                             .payment !=
                      //                                         null
                      //                                     ? Text(
                      //                                         _enquiryModel2[
                      //                                                 index]
                      //                                             .payment!
                      //                                             .referenceNumber
                      //                                             .toString(),
                      //                                         style: styles
                      //                                             .heading6bold,
                      //                                       )
                      //                                     : Text(
                      //                                         "No Reference Number"
                      //                                             .tr),
                      //                                 _enquiryModel2[index]
                      //                                             .payment !=
                      //                                         null
                      //                                     ? Text(
                      //                                         "RM " +
                      //                                             moneyFormat(
                      //                                                 double
                      //                                                     .parse(
                      //                                               _enquiryModel2[
                      //                                                       index]
                      //                                                   .payment!
                      //                                                   .nettCalculations!
                      //                                                   .total
                      //                                                   .toString(),
                      //                                             )),
                      //                                         style: styles
                      //                                             .heading12bold,
                      //                                       )
                      //                                     : Text(
                      //                                         "No Nett Amount"),
                      //                               ],
                      //                             ),
                      //                             SizedBox(height: 10),
                      //                             Row(
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment
                      //                                       .spaceBetween,
                      //                               children: [
                      //                                 Expanded(
                      //                                   flex: 2,
                      //                                   child: Column(
                      //                                     crossAxisAlignment:
                      //                                         CrossAxisAlignment
                      //                                             .start,
                      //                                     children: [
                      //                                       Text(
                      //                                           'iPayment Ref. No.'
                      //                                                   .tr +
                      //                                               ':'),
                      //                                       Text(
                      //                                           'Bill Reference Date'
                      //                                                   .tr +
                      //                                               ':'),
                      //                                       Text('Status'.tr +
                      //                                           ":"),
                      //                                       // Text('Pihak Tanggung Caj :'),
                      //                                     ],
                      //                                   ),
                      //                                 ),
                      //                                 Column(
                      //                                   crossAxisAlignment:
                      //                                       CrossAxisAlignment
                      //                                           .end,
                      //                                   children: [
                      //                                     _enquiryModel2[index]
                      //                                                 .payment !=
                      //                                             null
                      //                                         ? Text(
                      //                                             _enquiryModel2[
                      //                                                     index]
                      //                                                 .payment!
                      //                                                 .billNumber
                      //                                                 .toString(),
                      //                                           )
                      //                                         : Text(
                      //                                             "No bill number"
                      //                                                 .tr,
                      //                                           ),
                      //                                     Text(
                      //                                       formatDate(
                      //                                         DateTime.parse(
                      //                                             _enquiryModel2[
                      //                                                     index]
                      //                                                 .createdAt
                      //                                                 .toString()),
                      //                                         [
                      //                                           dd,
                      //                                           '/',
                      //                                           mm,
                      //                                           '/',
                      //                                           yyyy
                      //                                         ],
                      //                                       ),
                      //                                     ),
                      //                                     _enquiryModel2[index]
                      //                                                     .payment !=
                      //                                                 null &&
                      //                                             _enquiryModel2[
                      //                                                         index]
                      //                                                     .payment!
                      //                                                     .status ==
                      //                                                 "Aktif"
                      //                                         ? Text(
                      //                                             _enquiryModel2[
                      //                                                     index]
                      //                                                 .payment!
                      //                                                 .status
                      //                                                 .toString())
                      //                                         : Text("Inactive"
                      //                                             .tr),

                      //                                     // Text(
                      //                                     //   _enquiryModel2[index]
                      //                                     //       .service!
                      //                                     //       .chargedTo!
                      //                                     //       .toString(),
                      //                                     // ),
                      //                                     // Text(
                      //                                     //   _enquiryModel2[index]
                      //                                     //       .checked!
                      //                                     //       .toString(),
                      //                                     // ),
                      //                                   ],
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   );
                      //                 },
                      //               ),
                      //             ),
                      //           )
                      //         : Align(
                      //             alignment: Alignment.center,
                      //             child: Padding(
                      //               padding: const EdgeInsets.all(50),
                      //               child: Column(
                      //                 children: [
                      //                   SvgPicture.asset(
                      //                       'assets/dist/aduan.svg',
                      //                       height: MediaQuery.of(context)
                      //                               .size
                      //                               .width /
                      //                           3),
                      //                   Padding(
                      //                     padding:
                      //                         const EdgeInsets.only(top: 30),
                      //                     child: Text(
                      //                       "You have no favourite bills.".tr,
                      //                       style: styles.heading5,
                      //                       textAlign: TextAlign.center,
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      // ! Closed-Bil kegemaran
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Announcements'.tr, style: styles.titleHome),
                            Divider(
                              color: constants.sixColor,
                              thickness: 5,
                              endIndent: 250,
                            ),
                          ],
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
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
                                    // todo : Navigate to single screen
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
                                          maxLines: 5,
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
                                            maxLines: 6,
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
                            if (controller.hebahanList.length >= 1) {
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
                                            SizedBox(height: 10),
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
                              return Container(); // If there are no more items to show, return an empty container
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

  billDetails(enquiryModel2) async {
    // print(enquiryModel2["referenceNumber"]);
    bool init = await navigate(context, BillDetailsScreen(enquiryModel2, ""));
    if (init) _getData2();
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
                      title: "Individual Bill".tr,
                      onTap: () {
                        navigate(context, PlaceholderBillingScreen());
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomWidgetMenu(
                      counterTextStyle: styles.widgetMenuCounterWhite,
                      backgroundColor: constants.widgetTwoColor,
                      counter: billOrganization,
                      title: "Organization Bill".tr,
                      onTap: () {
                        navigate(context, PlaceholderBillingScreen());
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomWidgetMenu(
                      counterTextStyle: styles.widgetMenuCounter,
                      backgroundColor: constants.widgetThreeColor,
                      counter: enquiryActive,
                      title: "Active Enquiry".tr,
                      onTap: () {
                        navigate(context, TabMainEnquiryScreen());
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomWidgetMenu(
                      counterTextStyle: styles.widgetMenuCounterWhite,
                      backgroundColor: constants.widgetThreeColor,
                      counter: serviceFavourite,
                      title: "Favourite Service".tr,
                      onTap: () => Get.to(() => FavoriteService("Servis")),
                    ),
                  ),
                  Expanded(
                    child: CustomWidgetMenu(
                      counterTextStyle: styles.widgetMenuCounter,
                      backgroundColor: constants.primaryColor,
                      counter: billFavourite,
                      title: "Favourite Bill".tr,
                      onTap: () => Get.to(() => FavoriteService("Bills")),
                    ),
                  ),
                  Expanded(
                    child: CustomWidgetMenu(
                      counterTextStyle: styles.widgetMenuCounterWhite,
                      backgroundColor: constants.widgetTwoColor,
                      counter: paymentPending,
                      title: "Pending Payment".tr,
                      onTap: () {
                        navigate(context, PendingTransactions());
                      },
                    ),
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
      padding: const EdgeInsets.fromLTRB(22, 10, 22, 0),
      child: ValueListenableBuilder(
        valueListenable: state.value.userState,
        builder: (BuildContext context, UserDataState value, Widget? child) {
          return Row(
            children: [
              SizedBox(
                width: AppStyles.u1 * 10,
                child: Row(
                  children: [
                    SizedBox(
                      height: 34,
                      width: 34,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/dist/user_avatar.jpeg',
                                ),
                              ),
                            ),
                          ),
                          Material(
                              color: Colors.transparent,
                              child: (state.user.avatarUrl != null)
                                  ? InkWell(
                                      borderRadius: BorderRadius.circular(27),
                                      onTap: () =>
                                          DefaultTabController.of(context)
                                              .animateTo(4),
                                    )
                                  : null)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                      state.user.firstName! + ' ' + state.user.lastName!,
                      style: styles.heading13Primary,
                      textAlign: TextAlign.center),
                ),
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
                                  Icon(getIcon('envelope'), size: 30),
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
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(2, 1, 2, 0),
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
                              : Icon(getIcon('envelope-open'), size: 30);
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
                    onPressed: () => Get.to(() => FavoriteService("Servis")),
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
              favorite.service!.name.split(" ").first.capitalizeFirst![0] +
                  ((favorite.service!.name.split(" ").asMap().containsKey(1))
                      ? favorite.service!.name.split(" ")[1].capitalizeFirst![0]
                      : ""),
              style: TextStyle(color: Color(0xFF8C9791)),
            ),
          ),
          title: Text(
            favorite.service!.name,
            style: TextStyle(
                color: Color(0xFF282B29), fontWeight: FontWeight.w600),
          ),
          onTap: () async {
            print(jsonEncode(favorite.service));
            switch (favorite.service!.billTypeId) {
              case 1:
                Get.to(() => BillScreen.Bill(), arguments: {
                  "serviceRefNum": favorite.service!.serviceReferenceNumber,
                  "amountRequired": false
                });
                break;
              case 2:
                Get.to(() => BillScreen.Bill(), arguments: {
                  "serviceRefNum": favorite.service!.serviceReferenceNumber,
                  "amountRequired": true
                });
                break;
              case 3:
                Get.to(() => BayaranTanpaBill(), arguments: {
                  "serviceRefNum": favorite.service!.serviceReferenceNumber,
                  "serviceId": favorite.service!.id,
                  "billType": favorite.service!.billTypeId,
                });
                break;
              case 4:
                Get.to(() => TanpaBillAmount(), arguments: {
                  "serviceRefNum": favorite.service!.serviceReferenceNumber,
                  "agencyName": favorite.service?.agency?.name ?? "",
                });
                break;
              case 5:
                Get.to(() => BayaranTanpaBill(), arguments: {
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
  int _itemsPerPage = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: constants.reverseWhiteColor,
      height: 170,
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
                    (widget.controller.menuList.length / _itemsPerPage).ceil(),
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
                          (widget.controller.menuList.length / _itemsPerPage)
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
    );
  }

  Widget _buildGridView(List<dynamic> items) {
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
            store.setItem('fromLoginLS', false);
            print(store.getItem('fromLoginLS'));
            log(jsonEncode(item));
            Get.to(() => SubmenuScreen(), arguments: item);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                getIcon(item.iconClass.toString()),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Text(
                  widget.controller.handleTranslation(item) ?? "Tiada Nama",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff333333),
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
