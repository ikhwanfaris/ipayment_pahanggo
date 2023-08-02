import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/add_to_cart_button.dart';
import 'package:flutterbase/components/checkout_button.dart';
// import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/screens/content/bill/bill_details.dart';
import 'package:flutterbase/screens/content/bill/checkout.dart';
import 'package:flutterbase/screens/content/bill/precart2_bil.dart';
import 'package:flutterbase/screens/content/bill/precheckout_bil.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import '../../../models/bills/bills.dart' as model;
import '../cart/widgets/edit_amount_modal2.dart';
import 'menu_bill.dart';

class PlaceholderBillingScreen extends StatefulWidget {
  const PlaceholderBillingScreen({Key? key}) : super(key: key);

  @override
  State<PlaceholderBillingScreen> createState() =>
      _PlaceholderBillingScreenState();
}

class _PlaceholderBillingScreenState extends State<PlaceholderBillingScreen> {
  bool _isIndividuPage = true;
  bool allChecked = false;
  bool allChecked2 = false;
  bool _isVisibileBtn = false;
  bool cartable = true;
  List<model.Bills> _enquiryModel2 = [];
  List<model.Bills> temptenquiryModel2 = [];
  List<model.Bills> _enquiryModel3 = [];
  List<model.Bills> temptenquiryModel3 = [];
  List precart = [];
  List precart2 = [];
  List realcart = [];
  List realcart2 = [];
  double sum = 0.00;
  double sum2 = 0.00;
  double sum3 = 0.00;
  bool alreadySaved = false;
  int preTick = 0;
  int preTick2 = 0;
  String search = "";
  String search2 = "";
  bool isSearching = false;
  bool isSearching2 = false;
  TextEditingController textString = TextEditingController();
  TextEditingController textString2 = TextEditingController();
  bool disableCart = false;
  bool disablePay = false;
  // ignore: unused_field
  var _formKey = GlobalKey<FormState>();
  bool one = false;
  bool two = false;
  bool dataKerajaan = false;
  bool dataPelanggan = false;
  bool dataKerajaan2 = false;
  bool dataPelanggan2 = false;
  int count = 0;
  int countCheck = 0;
  // ignore: unused_field
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // late final tabController = TabController(length: 2, vsync: this );

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));

    _enquiryModel2 = [];
    temptenquiryModel2 = [];
    sum = 0.00;
    _enquiryModel3 = [];
    temptenquiryModel3 = [];
    sum2 = 0.00;
    allChecked = false;
    allChecked2 = false;
    _isVisibileBtn = false;
    dataKerajaan = false;
    dataPelanggan = false;
    precart = [];
    precart2 = [];
    realcart = [];
    realcart2 = [];
    disableCart = false;
    disablePay = false;
    count = 0;
    countCheck = 0;
    if (search != "" || search2 != "") {
      setState(() {
        isSearching = true;
      });
    }
    // _enquiryModel2 = await api.GetBills(search, "1");
    // _enquiryModel3 = await api.GetBills(search2, "2");
    _enquiryModel2 = await api.GetBills(search, "individu");
    _enquiryModel3 = await api.GetBills(search2, "organisasi");

    if (isSearching == true && _enquiryModel2.length == 0) {
      // setState(() {
      //   _enquiryModel2 = temptenquiryModel2;
      // });
      for (var i = 0; i < _enquiryModel2.length; i++) {
        if (_enquiryModel2[i].status == "Aktif") {
          sum += _enquiryModel2[i].nettCalculations!.total!;
        }
        if (_enquiryModel2[i].service!.chargedTo.toString() == "Kerajaan" &&
            _enquiryModel2[i].status.toString() == "Aktif") {
          setState(() {
            dataKerajaan = true;
          });
        }
        if (_enquiryModel2[i].service!.chargedTo.toString() == "Pelanggan" &&
            _enquiryModel2[i].status.toString() == "Aktif") {
          setState(() {
            dataPelanggan = true;
          });
        }
      }
      for (var i = 0; i < _enquiryModel3.length; i++) {
        // sum += _enquiryModel3[i].nettCalculations!.total!;
        if (_enquiryModel3[i].service!.chargedTo.toString() == "Kerajaan" &&
            _enquiryModel3[i].status.toString() == "Aktif") {
          setState(() {
            dataKerajaan2 = true;
          });
        }
        if (_enquiryModel3[i].service!.chargedTo.toString() == "Pelanggan" &&
            _enquiryModel3[i].status.toString() == "Aktif") {
          setState(() {
            dataPelanggan2 = true;
          });
        }
      }
      sum.toStringAsFixed(2).toString();

      snack(context, search + " tidak dijumpai.".tr);
      textString.text = "";
      search = "";
    } else {
      setState(() {
        _enquiryModel2 = _enquiryModel2;
        temptenquiryModel2 = _enquiryModel2;
      });

      for (var i = 0; i < _enquiryModel2.length; i++) {
        if (_enquiryModel2[i].status == "Aktif") {
          sum += _enquiryModel2[i].nettCalculations!.total!;
        }

        if (_enquiryModel2[i].service!.chargedTo.toString() == "Kerajaan" &&
            _enquiryModel2[i].status.toString() == "Aktif") {
          setState(() {
            dataKerajaan = true;
          });
        }
        if (_enquiryModel2[i].service!.chargedTo.toString() == "Pelanggan" &&
            _enquiryModel2[i].status.toString() == "Aktif") {
          setState(() {
            dataPelanggan = true;
          });
        }
        if (_enquiryModel2[i].status.toString() == "Aktif") {
          count += 1;
        }
      }
      for (var i = 0; i < _enquiryModel3.length; i++) {
        // sum += _enquiryModel3[i].nettCalculations!.total!;
        if (_enquiryModel3[i].service!.chargedTo.toString() == "Kerajaan" &&
            _enquiryModel3[i].status.toString() == "Aktif") {
          setState(() {
            dataKerajaan2 = true;
          });
        }
        if (_enquiryModel3[i].service!.chargedTo.toString() == "Pelanggan" &&
            _enquiryModel3[i].status.toString() == "Aktif") {
          setState(() {
            dataPelanggan2 = true;
          });
        }
      }
      sum.toStringAsFixed(2).toString();
      print("count " + count.toString());
    }

    Future.delayed(const Duration(seconds: 0)).then(
      (value) => setState(
        () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void _handleTabChange(int index) {
    setState(() {
      if (index == 1) {
        _isIndividuPage = false;
      } else {
        _isIndividuPage = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const curveHeight = -20.0;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          shape: const MyShapeBorder(curveHeight),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Heading(),
            TabBar(
              onTap: _handleTabChange,
              indicatorWeight: 5.0,
              // controller: tabController,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  child: Text(
                    "Individual".tr +
                        " (" +
                        _enquiryModel2.length.toString() +
                        ")",
                    // "Bil".tr,
                    style: styles.heading6bold,
                  ),
                ),
                Tab(
                  child: Text(
                      "Organization".tr +
                          "  (" +
                          _enquiryModel3.length.toString() +
                          ")",
                      // "Bill Without Amount".tr,
                      style: styles.heading6bold),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                // controller: tabController,
                children: [
                  ListView(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'List of Bills'.tr,
                                    style: styles.heading8,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.refresh),
                                    onPressed: () async {
                                      setState(() {
                                        search = "";
                                        textString.text = "";
                                      });

                                      _getData();
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              _enquiryModel2.isEmpty
                                  ? Container()
                                  : Text(
                                      'List of Bills to be Paid'.tr,
                                      style: styles.heading8sub,
                                    ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        // leading: Icon(Icons.info),
                        title: Text(
                          "User Identity Number or Reference Number (Agency or iPayment)."
                              .tr,
                          style: styles.heading12bold,
                        ),
                      ),
                      // Searchbar
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextFormField(
                          controller: textString,
                          autocorrect: false,
                          decoration: styles.inputDecoration.copyWith(
                            labelText: 'Search'.tr,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                if (textString.text != "") {
                                  setState(() {
                                    search = textString.text;
                                  });

                                  _getData();
                                }
                              },
                              icon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          // onChanged: (val) {
                          //   setState(() {
                          //     _isSearching = true;
                          //   });
                          // },
                        ),
                      ),

                      //Jumlah keseluruhan
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Card(
                            //   elevation: 2,
                            //   color: Constants().primaryColor,
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(8),
                            //   ),
                            //   child: Container(
                            //     width: double.infinity,
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(16),
                            //       child: Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           Text('Total Amount'.tr,
                            //               style: styles.heading1sub2),
                            //           SizedBox(height: 10),
                            //           Text(
                            //               "RM " +
                            //                   sum.toStringAsFixed(2).toString(),
                            //               style: styles.heading1),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            search != "" && _enquiryModel2.isNotEmpty
                                ? Row(
                                    children: [
                                      Text("You have ".tr +
                                          count.toString() +
                                          " bill(s) to be paid.".tr),
                                      const SizedBox(width: 5),
                                    ],
                                  )
                                : Container(),
                            const SizedBox(height: 5),
                            // _enquiryModel2.isEmpty
                            //     ? Container()
                            //     :
                            // Row(
                            //     children: [
                            //       Checkbox(
                            //         side: const BorderSide(
                            //           color: Colors.amber,
                            //           width: 1.5,
                            //         ),
                            //         checkColor: Colors.white,
                            //         activeColor: Colors.amber,
                            //         value: allChecked,
                            //         onChanged: (bool? value) async {
                            //           int count = 0;
                            //           for (var i = 0;
                            //               i < _enquiryModel2.length;
                            //               i++) {
                            //             if (_enquiryModel2[i].checked ==
                            //                 true) {
                            //               count++;
                            //             }
                            //           }
                            //           if (count == 0) {
                            //             print("count == 0");
                            //             for (var e = 0;
                            //                 e < _enquiryModel2.length;
                            //                 e++) {
                            //               setState(() {
                            //                 _enquiryModel2[e].checked =
                            //                     !_enquiryModel2[e].checked!;
                            //                 allChecked = !allChecked;
                            //               });
                            //             }
                            //           }
                            //           if (count > 0) {
                            //             print("count > 0");
                            //             for (var e = 0;
                            //                 e < _enquiryModel2.length;
                            //                 e++) {
                            //               setState(() {
                            //                 _enquiryModel2[e].checked =
                            //                     true;
                            //                 allChecked = !allChecked;
                            //               });
                            //             }
                            //           }
                            //           if (count == _enquiryModel2.length) {
                            //             print(
                            //                 "count == _enquiryModel2.length");
                            //             for (var e = 0;
                            //                 e < _enquiryModel2.length;
                            //                 e++) {
                            //               setState(() {
                            //                 _enquiryModel2[e].checked =
                            //                     false;
                            //                 allChecked = !allChecked;
                            //               });
                            //             }
                            //           }
                            //           await checkVisibility();
                            //           await checkAllTick();
                            //         },
                            //       ),
                            //       const SizedBox(width: 5),
                            //       Expanded(
                            //         child: Text.rich(
                            //           TextSpan(
                            //             text: 'Select All'.tr,
                            //             style: styles.heading10,
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            _enquiryModel2.isEmpty
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(50),
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/dist/aduan.svg',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Text(
                                              'You have no outstanding bill.'
                                                  .tr,
                                              style: styles.heading5,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            dataKerajaan == true
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "Transaction Charged To : Goverment"
                                            .tr),
                                  )
                                : Container(),
                            ListView.builder(
                              reverse: true,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _enquiryModel2.length,
                              //  _organizationModel.length,
                              itemBuilder: (context, index) {
                                return _enquiryModel2[index]
                                                .service
                                                ?.chargedTo
                                                .toString() ==
                                            "Kerajaan" &&
                                        _enquiryModel2[index]
                                                .status
                                                .toString() ==
                                            "Aktif"
                                    ? InkWell(
                                        onTap: () {
                                          billDetails(_enquiryModel2[index]);
                                        },
                                        child: Card(
                                          elevation: 0,
                                          color:
                                              // ignore: unnecessary_null_comparison
                                              _enquiryModel2[index].status ==
                                                      "Aktif"
                                                  ? Color(0xFFF5F6F9)
                                                  : Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(1),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  // for (var item in bills)
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          // _enquiryModel2[index]
                                                          //             .status ==
                                                          //         "Aktif"
                                                          //     ?
                                                          Checkbox(
                                                            materialTapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                            side:
                                                                const BorderSide(
                                                              color:
                                                                  Colors.amber,
                                                              width: 1.5,
                                                            ),
                                                            checkColor:
                                                                Colors.white,
                                                            activeColor:
                                                                Colors.amber,
                                                            value:
                                                                _enquiryModel2[
                                                                        index]
                                                                    .checked,
                                                            onChanged: (bool?
                                                                value) async {
                                                              if (value !=
                                                                  null) {
                                                                setState(() {
                                                                  _enquiryModel2[
                                                                          index]
                                                                      .checked = !_enquiryModel2[
                                                                          index]
                                                                      .checked!;
                                                                });
                                                                await checkVisibility();
                                                                await checkAllTick();
                                                                // if (_enquiryModel2[
                                                                //             index]
                                                                //         .status !=
                                                                //     "Aktif") {
                                                                //   setState(() {
                                                                //     disableCart =
                                                                //         true;
                                                                //   });
                                                                // }
                                                                // if (_enquiryModel2[
                                                                //             index]
                                                                //         .status !=
                                                                //     "Aktif") {
                                                                //   setState(() {
                                                                //     disablePay =
                                                                //         true;
                                                                //   });
                                                                // }
                                                                // checkCartable();
                                                              }
                                                            },
                                                          )
                                                          // : Container(),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 190,
                                                            child: Text(
                                                              _enquiryModel2[
                                                                      index]
                                                                  .detail!
                                                                  .toString(),
                                                              style: styles
                                                                  .heading6bold,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        "RM " +
                                                            _enquiryModel2[
                                                                    index]
                                                                .nettCalculations!
                                                                .total!
                                                                .toStringAsFixed(
                                                                    2)
                                                                .toString(),
                                                        style: styles
                                                            .heading12bold,
                                                      ),
                                                      _enquiryModel2[index]
                                                                  .billTypeId ==
                                                              2
                                                          ? EditAmountButton2(
                                                              onChanged:
                                                                  (value) {
                                                                String b = "";
                                                                print("main");
                                                                print(value
                                                                    .toString());
                                                                setState(() {
                                                                  b = value
                                                                      .toString();
                                                                });

                                                                double a =
                                                                    double.parse(
                                                                        value);
                                                                if (a > 0.00) {
                                                                  print("yes");
                                                                  // Navigator.of(
                                                                  //         context)
                                                                  //     .pop();

                                                                  Future.delayed(const Duration(
                                                                          seconds:
                                                                              1))
                                                                      .then(
                                                                          (value) {
                                                                    print(
                                                                        "main");
                                                                    print(value
                                                                        .toString());
                                                                    navigate(
                                                                      context,
                                                                      BillDetailsScreen(
                                                                        _enquiryModel2[
                                                                            index],
                                                                        b,
                                                                      ),
                                                                    );
                                                                  });
                                                                }
                                                              },
                                                            )
                                                          : Container()
                                                      // Text(
                                                      //   _enquiryModel2[index]
                                                      //       .detail
                                                      //       .toString(),
                                                      //   style: styles
                                                      //       .heading12bold,
                                                      // )
                                                      // Row(
                                                      //   crossAxisAlignment:
                                                      //       CrossAxisAlignment
                                                      //           .end,
                                                      //   children: [
                                                      //     Padding(
                                                      //       padding:
                                                      //           const EdgeInsets
                                                      //               .all(8.0),
                                                      //       child: IconButton(
                                                      //         icon: Icon(Icons
                                                      //             .visibility),
                                                      //         color: Constants()
                                                      //             .primaryColor,
                                                      //         onPressed:
                                                      //             () async {
                                                      //           billDetails(
                                                      //               _enquiryModel2[
                                                      //                   index]);
                                                      //         },
                                                      //       ),
                                                      //     ),
                                                      //     Padding(
                                                      //       padding:
                                                      //           const EdgeInsets
                                                      //               .all(8.0),
                                                      //       child: IconButton(
                                                      //         icon: Icon(_enquiryModel2[
                                                      //                         index]
                                                      //                     .favorite ==
                                                      //                 1
                                                      //             ? Icons.favorite
                                                      //             : Icons
                                                      //                 .favorite_border),
                                                      //         color: Constants()
                                                      //             .primaryColor,
                                                      //         onPressed:
                                                      //             () async {
                                                      //           await api.favABill(
                                                      //               _enquiryModel2[
                                                      //                       index]
                                                      //                   .id
                                                      //                   .toString());
                                                      //           _enquiryModel2[index]
                                                      //                       .favorite ==
                                                      //                   1
                                                      //               ? snack(
                                                      //                   context,
                                                      //                   "Removed to favourite list successfully."
                                                      //                       .tr,
                                                      //                   level: SnackLevel
                                                      //                       .Error)
                                                      //               : snack(
                                                      //                   context,
                                                      //                   "Added to favourite list successfully."
                                                      //                       .tr,
                                                      //                   level: SnackLevel
                                                      //                       .Success);
                                                      //           _getData();
                                                      //         },
                                                      //       ),
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment
                                                  //           .spaceBetween,
                                                  //   children: [
                                                  //     Text(
                                                  //       _enquiryModel2[index]
                                                  //           .referenceNumber!
                                                  //           .toString(),
                                                  //       style:
                                                  //           styles.heading6bold,
                                                  //     ),
                                                  //     Text(
                                                  //       "RM " +
                                                  //           _enquiryModel2[index]
                                                  //               .nettCalculations!
                                                  //               .total!
                                                  //               .toString(),
                                                  //       style:
                                                  //           styles.heading12bold,
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: 120,
                                                          ),
                                                          SizedBox(
                                                            child: Text(
                                                              _enquiryModel2[
                                                                          index]
                                                                      .referenceNumber!
                                                                      .toString() +
                                                                  " | " +
                                                                  _enquiryModel2[
                                                                          index]
                                                                      .billNumber!
                                                                      .toString(),
                                                              // overflow:
                                                              //     TextOverflow
                                                              //         .ellipsis,
                                                            ),
                                                          ),

                                                          _enquiryModel2[index]
                                                                      .startAt !=
                                                                  null
                                                              ? Text(
                                                                  formatDate(
                                                                    DateTime.parse(_enquiryModel2[
                                                                            index]
                                                                        .startAt
                                                                        .toString()),
                                                                    [
                                                                      dd,
                                                                      '/',
                                                                      mm,
                                                                      '/',
                                                                      yyyy
                                                                    ],
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "No date".tr),
                                                          // Text('Status'.tr + ":"),
                                                          // Text(
                                                          //     'Transaction Charged To'
                                                          //             .tr +
                                                          //         ':'),
                                                        ],
                                                      ),
                                                      // Column(
                                                      //   crossAxisAlignment:
                                                      //       CrossAxisAlignment
                                                      //           .end,
                                                      //   children: [
                                                      //     Text(_enquiryModel2[
                                                      //                     index]
                                                      //                 .billNumber !=
                                                      //             null
                                                      //         ? _enquiryModel2[
                                                      //                 index]
                                                      //             .billNumber
                                                      //             .toString()
                                                      //         : '-'),
                                                      // _enquiryModel2[index]
                                                      //             .startAt !=
                                                      //         null
                                                      //     ? Text(
                                                      //         formatDate(
                                                      //           DateTime.parse(_enquiryModel2[
                                                      //                   index]
                                                      //               .startAt
                                                      //               .toString()),
                                                      //           [
                                                      //             dd,
                                                      //             '/',
                                                      //             mm,
                                                      //             '/',
                                                      //             yyyy
                                                      //           ],
                                                      //         ),
                                                      //       )
                                                      //     : Text(
                                                      //         "No date".tr),
                                                      // Text(
                                                      //   _enquiryModel2[index]
                                                      //               .status! ==
                                                      //           "Aktif"
                                                      //       ? "Active".tr
                                                      //       : "Inactive".tr,
                                                      // ),
                                                      // Text(
                                                      //   _enquiryModel2[index]
                                                      //       .billTypeId
                                                      //       .toString(),
                                                      // ),
                                                      // Text(
                                                      //   _enquiryModel2[index]
                                                      //               .service!
                                                      //               .chargedTo!
                                                      //               .toString() ==
                                                      //           "Kerajaan"
                                                      //       ? "Goverment".tr
                                                      //       : "Customer".tr,
                                                      // ),
                                                      // Text(
                                                      //   _enquiryModel2[index]
                                                      //       .checked!
                                                      //       .toString(),
                                                      // ),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container();
                              },
                            ),
                            dataPelanggan == true
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "Transaction Charged To : Customer".tr),
                                  )
                                : Container(),
                            ListView.builder(
                              reverse: true,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _enquiryModel2.length,
                              //  _organizationModel.length,
                              itemBuilder: (context, index) {
                                return _enquiryModel2[index]
                                                .service
                                                ?.chargedTo
                                                .toString() ==
                                            "Pelanggan" &&
                                        _enquiryModel2[index]
                                                .status
                                                .toString() ==
                                            "Aktif"
                                    ? InkWell(
                                        onTap: () {
                                          billDetails(_enquiryModel2[index]);
                                        },
                                        child: Card(
                                          elevation: 0,
                                          color: _enquiryModel2[index].status ==
                                                  "Aktif"
                                              ? Color(0xFFF5F6F9)
                                              : Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(1),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Checkbox(
                                                        materialTapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        side: const BorderSide(
                                                          color: Colors.amber,
                                                          width: 1.5,
                                                        ),
                                                        checkColor:
                                                            Colors.white,
                                                        activeColor:
                                                            Colors.amber,
                                                        value: _enquiryModel2[
                                                                index]
                                                            .checked!,
                                                        onChanged: (bool?
                                                            value) async {
                                                          if (value != null) {
                                                            setState(() {
                                                              _enquiryModel2[
                                                                          index]
                                                                      .checked =
                                                                  !_enquiryModel2[
                                                                          index]
                                                                      .checked!;
                                                            });
                                                            await checkVisibility();
                                                            await checkAllTick();
                                                            // if (_enquiryModel2[
                                                            //             index]
                                                            //         .status !=
                                                            //     "Aktif") {
                                                            //   setState(() {
                                                            //     disableCart =
                                                            //         false;
                                                            //     disableCart =
                                                            //         false;
                                                            //   });
                                                            // }
                                                            // if (_enquiryModel2[
                                                            //             index]
                                                            //         .status !=
                                                            //     "Tidak Aktif") {
                                                            //   setState(() {
                                                            //     disablePay =
                                                            //         true;
                                                            //     disableCart =
                                                            //         true;
                                                            //   });
                                                            // }
                                                            // checkCartable();
                                                          }
                                                        },
                                                      )
                                                      // : Container(),
                                                      ,
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 190,
                                                            child: Text(
                                                              _enquiryModel2[
                                                                      index]
                                                                  .detail!
                                                                  .toString(),
                                                              style: styles
                                                                  .heading6bold,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          // Padding(
                                                          //   padding:
                                                          //       const EdgeInsets
                                                          //           .all(8.0),
                                                          //   child: IconButton(
                                                          //     icon: Icon(Icons
                                                          //         .visibility),
                                                          //     color: Constants()
                                                          //         .primaryColor,
                                                          //     onPressed:
                                                          //         () async {
                                                          //       billDetails(
                                                          //           _enquiryModel2[
                                                          //               index]);
                                                          //     },
                                                          //   ),
                                                          // ),
                                                          // Padding(
                                                          //   padding:
                                                          //       const EdgeInsets
                                                          //           .all(8.0),
                                                          //   child: IconButton(
                                                          //     icon: Icon(_enquiryModel2[
                                                          //                     index]
                                                          //                 .favorite ==
                                                          //             1
                                                          //         ? Icons
                                                          //             .favorite
                                                          //         : Icons
                                                          //             .favorite_border),
                                                          //     color: Constants()
                                                          //         .primaryColor,
                                                          //     onPressed:
                                                          //         () async {
                                                          //       await api.favABill(
                                                          //           _enquiryModel2[
                                                          //                   index]
                                                          //               .id
                                                          //               .toString());
                                                          //       _enquiryModel2[index]
                                                          //                   .favorite ==
                                                          //               1
                                                          //           ? snack(
                                                          //               context,
                                                          //               "Removed to favourite list successfully."
                                                          //                   .tr,
                                                          //               level: SnackLevel
                                                          //                   .Error)
                                                          //           : snack(
                                                          //               context,
                                                          //               "Added to favourite list successfully."
                                                          //                   .tr,
                                                          //               level: SnackLevel
                                                          //                   .Success);
                                                          //       _getData();
                                                          //     },
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        "RM " +
                                                            _enquiryModel2[
                                                                    index]
                                                                .nettCalculations!
                                                                .total!
                                                                .toStringAsFixed(
                                                                    2)
                                                                .toString(),
                                                        style: styles
                                                            .heading12bold,
                                                      ),
                                                      _enquiryModel2[index]
                                                                  .billTypeId ==
                                                              2
                                                          ? EditAmountButton2(
                                                              onChanged:
                                                                  (value) {
                                                                String b = "";
                                                                print("main");
                                                                print(value
                                                                    .toString());
                                                                setState(() {
                                                                  b = value
                                                                      .toString();
                                                                });

                                                                double a =
                                                                    double.parse(
                                                                        value);
                                                                if (a > 0.00) {
                                                                  print("yes");
                                                                  // Navigator.of(
                                                                  //         context)
                                                                  //     .pop();

                                                                  Future.delayed(const Duration(
                                                                          seconds:
                                                                              1))
                                                                      .then(
                                                                          (value) {
                                                                    print(
                                                                        "main");
                                                                    print(value
                                                                        .toString());
                                                                    navigate(
                                                                      context,
                                                                      BillDetailsScreen(
                                                                        _enquiryModel2[
                                                                            index],
                                                                        b,
                                                                      ),
                                                                    );
                                                                  });
                                                                }
                                                              },
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment
                                                  //           .spaceBetween,
                                                  //   children: [
                                                  //     Text(
                                                  //       _enquiryModel2[index]
                                                  //           .referenceNumber!
                                                  //           .toString(),
                                                  //       style:
                                                  //           styles.heading6bold,
                                                  //     ),
                                                  //     Text(
                                                  //       "RM " +
                                                  //           _enquiryModel2[
                                                  //                   index]
                                                  //               .nettCalculations!
                                                  //               .total!
                                                  //               .toString(),
                                                  //       style: styles
                                                  //           .heading12bold,
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(_enquiryModel2[
                                                                      index]
                                                                  .referenceNumber!
                                                                  .toString() +
                                                              " | " +
                                                              _enquiryModel2[
                                                                      index]
                                                                  .billNumber!
                                                                  .toString()),
                                                          _enquiryModel2[index]
                                                                      .startAt !=
                                                                  null
                                                              ? Text(
                                                                  formatDate(
                                                                    DateTime.parse(_enquiryModel2[
                                                                            index]
                                                                        .startAt
                                                                        .toString()),
                                                                    [
                                                                      dd,
                                                                      '/',
                                                                      mm,
                                                                      '/',
                                                                      yyyy
                                                                    ],
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "No date".tr),
                                                          // Text(
                                                          //     'iPayment Bill Ref. No '
                                                          //             .tr +
                                                          //         ':'),
                                                          // Text(
                                                          //     'Bill Reference Date'
                                                          //             .tr +
                                                          //         ':'),
                                                          // Text('Status'.tr +
                                                          //     ':'),
                                                          // Text(
                                                          //     'Transaction Charged To'
                                                          //             .tr +
                                                          //         ':'),
                                                        ],
                                                      ),
                                                      // Column(
                                                      //   crossAxisAlignment:
                                                      //       CrossAxisAlignment
                                                      //           .end,
                                                      //   children: [
                                                      //     Text(_enquiryModel2[
                                                      //                     index]
                                                      //                 .billNumber !=
                                                      //             null
                                                      //         ? _enquiryModel2[
                                                      //                 index]
                                                      //             .billNumber
                                                      //             .toString()
                                                      //         : '-'),
                                                      //     _enquiryModel2[index]
                                                      //                 .startAt !=
                                                      //             null
                                                      //         ? Text(
                                                      //             formatDate(
                                                      //               DateTime.parse(_enquiryModel2[
                                                      //                       index]
                                                      //                   .startAt
                                                      //                   .toString()),
                                                      //               [
                                                      //                 dd,
                                                      //                 '/',
                                                      //                 mm,
                                                      //                 '/',
                                                      //                 yyyy
                                                      //               ],
                                                      //             ),
                                                      //           )
                                                      //         : Text(
                                                      //             "No date".tr),
                                                      //     Text(
                                                      //       _enquiryModel2[index]
                                                      //                   .status! ==
                                                      //               "Aktif"
                                                      //           ? "Active".tr
                                                      //           : "Inactive".tr,
                                                      //     ),
                                                      //     Text(
                                                      //       _enquiryModel2[index]
                                                      //                   .service!
                                                      //                   .chargedTo!
                                                      //                   .toString() ==
                                                      //               "Kerajaan"
                                                      //           ? "Goverment".tr
                                                      //           : "Customer".tr,
                                                      //     ),
                                                      //     // Text(
                                                      //     //   _enquiryModel2[index]
                                                      //     //       .checked!
                                                      //     //       .toString(),
                                                      //     // ),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'List of Bills'.tr,
                                    style: styles.heading8,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.refresh),
                                    onPressed: () async {
                                      setState(() {
                                        search2 = "";
                                      });
                                      textString2.text = "";
                                      _getData();
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              _enquiryModel3.isEmpty
                                  ? Container()
                                  : Text(
                                      'List of Bills to be Paid'.tr,
                                      style: styles.heading8sub,
                                    ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        // leading: Icon(Icons.info),
                        title: Text(
                          "User Identity Number or Reference Number (Agency or iPayment)."
                              .tr,
                          style: styles.heading12bold,
                        ),
                      ),
                      // Searchbar
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextFormField(
                          controller: textString2,
                          autocorrect: false,
                          decoration: styles.inputDecoration.copyWith(
                            labelText: 'Search'.tr,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                if (textString2.text != "") {
                                  setState(() {
                                    search2 = textString2.text;
                                  });

                                  _getData();
                                }
                              },
                              icon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          // onChanged: (val) {
                          //   setState(() {
                          //     _isSearching = true;
                          //   });
                          // },
                        ),
                      ),

                      //Jumlah keseluruhan
                      Padding(
                        padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Card(
                            //   elevation: 2,
                            //   color: Constants().primaryColor,
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(8),
                            //   ),
                            //   child: Container(
                            //     width: double.infinity,
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(16),
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Text('Jumlah Keseluruhan',
                            //               style: styles.heading1sub2),
                            //           SizedBox(height: 10),
                            //           Text(
                            //               "RM " +
                            //                   sum2.toStringAsFixed(2).toString(),
                            //               style: styles.heading1),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 20),
                            search2 != "" && _enquiryModel3.isNotEmpty
                                ? Row(
                                    children: [
                                      Text("You have ".tr +
                                          _enquiryModel3.length.toString() +
                                          " bill(s) to be paid.".tr),
                                      const SizedBox(width: 5),
                                    ],
                                  )
                                : Container(),
                            // const SizedBox(height: 5),
                            _enquiryModel3.isEmpty
                                ? Container()
                                :

                                // Row(
                                //     children: [
                                //       Checkbox(
                                //         side: const BorderSide(
                                //           color: Colors.amber,
                                //           width: 1.5,
                                //         ),
                                //         checkColor: Colors.white,
                                //         activeColor: Colors.amber,
                                //         value: allChecked2,
                                //         onChanged: (bool? value) async {
                                //           int count = 0;
                                //           for (var i = 0;
                                //               i < _enquiryModel3.length;
                                //               i++) {
                                //             if (_enquiryModel3[i].checked ==
                                //                 true) {
                                //               count++;
                                //             }
                                //           }
                                //           if (count == 0) {
                                //             print("count == 0");
                                //             for (var e = 0;
                                //                 e < _enquiryModel3.length;
                                //                 e++) {
                                //               setState(() {
                                //                 _enquiryModel3[e].checked =
                                //                     !_enquiryModel3[e].checked!;
                                //                 allChecked2 = !allChecked2;
                                //               });
                                //             }
                                //           }
                                //           if (count > 0) {
                                //             print("count > 0");
                                //             for (var e = 0;
                                //                 e < _enquiryModel3.length;
                                //                 e++) {
                                //               setState(() {
                                //                 _enquiryModel3[e].checked =
                                //                     true;
                                //                 allChecked2 = !allChecked2;
                                //               });
                                //             }
                                //           }
                                //           if (count == _enquiryModel3.length) {
                                //             print(
                                //                 "count == _enquiryModel2.length");
                                //             for (var e = 0;
                                //                 e < _enquiryModel3.length;
                                //                 e++) {
                                //               setState(() {
                                //                 _enquiryModel3[e].checked =
                                //                     false;
                                //                 allChecked2 = !allChecked2;
                                //               });
                                //             }
                                //           }
                                //           await checkVisibility();
                                //           await checkAllTick2();
                                //         },
                                //       ),
                                //       const SizedBox(width: 5),
                                //       Expanded(
                                //         child: Text.rich(
                                //           TextSpan(
                                //             text: 'Select All'.tr,
                                //             style: styles.heading10,
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),

                                _enquiryModel3.isEmpty
                                    ? Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.all(50),
                                          child: Column(
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/dist/aduan.svg',
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0),
                                                child: Text(
                                                  'You have no outstanding bill.'
                                                      .tr,
                                                  style: styles.heading5,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),
                            dataKerajaan2 == true
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "Transaction Charged To : Goverment"
                                            .tr),
                                  )
                                : Container(),
                            ListView.builder(
                              reverse: true,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _enquiryModel3.length,
                              //  _organizationModel.length,
                              itemBuilder: (context, index) {
                                return _enquiryModel3[index]
                                                .service!
                                                .chargedTo!
                                                .toString() ==
                                            "Kerajaan" &&
                                        _enquiryModel3[index]
                                                .status
                                                .toString() ==
                                            "Aktif"
                                    ? InkWell(
                                        onTap: () {
                                          billDetails(_enquiryModel3[index]);
                                        },
                                        child: Card(
                                          elevation: 0,
                                          color: _enquiryModel3[index].status ==
                                                  "Aktif"
                                              ? Color(0xFFF5F6F9)
                                              : Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(1),
                                            child: Container(
                                              // color: Colors.red,
                                              // height: 200,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Checkbox(
                                                            materialTapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                            side:
                                                                const BorderSide(
                                                              color:
                                                                  Colors.amber,
                                                              width: 1.5,
                                                            ),
                                                            checkColor:
                                                                Colors.white,
                                                            activeColor:
                                                                Colors.amber,
                                                            value:
                                                                _enquiryModel3[
                                                                        index]
                                                                    .checked!,
                                                            onChanged: (bool?
                                                                value) async {
                                                              if (value !=
                                                                  null) {
                                                                setState(() {
                                                                  _enquiryModel3[
                                                                          index]
                                                                      .checked = !_enquiryModel3[
                                                                          index]
                                                                      .checked!;
                                                                });
                                                                await checkVisibility();
                                                                await checkAllTick2();
                                                                // if (_enquiryModel3[
                                                                //             index]
                                                                //         .status !=
                                                                //     "Aktif") {
                                                                //   setState(() {
                                                                //     disableCart =
                                                                //         true;
                                                                //   });
                                                                // }
                                                                // if (_enquiryModel3[
                                                                //             index]
                                                                //         .status !=
                                                                //     "Aktif") {
                                                                //   setState(() {
                                                                //     disablePay =
                                                                //         true;
                                                                //   });
                                                                // }
                                                                // checkCartable();
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 190,
                                                            child: Text(
                                                              // "asda",
                                                              _enquiryModel3[
                                                                      index]
                                                                  .detail!
                                                                  .toString(),
                                                              style: styles
                                                                  .heading6bold,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        "RM " +
                                                            _enquiryModel3[
                                                                    index]
                                                                .nettCalculations!
                                                                .total!
                                                                .toStringAsFixed(
                                                                    2)
                                                                .toString(),
                                                        style: styles
                                                            .heading12bold,
                                                      ),
                                                      _enquiryModel3[index]
                                                                  .billTypeId ==
                                                              2
                                                          ? EditAmountButton2(
                                                              onChanged:
                                                                  (value) {
                                                                String b = "";
                                                                print("main");
                                                                print(value
                                                                    .toString());
                                                                setState(() {
                                                                  b = value
                                                                      .toString();
                                                                });

                                                                double a =
                                                                    double.parse(
                                                                        value);
                                                                if (a > 0.00) {
                                                                  print("yes");
                                                                  // Navigator.of(
                                                                  //         context)
                                                                  //     .pop();

                                                                  Future.delayed(const Duration(
                                                                          seconds:
                                                                              1))
                                                                      .then(
                                                                          (value) {
                                                                    print(
                                                                        "main");
                                                                    print(value
                                                                        .toString());
                                                                    navigate(
                                                                      context,
                                                                      BillDetailsScreen(
                                                                        _enquiryModel2[
                                                                            index],
                                                                        b,
                                                                      ),
                                                                    );
                                                                  });
                                                                }
                                                              },
                                                            )
                                                          : Container(),
                                                      // : Container(),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(_enquiryModel3[
                                                                      index]
                                                                  .referenceNumber!
                                                                  .toString() +
                                                              " | " +
                                                              _enquiryModel3[
                                                                      index]
                                                                  .billNumber!
                                                                  .toString()),
                                                          _enquiryModel3[index]
                                                                      .startAt !=
                                                                  null
                                                              ? Text(
                                                                  formatDate(
                                                                    DateTime.parse(_enquiryModel3[
                                                                            index]
                                                                        .startAt
                                                                        .toString()),
                                                                    [
                                                                      dd,
                                                                      '/',
                                                                      mm,
                                                                      '/',
                                                                      yyyy
                                                                    ],
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "No date".tr),
                                                          // Text(
                                                          //     'iPayment Ref. No.'
                                                          //             .tr +
                                                          //         ':'),
                                                          // Text(
                                                          //     'Bill Reference Date'
                                                          //             .tr +
                                                          //         ':'),
                                                          // Text('Status'.tr +
                                                          //     ':'),
                                                          // Text(
                                                          //     'Transaction Charged To'
                                                          //             .tr +
                                                          //         ':'),
                                                        ],
                                                      ),
                                                      // Column(
                                                      //   crossAxisAlignment:
                                                      //       CrossAxisAlignment
                                                      //           .end,
                                                      //   children: [
                                                      //     Text(
                                                      //       _enquiryModel3[
                                                      //               index]
                                                      //           .billNumber!
                                                      //           .toString(),
                                                      //     ),
                                                      //     _enquiryModel3[index]
                                                      //                 .startAt !=
                                                      //             null
                                                      //         ? Text(
                                                      //             formatDate(
                                                      //               DateTime.parse(_enquiryModel3[
                                                      //                       index]
                                                      //                   .startAt
                                                      //                   .toString()),
                                                      //               [
                                                      //                 dd,
                                                      //                 '/',
                                                      //                 mm,
                                                      //                 '/',
                                                      //                 yyyy
                                                      //               ],
                                                      //             ),
                                                      //           )
                                                      //         : Text(
                                                      //             "No date".tr),
                                                      //     Text(
                                                      //       _enquiryModel3[index]
                                                      //                   .status!
                                                      //                   .toString() ==
                                                      //               "Aktif"
                                                      //           ? "Active".tr
                                                      //           : "Inactive".tr,
                                                      //     ),
                                                      //     Text(
                                                      //       _enquiryModel3[index]
                                                      //                   .service!
                                                      //                   .chargedTo
                                                      //                   .toString() ==
                                                      //               "Kerajaan"
                                                      //           ? "Goverment".tr
                                                      //           : "Customer".tr,
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container();
                              },
                            ),
                            dataPelanggan2 == true
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "Transaction Charged To : Customer".tr),
                                  )
                                : Container(),
                            ListView.builder(
                              reverse: true,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _enquiryModel3.length,
                              //  _organizationModel.length,
                              itemBuilder: (context, index) {
                                return _enquiryModel3[index]
                                                .service!
                                                .chargedTo!
                                                .toString() ==
                                            "Pelanggan" &&
                                        _enquiryModel3[index]
                                                .status
                                                .toString() ==
                                            "Aktif"
                                    ? InkWell(
                                        onTap: () {
                                          billDetails(_enquiryModel3[index]);
                                        },
                                        child: Card(
                                          elevation: 0,
                                          color: _enquiryModel3[index].status ==
                                                  "Aktif"
                                              ? Color(0xFFF5F6F9)
                                              : Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  // for (var item in bills)
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          // _enquiryModel3[index]
                                                          //             .status ==
                                                          //         "Aktif"
                                                          //     ?
                                                          Checkbox(
                                                            materialTapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                            side:
                                                                const BorderSide(
                                                              color:
                                                                  Colors.amber,
                                                              width: 1.5,
                                                            ),
                                                            checkColor:
                                                                Colors.white,
                                                            activeColor:
                                                                Colors.amber,
                                                            value:
                                                                _enquiryModel3[
                                                                        index]
                                                                    .checked!,
                                                            onChanged: (bool?
                                                                value) async {
                                                              if (value !=
                                                                  null) {
                                                                setState(() {
                                                                  _enquiryModel3[
                                                                          index]
                                                                      .checked = !_enquiryModel3[
                                                                          index]
                                                                      .checked!;
                                                                });
                                                                await checkVisibility();
                                                                await checkAllTick2();
                                                                // if (_enquiryModel3[
                                                                //             index]
                                                                //         .status !=
                                                                //     "Aktif") {
                                                                //   setState(() {
                                                                //     disableCart =
                                                                //         true;
                                                                //   });
                                                                // }
                                                                // if (_enquiryModel3[
                                                                //             index]
                                                                //         .status !=
                                                                //     "Aktif") {
                                                                //   setState(() {
                                                                //     disablePay =
                                                                //         true;
                                                                //   });
                                                                // }
                                                                // checkCartable();
                                                              }
                                                            },
                                                          )
                                                          // : Container(),
                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: 190,
                                                            child: Text(
                                                              _enquiryModel3[
                                                                      index]
                                                                  .detail!
                                                                  .toString(),
                                                              style: styles
                                                                  .heading6bold,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        "RM " +
                                                            _enquiryModel3[
                                                                    index]
                                                                .nettCalculations!
                                                                .total!
                                                                .toStringAsFixed(
                                                                    2)
                                                                .toString(),
                                                        style: styles
                                                            .heading12bold,
                                                      ),
                                                      _enquiryModel3[index]
                                                                  .billTypeId ==
                                                              2
                                                          ? EditAmountButton2(
                                                              onChanged:
                                                                  (value) {
                                                                String b = "";
                                                                print("main");
                                                                print(value
                                                                    .toString());
                                                                setState(() {
                                                                  b = value
                                                                      .toString();
                                                                });

                                                                double a =
                                                                    double.parse(
                                                                        value);
                                                                if (a > 0.00) {
                                                                  print("yes");
                                                                  // Navigator.of(
                                                                  //         context)
                                                                  //     .pop();

                                                                  Future.delayed(const Duration(
                                                                          seconds:
                                                                              1))
                                                                      .then(
                                                                          (value) {
                                                                    print(
                                                                        "main");
                                                                    print(value
                                                                        .toString());
                                                                    navigate(
                                                                      context,
                                                                      BillDetailsScreen(
                                                                        _enquiryModel2[
                                                                            index],
                                                                        b,
                                                                      ),
                                                                    );
                                                                  });
                                                                }
                                                              },
                                                            )
                                                          : Container()
                                                      // Row(
                                                      //   children: [
                                                      //     Padding(
                                                      //       padding:
                                                      //           const EdgeInsets
                                                      //               .all(8.0),
                                                      //       child: IconButton(
                                                      //         icon: Icon(Icons
                                                      //             .visibility),
                                                      //         color: Constants()
                                                      //             .primaryColor,
                                                      //         onPressed:
                                                      //             () async {
                                                      //           billDetails(
                                                      //               _enquiryModel3[
                                                      //                   index]);
                                                      //         },
                                                      //       ),
                                                      //     ),
                                                      //     Padding(
                                                      //       padding:
                                                      //           const EdgeInsets
                                                      //               .all(8.0),
                                                      //       child: IconButton(
                                                      //         icon: Icon(_enquiryModel3[
                                                      //                         index]
                                                      //                     .favorite ==
                                                      //                 1
                                                      //             ? Icons
                                                      //                 .favorite
                                                      //             : Icons
                                                      //                 .favorite_border),
                                                      //         color: Constants()
                                                      //             .primaryColor,
                                                      //         onPressed:
                                                      //             () async {
                                                      //           await api.favABill(
                                                      //               _enquiryModel3[
                                                      //                       index]
                                                      //                   .id
                                                      //                   .toString());
                                                      //           _enquiryModel3[index]
                                                      //                       .favorite ==
                                                      //                   1
                                                      //               ? snack(
                                                      //                   context,
                                                      //                   "Removed to favourite list successfully."
                                                      //                       .tr,
                                                      //                   level: SnackLevel
                                                      //                       .Error)
                                                      //               : snack(
                                                      //                   context,
                                                      //                   "Added to favourite list successfully."
                                                      //                       .tr,
                                                      //                   level: SnackLevel
                                                      //                       .Success);
                                                      //           _getData();
                                                      //         },
                                                      //       ),
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(_enquiryModel3[
                                                                      index]
                                                                  .referenceNumber!
                                                                  .toString() +
                                                              " | " +
                                                              _enquiryModel3[
                                                                      index]
                                                                  .billNumber!
                                                                  .toString()),
                                                          _enquiryModel3[index]
                                                                      .startAt !=
                                                                  null
                                                              ? Text(
                                                                  formatDate(
                                                                    DateTime.parse(_enquiryModel3[
                                                                            index]
                                                                        .startAt
                                                                        .toString()),
                                                                    [
                                                                      dd,
                                                                      '/',
                                                                      mm,
                                                                      '/',
                                                                      yyyy
                                                                    ],
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "No date".tr),
                                                          // Text(
                                                          //   _enquiryModel3[index]
                                                          //       .referenceNumber!
                                                          //       .toString(),
                                                          //   style:
                                                          //       styles.heading6bold,
                                                          // ),
                                                          // Text(
                                                          //   "RM " +
                                                          //       _enquiryModel3[
                                                          //               index]
                                                          //           .nettCalculations!
                                                          //           .total!
                                                          //           .toString(),
                                                          //   style: styles
                                                          //       .heading12bold,
                                                          // ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  // SizedBox(height: 10),
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment
                                                  //           .spaceBetween,
                                                  //   children: [
                                                  //     Column(
                                                  //       crossAxisAlignment:
                                                  //           CrossAxisAlignment
                                                  //               .start,
                                                  //       children: [
                                                  //         Text(
                                                  //             'iPayment Ref. No.'
                                                  //                     .tr +
                                                  //                 ':'),
                                                  //         Text(
                                                  //             'Bill Reference Date'
                                                  //                     .tr +
                                                  //                 ':'),
                                                  //         Text('Status'.tr +
                                                  //             ':'),
                                                  //         Text(
                                                  //             'Transaction Charged To'
                                                  //                     .tr +
                                                  //                 ':'),
                                                  //       ],
                                                  //     ),
                                                  //     Column(
                                                  //       crossAxisAlignment:
                                                  //           CrossAxisAlignment
                                                  //               .end,
                                                  //       children: [
                                                  //         Text(
                                                  //           _enquiryModel3[
                                                  //                   index]
                                                  //               .billNumber!
                                                  //               .toString(),
                                                  //         ),
                                                  //         _enquiryModel3[index]
                                                  //                     .startAt !=
                                                  //                 null
                                                  //             ? Text(
                                                  //                 formatDate(
                                                  //                   DateTime.parse(_enquiryModel3[
                                                  //                           index]
                                                  //                       .startAt
                                                  //                       .toString()),
                                                  //                   [
                                                  //                     dd,
                                                  //                     '/',
                                                  //                     mm,
                                                  //                     '/',
                                                  //                     yyyy
                                                  //                   ],
                                                  //                 ),
                                                  //               )
                                                  //             : Text(
                                                  //                 "No date".tr),
                                                  //         Text(
                                                  //           _enquiryModel3[index]
                                                  //                       .status!
                                                  //                       .toString() ==
                                                  //                   "Aktif"
                                                  //               ? "Active".tr
                                                  //               : "Inactive".tr,
                                                  //         ),
                                                  //         Text(
                                                  //           _enquiryModel3[index]
                                                  //                       .service!
                                                  //                       .chargedTo
                                                  //                       .toString() ==
                                                  //                   "Kerajaan"
                                                  //               ? "Goverment".tr
                                                  //               : "Customer".tr,
                                                  //         ),
                                                  //       ],
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: constants.secondaryColor,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Row(
                    children: [
                      _isIndividuPage
                          ? SizedBox(
                              height: 20,
                              child: Checkbox(
                                side: const BorderSide(
                                  color: Colors.amber,
                                  width: 1.5,
                                ),
                                checkColor: Colors.white,
                                activeColor: Colors.amber,
                                value: allChecked,
                                onChanged: (bool? value) async {
                                  int count = 0;
                                  for (var i = 0;
                                      i < _enquiryModel2.length;
                                      i++) {
                                    if (_enquiryModel2[i].checked == true) {
                                      count++;
                                    }
                                  }
                                  if (count == 0) {
                                    print("count == 0");
                                    for (var e = 0;
                                        e < _enquiryModel2.length;
                                        e++) {
                                      setState(() {
                                        _enquiryModel2[e].checked =
                                            !_enquiryModel2[e].checked!;
                                        allChecked = !allChecked;
                                      });
                                    }
                                  }
                                  if (count > 0) {
                                    print("count > 0");
                                    for (var e = 0;
                                        e < _enquiryModel2.length;
                                        e++) {
                                      setState(() {
                                        _enquiryModel2[e].checked = true;
                                        allChecked = !allChecked;
                                      });
                                    }
                                  }
                                  if (count == _enquiryModel2.length) {
                                    print("count == _enquiryModel2.length");
                                    for (var e = 0;
                                        e < _enquiryModel2.length;
                                        e++) {
                                      setState(() {
                                        _enquiryModel2[e].checked = false;
                                        allChecked = !allChecked;
                                      });
                                    }
                                  }
                                  await checkVisibility();
                                  await checkAllTick();
                                },
                              ),
                            )
                          : SizedBox(
                              height: 20,
                              child: Checkbox(
                                side: const BorderSide(
                                  color: Colors.amber,
                                  width: 1.5,
                                ),
                                checkColor: Colors.white,
                                activeColor: Colors.amber,
                                value: allChecked2,
                                onChanged: (bool? value) async {
                                  int count = 0;
                                  for (var i = 0;
                                      i < _enquiryModel3.length;
                                      i++) {
                                    if (_enquiryModel3[i].checked == true) {
                                      count++;
                                    }
                                  }
                                  if (count == 0) {
                                    print("count == 0");
                                    for (var e = 0;
                                        e < _enquiryModel3.length;
                                        e++) {
                                      setState(() {
                                        _enquiryModel3[e].checked =
                                            !_enquiryModel3[e].checked!;
                                        allChecked2 = !allChecked2;
                                      });
                                    }
                                  }
                                  if (count > 0) {
                                    print("count > 0");
                                    for (var e = 0;
                                        e < _enquiryModel3.length;
                                        e++) {
                                      setState(() {
                                        _enquiryModel3[e].checked = true;
                                        allChecked2 = !allChecked2;
                                      });
                                    }
                                  }
                                  if (count == _enquiryModel3.length) {
                                    print("count == _enquiryModel2.length");
                                    for (var e = 0;
                                        e < _enquiryModel3.length;
                                        e++) {
                                      setState(() {
                                        _enquiryModel3[e].checked = false;
                                        allChecked2 = !allChecked2;
                                      });
                                    }
                                  }
                                  await checkVisibility();
                                  await checkAllTick2();
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        height: 40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total'.tr),
                            Text(
                              // "RM " + (sum3+sum4).toStringAsFixed(2).toString(),
                              "RM " + sum3.toStringAsFixed(2).toString(),
                              // "RM " + (sum3 * 100000).toStringAsFixed(2).toString(),
                              style: styles.heading13Primary,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: AddToCartButton(
                  onPressed: () async {
                    if (!_isVisibileBtn) {
                      Get.snackbar(
                        snackPosition: SnackPosition.TOP,
                        "".tr,
                        'At least one item must be selected.'.tr,
                        messageText: Text(
                          'At least one item must be selected.'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                        padding: EdgeInsets.only(bottom: 30, left: 16),
                        backgroundColor: Colors.red,
                      );
                    } else {
                      await checkCartable();
                    }
                  },
                  icon: LineIcons.addToShoppingCart,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: constants.primaryColor,
                  child: CheckoutButton(
                    onPressed: () async {
                      if (countCheck == 0) {
                        Get.snackbar(
                          snackPosition: SnackPosition.TOP,
                          "".tr,
                          'At least one item must be selected.'.tr,
                          messageText: Text(
                            'At least one item must be selected.'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                          padding: EdgeInsets.only(bottom: 30, left: 16),
                          backgroundColor: Colors.red,
                        );
                      } else {
                        await checkCartable2();
                      }
                    },
                    text: "Checkout (@count)"
                        .trParams({'count': countCheck.toString()}),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  billDetails(enquiryModel2) async {
    bool init = await navigate(context, BillDetailsScreen(enquiryModel2, ""));
    if (init) _getData();
  }

  checkVisibility() {
    int count = 0;
    var newList = [
      ..._enquiryModel2,
      ..._enquiryModel3,
    ];
    List status = [];
    sum3 = 0;
    for (var i = 0; i < newList.length; i++) {
      if (newList[i].checked == true) {
        setState(() {
          _isVisibileBtn = true;
        });

        sum3 += double.parse((newList[i].nettCalculations!.total!.toString()));

        setState(() {});
      }

      if (newList[i].checked == true) {
        count++;
      }
      if (newList[i].checked == true && newList[i].status == "Aktif") {
        // print("Activate");
        status.add(newList[i].status);
        // setState(() {
        //   disableCart = false;
        //   disablePay = false;
        // });
      }
      if (newList[i].checked == true &&
          (newList[i].status == "Tidak Aktif" ||
              newList[i].status == "Dibayar" ||
              newList[i].status == "Tamat Tempoh" ||
              newList[i].status == "Batal")) {
        // print("Deactivate");
        status.add(newList[i].status);
        //   setState(() {
        //     disableCart = true;
        //     disablePay = true;
        //   });
        // }
      }
      status = status.toSet().toList();
      for (var i = 0; i < status.length; i++) {
        // print(i.toString());
        // print(status[i]);
      }
      if (status.contains("Aktif")) {
        setState(() {
          disableCart = false;
          disablePay = false;
        });
      }
      if (status.contains("Tidak Aktif") ||
          status.contains("Dibayar") ||
          status.contains("Tamat Tempoh") ||
          status.contains("Batal")) {
        setState(() {
          disableCart = true;
          disablePay = true;
        });
      }
    }

    print(sum3);

    if (count == 0) {
      setState(() {
        _isVisibileBtn = false;
        // disableCart = false;
        // i = _enquiryModel2.length;
      });
    }

    if (count > 1) {
      setState(() {
        _isVisibileBtn = true;
        // disableCart = false;
        // i = _enquiryModel2.length;
      });
    }

    setState(() {
      countCheck = count;
    });
    // print("checkVisibility sum3 " + sum3.toString());
    // print("checkVisibility count " + count.toString());
    // print("checkVisibility disableCart " + disableCart.toString());
    // print("checkVisibility _isVisibileBtn " + _isVisibileBtn.toString());
    // int count = 0;
    // setState(() {
    //   _isVisibileBtn = true;
    //   disableCart = true;
    // });

    // for (var i = 0; i < _enquiryModel2.length; i++) {
    //   if (_enquiryModel2[i].checked == true &&
    //       _enquiryModel2[i].status == "Aktif") {
    //     setState(() {
    //       // _isVisibileBtn = false;
    //       disableCart = false;
    //       // i = _enquiryModel2.length;
    //     });
    //   }
    //   if (_enquiryModel2[i].checked == true) {
    //     count++;
    //   }
    //   if (count == 0) {
    //     setState(() {
    //       _isVisibileBtn = false;
    //       // disableCart = false;
    //       // i = _enquiryModel2.length;
    //     });
    //   } else {
    //     setState(() {
    //       _isVisibileBtn = true;
    //       // disableCart = false;
    //       // i = _enquiryModel2.length;
    //     });
    //   }
    // }
  }

  checkAllTick() {
    setState(() {
      preTick = 0;
      // sum3 = 0;
    });
    for (var i = 0; i < _enquiryModel2.length; i++) {
      if (_enquiryModel2[i].checked == true) {
        preTick++;
        // sum3 += double.parse(
        //     (_enquiryModel2[i].nettCalculations!.total!.toString()));
      }

      setState(() {});
    }

    if (_enquiryModel2.length >= preTick) {
      setState(() {
        allChecked = true;
      });
    }
    if (preTick < _enquiryModel2.length) {
      setState(() {
        allChecked = false;
      });
    }
    // print("checkAllTick sum3 " + sum3.toString());
  }

  checkAllTick2() {
    setState(() {
      preTick = 0;
      // sum4 = 0;
    });
    for (var i = 0; i < _enquiryModel3.length; i++) {
      if (_enquiryModel3[i].checked == true) {
        preTick++;
        // sum4 += double.parse(
        //     (_enquiryModel3[i].nettCalculations!.total!.toString()));
      }

      setState(() {});
      if (_enquiryModel3.length >= preTick) {
        setState(() {
          allChecked2 = true;
        });
      }
      if (preTick < _enquiryModel3.length) {
        setState(() {
          allChecked2 = false;
        });
      }
    }
  }

  checkCartable() async {
    print("cart Individu");
    setState(() {
      cartable = true;
      precart = [];
      precart2 = [];
      realcart = [];
      realcart2 = [];
      one = false;
      two = false;
    });
    // print("print(_enquiryModel2.length.toString());");
    // print(_enquiryModel2.length.toString());
    for (var i = 0; i < _enquiryModel2.length; i++) {
      if (_enquiryModel2[i].checked == true) {
        precart.add(_enquiryModel2[i].service!.chargedTo);
        precart2.add(_enquiryModel2[i].billTypeId.toString());
        if (_enquiryModel2[i].status == "Aktif"
            // && _enquiryModel2[i].billTypeId == 1
            ) {
          print(_enquiryModel2[i].referenceNumber.toString());
          realcart.add(_enquiryModel2[i]);
        }
      }
    }

    for (var i = 0; i < _enquiryModel3.length; i++) {
      if (_enquiryModel3[i].checked == true) {
        precart.add(_enquiryModel3[i].service!.chargedTo);
        precart2.add(_enquiryModel3[i].billTypeId.toString());
        if (_enquiryModel3[i].status == "Aktif"
            // &&   _enquiryModel3[i].billTypeId == 2
            ) {
          realcart2.add(_enquiryModel3[i]);
        }
        // realcart.add(_enquiryModel3[i]);
      }
    }

    if (precart.contains("Kerajaan") && precart.contains("Pelanggan")) {
      setState(() {
        cartable = false;
      });

      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        "".tr,
        'Single checkout is allowed for bills under the same category only.'.tr,
        messageText: Text(
          'Single checkout is allowed for bills under the same category only.'
              .tr,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        padding: EdgeInsets.only(bottom: 30, left: 16),
        backgroundColor: Colors.red,
      );
    }

    // for (var v = 0; v < precart2.length; v++) {
    //   if (precart2.contains("Pengesahan 2") ||
    //       precart2.contains("Pengesahan 1") ||
    //       precart2.contains("Batal")) {
    //     setState(() {
    //       cartable = false;
    //     });
    //   }
    //   // snack(context, "Aktif sahaja");
    // }
    // for (var i = 0; i < precart.length; i++) {
    //   print(realcart[i]);
    // }
    // if (cartable == false) {
    //   snack(context,
    //       "Pembayaran serentak dibenarkan bagi bil-bil dibawah kategori yang sama sahaja.");
    // }

    for (var i = 0; i < precart2.length; i++) {
      print(precart2[i]);
      if (precart2[i].contains("1")) {
        setState(() {
          one = true;
        });
      }
      if (precart2[i].contains("2")) {
        setState(() {
          two = true;
        });
      }
    }

    print(one);
    print("------");
    print(two);
    //Bill type 1 only
    if (cartable == true && one == true && two == false) {
      // bool a = await navigate(context, TestingBill(realcart));
      // if (a) {
      //   _getData();
      // }

      print("Show amount 1 ");
      print("length");
      print(realcart.length.toString());
      double sum2 = 0.0;
      for (var i = 0; i < realcart.length; i++) {
        print(realcart[i].nettCalculations!.total!);
        sum2 += (realcart[i].nettCalculations!.total!);
      }
      print(sum2.toString());
      // String? a = await confirmAddtoCart(context, sum, [
      //   RichText(
      //     textAlign: TextAlign.center,
      //     text: TextSpan(
      //       style: const TextStyle(
      //         fontSize: 16.0,
      //         color: Colors.black,
      //       ),
      //       children: [
      //         TextSpan(
      //           text: "Total Amount is RM ".tr +
      //               sum2.toStringAsFixed(2).toString(),
      //           style: TextStyle(
      //             color: constants.primaryColor,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ]);
      // print("a");
      // print(a);
      // if (a == 'yes') {
      print("realcart.length " + realcart.length.toString());
      List a = [];
      for (var i = 0; i < realcart.length; i++) {
        a.add({
          "service_id": null,
          "bill_id": realcart[i].id,
          "amount": realcart[i]
              .nettCalculations!
              .total!
              .toStringAsFixed(2)
              .toString(),
          "details": {}
        });
      }

      ErrorResponse response =
          await api.addToCartIkhwan("", "", "", "", jsonEncode(a));
      print("response.data");
      print(response.message);
      print(response.data);
      print(response.isSuccessful);
      if (response.isSuccessful == true) {
        snack(context, "Added to cart successfully.".tr);
      }
      await _getData();
      // }
    } else if (cartable == true && one == false && two == true) {
      print("Show amount 2");
      var newList = [
        ...realcart2,
        ...realcart,
      ];
      // print(sum2.toString());
      // print("===========");
      // print(realcart2[0].amount.toString());
      // print("===========");
      bool a = await navigate(context, TestingBill2(newList));
      if (a) {
        _getData();
      }
      // Get.bottomSheet(
      //   isDismissible: false,
      //   ListView(
      //     children: [
      //       AppBar(
      //         backgroundColor: constants.secondaryColor,
      //         centerTitle: true,
      //         leading: Container(),
      //         title: Text(
      //           "Bil Tanpa Amaun",
      //           style: TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.w500,
      //           ),
      //         ),
      //         actions: [
      //           IconButton(
      //             onPressed: () {
      //               Navigator.pop(context, "no");
      //               _formKey.currentState?.dispose();
      //             },
      //             icon: Icon(Icons.close_rounded),
      //           )
      //         ],
      //       ),
      //       ListTile(
      //           leading: Icon(Icons.info),
      //           title: Text(
      //               "Amaun dilaraskan berdasarkan Pekeliling Perbendaharaan Malaysia.")),
      //       ListView.builder(
      //         physics: NeverScrollableScrollPhysics(),
      //         shrinkWrap: true,
      //         itemCount: realcart2.length,
      //         //  _organizationModel.length,
      //         itemBuilder: (context, index) {
      //           return Column(
      //             children: [
      //               ListTile(
      //                 title: Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Text(realcart2[index].referenceNumber),
      //                 ),
      //                 subtitle: Form(
      //                   key: _formKey,
      //                   child: TextFormField(
      //                     enableSuggestions: false,
      //                     keyboardType: TextInputType.number,
      //                     expands: false,
      //                     autocorrect: false,
      //                     decoration: styles.inputDecoration.copyWith(
      //                       label: getRequiredLabel('Masukkan Amaun'),
      //                     ),
      //                     onChanged: (val) async {
      //                       // setState(() {
      //                       //   realcart2[index].amount = val.toString();
      //                       // });
      //                       a = {};
      //                       a = await api.GetRounding(val);
      //                       setState(() {
      //                         a = a;
      //                       });

      //                       if (a['value'] != 0 || a['value'] != -0) {
      //                         double test = 0;
      //                         test = double.parse(val) + a['value'];
      //                         print(test.toString());
      //                         setState(() {
      //                           val = test.toString();
      //                           realcart2[index].amount = val.toString();
      //                         });
      //                         print(a.isNotEmpty);
      //                         print(a['value']);
      //                         print(realcart2[index].amount);
      //                         // _refreshIndicatorKey.currentState?.show();

      //                         // Future.delayed(const Duration(seconds: 1)).then(
      //                         //   (value) => setState(
      //                         //     () {

      //                         //     },
      //                         //   ),
      //                         // );
      //                       }
      //                     },
      //                     validator: (value) {
      //                       if (value == null || value.isEmpty) {
      //                         return 'Sila masukkan amaun bayaran';
      //                       }
      //                       return null;
      //                     },
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           );
      //         },
      //       ),
      //       // ),
      //       SizedBox(
      //         height: 20,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Constants().sixColor,
      //             fixedSize: const Size(100, 60),
      //             elevation: 0,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(12.0),
      //             ),
      //           ),
      //           onPressed: () async {
      //             setState(() {
      //               realcart2.add({"referenceNumber": "123123123123"});
      //             });
      //             print("after");
      //             print(realcart2.length.toString());
      //             // Navigator.pop(context, "yes");
      //             // _formKey.currentState?.dispose();
      //           },
      //           child: SizedBox(
      //             width: double.infinity,
      //             child: Text(
      //               "CALCULATE",
      //               style: styles.raisedButtonTextWhite,
      //               textAlign: TextAlign.center,
      //             ),
      //           ),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Constants().sixColor,
      //             fixedSize: const Size(100, 60),
      //             elevation: 0,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(12.0),
      //             ),
      //           ),
      //           onPressed: () async {
      //             Navigator.pop(context, "no");
      //             _formKey.currentState?.dispose();
      //           },
      //           child: SizedBox(
      //             width: double.infinity,
      //             child: Text(
      //               "SUMBIT",
      //               style: styles.raisedButtonTextWhite,
      //               textAlign: TextAlign.center,
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      //   backgroundColor: Colors.white,
      // );
      // if (again == "yes") {
      //   Get.bottomSheet(
      //     isDismissible: false,
      //     Builder(builder: (context) {
      //       return ListView(
      //         children: [
      //           AppBar(
      //             backgroundColor: constants.secondaryColor,
      //             centerTitle: true,
      //             leading: Container(),
      //             title: Text(
      //               "Bil Tanpa Amaun",
      //               style: TextStyle(
      //                 fontSize: 18,
      //                 fontWeight: FontWeight.w500,
      //               ),
      //             ),
      //             actions: [
      //               IconButton(
      //                 onPressed: () {
      //                   Navigator.pop(context, false);
      //                   _formKey.currentState?.dispose();
      //                   // _refreshIndicatorKey.currentState?.dispose();
      //                 },
      //                 icon: Icon(Icons.close_rounded),
      //               )
      //             ],
      //           ),
      //           ListTile(
      //               leading: Icon(Icons.info),
      //               title: Text(
      //                   "Amaun dilaraskan berdasarkan Pekeliling Perbendaharaan Malaysia.")),
      //           // RefreshIndicator(
      //           //   key: _refreshIndicatorKey,
      //           //   color: Colors.white,
      //           //   backgroundColor: Colors.blue,
      //           //   strokeWidth: 4.0,
      //           //   onRefresh: () async {
      //           //     _refreshIndicatorKey.currentState?.show();
      //           //   },
      //           //   child:
      //           ListView.builder(
      //               physics: NeverScrollableScrollPhysics(),
      //               shrinkWrap: true,
      //               itemCount: realcart2.length,
      //               //  _organizationModel.length,
      //               itemBuilder: (context, index) {
      //                 return Column(
      //                   children: [
      //                     ListTile(
      //                       title: Padding(
      //                         padding: const EdgeInsets.all(8.0),
      //                         child: Text(realcart2[index].referenceNumber),
      //                       ),
      //                       subtitle: Form(
      //                         key: _formKey,
      //                         child: TextFormField(
      //                           enableSuggestions: false,
      //                           keyboardType: TextInputType.number,
      //                           expands: false,
      //                           autocorrect: false,
      //                           decoration: styles.inputDecoration.copyWith(
      //                             label: getRequiredLabel('Masukkan Amaun'),
      //                           ),
      //                           onChanged: (val) async {
      //                             a = {};
      //                             a = await api.GetRounding(val);
      //                             setState(() {
      //                               a = a;
      //                             });
      //                             if (a['value'] != 0 || a['value'] != -0) {
      //                               double test = 0;
      //                               test = double.parse(val) + a['value'];
      //                               print(test.toString());
      //                               setState(() {
      //                                 val = test.toString();
      //                                 realcart2[index].amount = val.toString();
      //                               });
      //                               print(a.isNotEmpty);
      //                               print(a['value']);
      //                               print(realcart2[index].amount);
      //                             }
      //                           },
      //                           validator: (value) {
      //                             if (value == null || value.isEmpty) {
      //                               return 'Sila masukkan amaun bayaran';
      //                             }
      //                             return null;
      //                           },
      //                         ),
      //                       ),
      //                     ),
      //                     a.isNotEmpty == true
      //                         ? ListTile(
      //                             title: Padding(
      //                               padding: const EdgeInsets.all(8.0),
      //                               child: Text(
      //                                   "Amaun setelah dilaras ialah : RM " +
      //                                       realcart2[index].amount),
      //                             ),
      //                           )
      //                         : Container(),
      //                   ],
      //                 );
      //               }),
      //           // ),
      //           SizedBox(
      //             height: 20,
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                 backgroundColor: Constants().sixColor,
      //                 fixedSize: const Size(100, 60),
      //                 elevation: 0,
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(12.0),
      //                 ),
      //               ),
      //               onPressed: () async {
      //                 Navigator.pop(context, false);
      //                 if (_formKey.currentState!.validate()) {
      //                   print("yes");
      //                   for (var i = 0; i < realcart2.length; i++) {
      //                     print(realcart2.length);
      //                     print(realcart2[i].amount);
      //                     ErrorResponse response = await api.addToCart(
      //                         realcart2[i].serviceId.toString(),
      //                         "",
      //                         realcart2[i].referenceNumber!,
      //                         realcart2[i].amount.toString(), []);
      //                     print("response.data");
      //                     print(response.message);
      //                     print(response.data);
      //                     print(response.isSuccessful);
      //                     print(response.isSuccessful == true);
      //                     print(i == (realcart2.length - 1));
      //                     if (response.isSuccessful == true &&
      //                         i == (realcart2.length - 1)) {
      //                       await snack(
      //                           context, "Berjaya dimasukkan ke dalam troli");
      //                     }
      //                   }
      //                   Get.back();
      //                   await _getData();
      //                 }
      //               },
      //               child: SizedBox(
      //                 width: double.infinity,
      //                 child: Text(
      //                   "SUBMIT",
      //                   style: styles.raisedButtonTextWhite,
      //                   textAlign: TextAlign.center,
      //                 ),
      //               ),
      //             ),
      //           )
      //         ],
      //       );
      //     }),
      //     backgroundColor: Colors.white,
      //   );
      // }
    } else if (cartable == true && one == true && two == true) {
      var newList = [
        ...realcart2,
        ...realcart,
      ];
      bool a = await navigate(context, PreCheckout(newList));
      if (a) {
        _getData();
      }
      // Get.bottomSheet(
      //   ListView(
      //     children: [
      //       AppBar(
      //         backgroundColor: constants.secondaryColor,
      //         centerTitle: true,
      //         leading: Container(),
      //         title: Text(
      //           "Bil Tanpa Amaun",
      //           style: TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.w500,
      //           ),
      //         ),
      //         actions: [
      //           IconButton(
      //             onPressed: () => Get.back(),
      //             icon: Icon(Icons.close_rounded),
      //           )
      //         ],
      //       ),
      //       ListView.builder(
      //           physics: NeverScrollableScrollPhysics(),
      //           shrinkWrap: true,
      //           itemCount: realcart2.length,
      //           //  _organizationModel.length,
      //           itemBuilder: (context, index) {
      //             return ListTile(
      //               title: Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Text(realcart2[index].referenceNumber),
      //               ),
      //               subtitle: Form(
      //                 key: _formKey,
      //                 child: TextFormField(
      //                   keyboardType: TextInputType.number,
      //                   expands: false,
      //                   autocorrect: false,
      //                   decoration: styles.inputDecoration.copyWith(
      //                     label: getRequiredLabel('Masukkan Amaun'),
      //                   ),
      //                   onChanged: (val) {
      //                     setState(() {
      //                       realcart2[index].amount = val.toString();
      //                     });

      //                     // Future.delayed(const Duration(seconds: 1))
      //                     //     .then((value) => setState(() {
      //                     //           print(val);
      //                     //           amount.add(val);
      //                     //         }));
      //                     // amount.add(val);
      //                   },
      //                   validator: (value) {
      //                     if (value == null || value.isEmpty) {
      //                       return 'Sila masukkan amaun bayaran';
      //                     }
      //                     return null;
      //                   },
      //                 ),
      //               ),
      //               // onTap: () {
      //               //   // print(_enquiryModel6[index].name!);
      //               //   // setState(() {
      //               //   //   gateway = _enquiryModel6[index].name!.toString();
      //               //   //   gatewayMethod = _enquiryModel6[index].id!.toString();
      //               //   // });

      //               //   Get.back();
      //               // },
      //             );
      //           }),
      //       SizedBox(
      //         height: 20,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Constants().sixColor,
      //             fixedSize: const Size(100, 60),
      //             elevation: 0,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(12.0),
      //             ),
      //           ),
      //           onPressed: () async {
      //             if (_formKey.currentState!.validate()) {
      //               print("yes");
      //               for (var i = 0; i < realcart.length; i++) {
      //                 print(realcart.length);
      //                 print(realcart[i].amount);
      //                 ErrorResponse response = await api.addToCart(
      //                     realcart[i].serviceId.toString(),
      //                     "",
      //                     realcart[i].referenceNumber!,
      //                     realcart[i].nettAmount.toString(), []);
      //                 print("response.data");
      //                 print(response.message);
      //                 print(response.data);
      //                 print(response.isSuccessful);
      //               }

      //               for (var i = 0; i < realcart2.length; i++) {
      //                 print(realcart2.length);
      //                 print(realcart2[i].amount);
      //                 ErrorResponse response = await api.addToCart(
      //                     realcart2[i].serviceId.toString(),
      //                     "",
      //                     realcart2[i].referenceNumber!,
      //                     realcart2[i].amount.toString(), []);
      //                 print("response.data");
      //                 print(response.message);
      //                 print(response.data);
      //                 print(response.isSuccessful);
      //                 if (response.isSuccessful == true &&
      //                     i == realcart2.length - 1) {
      //                   await snack(
      //                       context, "Berjaya dimasukkan ke dalam troli");
      //                 }
      //               }
      //               Get.back();
      //               await _getData();
      //             }
      //           },
      //           child: SizedBox(
      //             width: double.infinity,
      //             child: Text(
      //               "SUBMIT",
      //               style: styles.raisedButtonTextWhite,
      //               textAlign: TextAlign.center,
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      //   backgroundColor: Colors.white,
      // );
    } else {
      print("What to Show amount");
    }

    //ITEM _enquiryModel2[i].checked = true BRING TO CART
  }

  checkCartable2() async {
    print("cart Organisasi");
    setState(() {
      cartable = true;
      precart = [];
      precart2 = [];
      realcart = [];
      one = false;
      two = false;
    });
//Bill Individu
    for (var i = 0; i < _enquiryModel2.length; i++) {
      if (_enquiryModel2[i].checked == true) {
        precart.add(_enquiryModel2[i].service!.chargedTo);
        precart2.add(_enquiryModel2[i].billTypeId.toString());
        if (_enquiryModel2[i].status == "Aktif"
            //  && _enquiryModel2[i].billTypeId == 1
            ) {
          realcart.add(_enquiryModel2[i]);
        }
      }
    }
//Bill Organisasi
    for (var i = 0; i < _enquiryModel3.length; i++) {
      if (_enquiryModel3[i].checked == true) {
        precart.add(_enquiryModel3[i].service!.chargedTo);
        precart2.add(_enquiryModel3[i].billTypeId.toString());
        if (_enquiryModel3[i].status == "Aktif"
            // && _enquiryModel3[i].billTypeId == 2
            ) {
          realcart2.add(_enquiryModel3[i]);
        }
        // realcart.add(_enquiryModel3[i]);
      }
    }

    if (precart.contains("Kerajaan") && precart.contains("Pelanggan")) {
      setState(() {
        cartable = false;
      });

      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        "".tr,
        'Single checkout is allowed for bills under the same category only.'.tr,
        messageText: Text(
          'Single checkout is allowed for bills under the same category only.'
              .tr,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        padding: EdgeInsets.only(bottom: 30, left: 16),
        backgroundColor: Colors.red,
      );
    }

    // for (var v = 0; v < precart2.length; v++) {
    //   if (precart2.contains("Pengesahan 2") ||
    //       precart2.contains("Pengesahan 1") ||
    //       precart2.contains("Batal")) {
    //     setState(() {
    //       cartable = false;
    //     });
    //   }
    //   // snack(context, "Aktif sahaja");
    // }
    // for (var i = 0; i < precart.length; i++) {
    //   print(realcart[i]);
    // }
    // if (cartable == false) {
    //   snack(context,
    //       "Pembayaran serentak dibenarkan bagi bil-bil dibawah kategori yang sama sahaja.");
    // }
    for (var i = 0; i < precart2.length; i++) {
      print(precart2[i]);
      if (precart2[i].contains("1")) {
        setState(() {
          one = true;
        });
      }
      if (precart2[i].contains("2")) {
        setState(() {
          two = true;
        });
      }
    }

    print(one);
    print("------");
    print(two);

//Bil Sahaja Tiada Bil Tanpa Amaun

    if (cartable == true && one == true && two == false) {
      print("Show amount 1 ");
      double sum2 = 0.0;
      print("realcart.length.toString() " + realcart.length.toString());
      for (var i = 0; i < realcart.length; i++) {
        print(realcart[0].nettCalculations!.total!);
        sum2 += realcart[i].nettCalculations!.total!;
      }
      print(sum2.toString());
      String? a = await confirmPayment2(context, sum, [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: "Total Amount is RM ".tr +
                    sum2.toStringAsFixed(2).toString(),
                style: TextStyle(
                  color: constants.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ]);
      print("a");
      print(a);
      if (a == 'yes') {
        navigate(context, CheckoutScreen(realcart, sum2));
        // for (var i = 0; i < realcart.length; i++) {
        //   ErrorResponse response = await api.addToCart(
        //       realcart[i].serviceId.toString(),
        //       "",
        //       realcart[i].referenceNumber!,
        //       realcart[i].nettAmount.toString(), []);
        //   print("response.data");
        //   print(response.message);
        //   print(response.data);
        //   print(response.isSuccessful);
        //   if (response.isSuccessful == true && i == realcart.length - 1) {
        //     snack(context, "Berjaya dimasukkan ke dalam troli");
        //   }
        // }
      }
    } else if (cartable == true && one == false && two == true) {
      print("PreCheckout 1");
      var newList = [
        ...realcart2,
        ...realcart,
      ];
      bool a = await navigate(context, PreCheckout(newList));
      if (a) {
        _getData();
      }
      // bool b = await Get.bottomSheet(
      //   ListView(
      //     children: [
      //       // Padding(
      //       //   padding: const EdgeInsets.symmetric(
      //       //       vertical: 15.0),
      //       //   child: Text(
      //       //     "Payment Options",
      //       //     style: TextStyle(
      //       //       fontSize: 18,
      //       //       fontWeight: FontWeight.w600,
      //       //     ),
      //       //   ),
      //       // ),
      //       AppBar(
      //         backgroundColor: constants.secondaryColor,
      //         centerTitle: true,
      //         leading: Container(),
      //         title: Text(
      //           "Bil Tanpa Amaun",
      //           style: TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.w500,
      //           ),
      //         ),
      //         actions: [
      //           IconButton(
      //             onPressed: () async {
      //               Navigator.pop(context, false);
      //               // Get.back();
      //               // _formKey.currentState?.deactivate();
      //               _formKey.currentState?.dispose();
      //             },
      //             icon: Icon(Icons.close_rounded),
      //           )
      //         ],
      //       ),
      //       ListView.builder(
      //           physics: NeverScrollableScrollPhysics(),
      //           shrinkWrap: true,
      //           itemCount: realcart2.length,
      //           //  _organizationModel.length,
      //           itemBuilder: (context, index) {
      //             return ListTile(
      //               title: Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Text(realcart2[index].referenceNumber),
      //               ),
      //               subtitle: Form(
      //                 key: _formKey,
      //                 child: TextFormField(
      //                   keyboardType: TextInputType.number,
      //                   expands: false,
      //                   autocorrect: false,
      //                   decoration: styles.inputDecoration.copyWith(
      //                     label: getRequiredLabel('Masukkan Amaun'),
      //                   ),
      //                   onChanged: (val) {
      //                     setState(() {
      //                       realcart2[index].amount = val.toString();
      //                     });

      //                     // Future.delayed(const Duration(seconds: 1))
      //                     //     .then((value) => setState(() {
      //                     //           print(val);
      //                     //           amount.add(val);
      //                     //         }));
      //                     // amount.add(val);
      //                   },
      //                   validator: (value) {
      //                     if (value == null || value.isEmpty) {
      //                       return 'Sila masukkan amaun bayaran';
      //                     }
      //                     return null;
      //                   },
      //                 ),
      //               ),
      //               // onTap: () {
      //               //   // print(_enquiryModel6[index].name!);
      //               //   // setState(() {
      //               //   //   gateway = _enquiryModel6[index].name!.toString();
      //               //   //   gatewayMethod = _enquiryModel6[index].id!.toString();
      //               //   // });

      //               //   Get.back();
      //               // },
      //             );
      //           }),
      //       SizedBox(
      //         height: 20,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Constants().sixColor,
      //             fixedSize: const Size(100, 60),
      //             elevation: 0,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(12.0),
      //             ),
      //           ),
      //           onPressed: () async {
      //             if (_formKey.currentState!.validate()) {
      //               Navigator.pop(context, true);
      //             }
      //           },
      //           child: SizedBox(
      //             width: double.infinity,
      //             child: Text(
      //               "SUBMIT",
      //               style: styles.raisedButtonTextWhite,
      //               textAlign: TextAlign.center,
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      //   backgroundColor: Colors.white,
      // );

      // print(b);
      // double sum2 = 0.0;
      // for (var i = 0; i < realcart2.length; i++) {
      //   print(realcart2[0].amount.toString());
      //   sum2 += double.parse((realcart2[i].amount));
      // }
      // print(sum2.toString());
      // String? a = await confirmPayment2(context, sum2, [
      //   RichText(
      //     textAlign: TextAlign.center,
      //     text: TextSpan(
      //       style: const TextStyle(
      //         fontSize: 16.0,
      //         color: Colors.black,
      //       ),
      //       children: [
      //         TextSpan(
      //           text:
      //               "Jumlah bil ialah RM " + sum2.toStringAsFixed(2).toString(),
      //           style: TextStyle(
      //             color: constants.primaryColor,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ]);

      // print("a");
      // print(a);
      // if (a == 'yes') {
      //   navigate(context, CheckoutScreen(realcart2, sum2));
      // }
      // if (a == 'no') {
      //   for (var i = 0; i < realcart2.length; i++) {
      //     setState(() {
      //       realcart2[i].amount = "";
      //     });
      //   }
      // }
    } else if (cartable == true && one == true && two == true) {
      var newList = [
        ...realcart2,
        ...realcart,
      ];
      print("PreCheckout 2");
      bool a = await navigate(context, PreCheckout(newList));
      if (a) {
        _getData();
      }
      // bool b = await Get.bottomSheet(
      //   ListView(
      //     children: [
      //       // Padding(
      //       //   padding: const EdgeInsets.symmetric(
      //       //       vertical: 15.0),
      //       //   child: Text(
      //       //     "Payment Options",
      //       //     style: TextStyle(
      //       //       fontSize: 18,
      //       //       fontWeight: FontWeight.w600,
      //       //     ),
      //       //   ),
      //       // ),
      //       AppBar(
      //         backgroundColor: constants.secondaryColor,
      //         centerTitle: true,
      //         leading: Container(),
      //         title: Text(
      //           "Bil Tanpa Amaun",
      //           style: TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.w500,
      //           ),
      //         ),
      //         actions: [
      //           IconButton(
      //             onPressed: () => Get.back(),
      //             icon: Icon(Icons.close_rounded),
      //           )
      //         ],
      //       ),
      //       ListView.builder(
      //           physics: NeverScrollableScrollPhysics(),
      //           shrinkWrap: true,
      //           itemCount: realcart2.length,
      //           //  _organizationModel.length,
      //           itemBuilder: (context, index) {
      //             return ListTile(
      //               title: Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Text(realcart2[index].referenceNumber),
      //               ),
      //               subtitle: Form(
      //                 key: _formKey,
      //                 child: TextFormField(
      //                   keyboardType: TextInputType.number,
      //                   expands: false,
      //                   autocorrect: false,
      //                   decoration: styles.inputDecoration.copyWith(
      //                     label: getRequiredLabel('Masukkan Amaun'),
      //                   ),
      //                   onChanged: (val) {
      //                     setState(() {
      //                       realcart2[index].amount = val.toString() + ".00";
      //                     });
      //                     print("realcart2[index].amount");
      //                     print(realcart2[index].amount);
      //                     // Future.delayed(const Duration(seconds: 1))
      //                     //     .then((value) => setState(() {
      //                     //           print(val);
      //                     //           amount.add(val);
      //                     //         }));
      //                     // amount.add(val);
      //                   },
      //                   validator: (value) {
      //                     if (value == null || value.isEmpty) {
      //                       return 'Sila masukkan amaun bayaran';
      //                     }
      //                     return null;
      //                   },
      //                 ),
      //               ),
      //               // onTap: () {
      //               //   // print(_enquiryModel6[index].name!);
      //               //   // setState(() {
      //               //   //   gateway = _enquiryModel6[index].name!.toString();
      //               //   //   gatewayMethod = _enquiryModel6[index].id!.toString();
      //               //   // });

      //               //   Get.back();
      //               // },
      //             );
      //           }),
      //       SizedBox(
      //         height: 20,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Constants().sixColor,
      //             fixedSize: const Size(100, 60),
      //             elevation: 0,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(12.0),
      //             ),
      //           ),
      //           onPressed: () async {
      //             if (_formKey.currentState!.validate()) {
      //               Navigator.pop(context, true);
      //               Get.back();
      //             }
      //           },
      //           child: SizedBox(
      //             width: double.infinity,
      //             child: Text(
      //               "SUBMIT",
      //               style: styles.raisedButtonTextWhite,
      //               textAlign: TextAlign.center,
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      //   backgroundColor: Colors.white,
      // );

      // print(b);
      // double sum2 = 0.0;
      // for (var i = 0; i < realcart2.length; i++) {
      //   print(realcart2[0].amount.toString());
      //   sum2 += double.parse((realcart2[i].amount));
      // }
      // for (var i = 0; i < realcart.length; i++) {
      //   print(realcart[0].nettAmount.toString());
      //   sum2 += double.parse((realcart[i].nettAmount));
      // }
      // print(sum2.toString());
      // String? a = await confirmPayment2(context, sum2, [
      //   RichText(
      //     textAlign: TextAlign.center,
      //     text: TextSpan(
      //       style: const TextStyle(
      //         fontSize: 16.0,
      //         color: Colors.black,
      //       ),
      //       children: [
      //         TextSpan(
      //           text:
      //               "Jumlah bil ialah RM " + sum2.toStringAsFixed(2).toString(),
      //           style: TextStyle(
      //             color: constants.primaryColor,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ]);
      // if (a == 'yes') {
      //   List realcart3 = realcart + realcart2;
      //   navigate(context, CheckoutScreen(realcart3, sum2));
      //   // for (var i = 0; i < realcart.length; i++) {
      //   //   ErrorResponse response = await api.addToCart(
      //   //       realcart[i].serviceId.toString(),
      //   //       "",
      //   //       realcart[i].referenceNumber!,
      //   //       realcart[i].nettAmount.toString(), []);
      //   //   print("response.data");
      //   //   print(response.message);
      //   //   print(response.data);
      //   //   print(response.isSuccessful);
      //   //   if (response.isSuccessful == true && i == realcart.length - 1) {
      //   //     snack(context, "Berjaya dimasukkan ke dalam troli");
      //   //   }
      //   // }
      // }
      // if (a == 'no') {
      //   for (var i = 0; i < realcart2.length; i++) {
      //     setState(() {
      //       realcart2[i].amount = "";
      //     });
      //   }
      // }
    } else {
      print("What to Show amount");
    }

    //ITEM _enquiryModel2[i].checked = true BRING TO CART
  }
}

class Heading extends StatelessWidget {
  const Heading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 10, 22, 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    'Bil Komitmen',
                    style: GoogleFonts.openSans(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Icon(
                LineIcons.addToShoppingCart,
                color: Constants().primaryColor,
                size: 35,
              ),
            ],
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              // navigate(context, SingleBillScreen());
              Map obj = {"from": "Bil", "tree": "2"};
              navigate(
                context,
                MenuBillScreen(
                  from: obj,
                ),
              );
            },
            child: Text('Bil'),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              // navigate(context, BillWithoutAmountScreen());
              Map obj = {"from": "BilNoAmaun", "tree": "1"};
              navigate(
                context,
                MenuBillScreen(
                  from: obj,
                ),
              );
            },
            child: Text('Bil Tanpa Amount'),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              // navigate(context, PaymentWithoutBillTourismScreen());
              Map obj = {"from": "BilNoBil", "tree": "1"};
              navigate(
                context,
                MenuBillScreen(
                  from: obj,
                ),
              );
            },
            child: Text('Bayar Tanpa Bil'),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              // navigate(context, PaymentWithoutBillAndAmountScreen());
              Map obj = {"from": "BilNoBilAmount", "tree": "1"};
              navigate(
                context,
                MenuBillScreen(
                  from: obj,
                ),
              );
            },
            child: Text('Bil Tanpa Bil dan Amount'),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              // navigate(context, RatelessPaymentScreen());
              Map obj = {"from": "BilNoRate", "tree": "1"};
              navigate(
                  context,
                  MenuBillScreen(
                    from: obj,
                  ));
            },
            child: Text('Bayar Tanpa Kadar'),
          ),
        ],
      ),
    );
  }
}
