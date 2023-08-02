import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/controller/favorite_service_controller.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/models/contents/favorite.dart';
import 'package:flutterbase/screens/content/home/bill/bayaran_tanpa_bill.dart';
import 'package:flutterbase/screens/content/home/bill/bayaran_tanpa_bill_dan_amaun.dart';
import 'package:flutterbase/screens/content/home/menu.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../bill/bill_details.dart';
import '../bill/precart2_bil.dart';
import 'package:flutterbase/screens/content/home/bill/bill.dart' as BillScreen;

class FavoriteService extends StatefulWidget {
  final from;
  const FavoriteService(this.from, {Key? key}) : super(key: key);

  @override
  State<FavoriteService> createState() => _FavoriteServiceState();
}

class _FavoriteServiceState extends State<FavoriteService> {
  final controller = Get.put(FavoriteServiceController());
  List<FavBills> _enquiryModel2 = [];
  // ignore: unused_field
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    print("yessss");
    _enquiryModel2 = await api.GetFavBills();
    setState(() {
      _enquiryModel2 = _enquiryModel2;
    });
    // for (var i = 0; i < _enquiryModel2.length; i++) {
    //   print(_enquiryModel2[i]['bill']['reference_number']);
    // }
    // print("dataaaaa");
    // print(_enquiryModel2[0]);
    // print(_enquiryModel2[0]['bill']);
    // print(_enquiryModel2[0]['bill']['reference_number']);

    print("length");
    print(_enquiryModel2.length);

    Future.delayed(const Duration(seconds: 1)).then(
      (value) => setState(
        () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: AppBar(
        backgroundColor: Color(0xFFf9f9f9),
        iconTheme: IconThemeData(
          color: constants.primaryColor,
        ),
        title: Center(
          child: Text(
            "Favorites Management".tr,
            style: styles.heading5,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => MenuScreen()),
            icon: Icon(LineIcons.times),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: widget.from == "Servis"
            ? SingleChildScrollView(
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: controller.favoriteServices
                        .map((element) => FavoriteTile(favorite: element))
                        .toList(),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _enquiryModel2.isEmpty
                        ? Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(50),
                              child: Column(
                                children: [
                                  SvgPicture.asset('assets/dist/aduan.svg',
                                      height:
                                          MediaQuery.of(context).size.width /
                                              3),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      'Anda tidak mempunyai bil kegemaran.',
                                      style: styles.heading5,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _enquiryModel2.length,
                      //  _organizationModel.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            billDetails(_enquiryModel2[index].payment);
                          },
                          child: Card(
                            elevation: 0,
                            color: _enquiryModel2[index].payment != null &&
                                    _enquiryModel2[index].payment!.status ==
                                        "Aktif"
                                ? Color(0xFFF5F6F9)
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // for (var item in bills)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: IconButton(
                                            icon: Icon(Icons.favorite),
                                            color: Constants().primaryColor,
                                            onPressed: () async {
                                              await api.favABill(
                                                  _enquiryModel2[index]
                                                      .billId
                                                      .toString());
                                              snack(
                                                  context,
                                                  "Successfully removed from favorites list."
                                                      .tr,
                                                  level: SnackLevel.Success);

                                              await _getData();
                                            },
                                          ),
                                        ),
                                        _enquiryModel2[index].payment != null &&
                                                _enquiryModel2[index]
                                                        .payment!
                                                        .status ==
                                                    "Aktif"
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: IconButton(
                                                  icon:
                                                      Icon(Icons.shopping_cart),
                                                  color:
                                                      Constants().primaryColor,
                                                  onPressed: () async {
                                                    print(_enquiryModel2[index]
                                                        .payment!
                                                        .billTypeId
                                                        .toString());
                                                    if (_enquiryModel2[index]
                                                                .payment !=
                                                            null &&
                                                        _enquiryModel2[index]
                                                                .payment!
                                                                .billTypeId ==
                                                            1) {
                                                      double sum2 = 0.0;
                                                      sum2 = double.parse(
                                                          _enquiryModel2[index]
                                                              .payment!
                                                              .nettCalculations!
                                                              .total
                                                              .toString());
                                                      print(sum2.toString());
                                                      String? a =
                                                          await confirmAddtoCart(
                                                              context, sum2, [
                                                        RichText(
                                                          textAlign:
                                                              TextAlign.center,
                                                          text: TextSpan(
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text: "Jumlah bil ke troli ialah RM " +
                                                                    sum2
                                                                        .toStringAsFixed(
                                                                            2)
                                                                        .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color: constants
                                                                      .primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ]);
                                                      print("a");
                                                      print(a);
                                                      if (a == 'yes') {
                                                        List a = [
                                                          {
                                                            "service_id": null,
                                                            "bill_id":
                                                                _enquiryModel2[
                                                                        index]
                                                                    .payment!
                                                                    .id,
                                                            "amount": _enquiryModel2[
                                                                    index]
                                                                .payment!
                                                                .nettCalculations!
                                                                .total!
                                                                .toStringAsFixed(
                                                                    2)
                                                                .toString(),
                                                            "details": {}
                                                          },
                                                        ];
                                                        ErrorResponse response =
                                                            await api
                                                                .addToCartIkhwan(
                                                                    "",
                                                                    "",
                                                                    "",
                                                                    "",
                                                                    jsonEncode(
                                                                        a));
                                                        print("response.data");
                                                        print(response.message);
                                                        print(response.data);
                                                        print(response
                                                            .isSuccessful);
                                                        if (response
                                                                .isSuccessful ==
                                                            true) {
                                                          snack(
                                                              context,
                                                              "Added to cart successfully."
                                                                  .tr);
                                                        }
                                                        await _getData();
                                                      }
                                                    } else if (_enquiryModel2[
                                                                    index]
                                                                .payment !=
                                                            null &&
                                                        _enquiryModel2[index]
                                                                .payment!
                                                                .billTypeId ==
                                                            2) {
                                                      bool a = await navigate(
                                                          context,
                                                          TestingBill2(
                                                              _enquiryModel2[
                                                                  index]));
                                                      if (a) {
                                                        _getData();
                                                      }
                                                      // double sum2 = 0.0;
                                                      // sum2 = double.parse(
                                                      //     _enquiryModel2[index]
                                                      //         .bill!
                                                      //         .nettAmount
                                                      //         .toString());
                                                      // print(sum2.toString());
                                                      // print(_enquiryModel2[index]
                                                      //     .bill!
                                                      //     .referenceNumber
                                                      //     .toString());
                                                      // print(_enquiryModel2[index]
                                                      //     .toString());
                                                      // Get.bottomSheet(
                                                      //   ListView(
                                                      //     children: [
                                                      //       AppBar(
                                                      //         backgroundColor:
                                                      //             constants
                                                      //                 .secondaryColor,
                                                      //         centerTitle: true,
                                                      //         leading: Container(),
                                                      //         title: Text(
                                                      //           "Bil Tanpa Amaun",
                                                      //           style: TextStyle(
                                                      //             fontSize: 18,
                                                      //             fontWeight:
                                                      //                 FontWeight
                                                      //                     .w500,
                                                      //           ),
                                                      //         ),
                                                      //         actions: [
                                                      //           IconButton(
                                                      //             onPressed: () {
                                                      //               Navigator.pop(
                                                      //                   context,
                                                      //                   false);
                                                      //               _formKey
                                                      //                   .currentState
                                                      //                   ?.dispose();
                                                      //             },
                                                      //             icon: Icon(Icons
                                                      //                 .close_rounded),
                                                      //           )
                                                      //         ],
                                                      //       ),
                                                      //       ListTile(
                                                      //         title: Padding(
                                                      //           padding:
                                                      //               const EdgeInsets
                                                      //                   .all(8.0),
                                                      //           child: Text(
                                                      //               _enquiryModel2[
                                                      //                       index]
                                                      //                   .bill!
                                                      //                   .referenceNumber
                                                      //                   .toString()),
                                                      //         ),
                                                      //         subtitle: Form(
                                                      //           key: _formKey,
                                                      //           child:
                                                      //               TextFormField(
                                                      //             initialValue:
                                                      //                 _enquiryModel2[
                                                      //                         index]
                                                      //                     .bill!
                                                      //                     .nettAmount
                                                      //                     .toString(),
                                                      //             keyboardType:
                                                      //                 TextInputType
                                                      //                     .number,
                                                      //             expands: false,
                                                      //             autocorrect:
                                                      //                 false,
                                                      //             decoration: styles
                                                      //                 .inputDecoration
                                                      //                 .copyWith(
                                                      //               label: getRequiredLabel(
                                                      //                   'Masukkan Amaun'),
                                                      //             ),
                                                      //             onChanged: (val) {
                                                      //               setState(() {
                                                      //                 _enquiryModel2[
                                                      //                             index]
                                                      //                         .bill!
                                                      //                         .amount =
                                                      //                     val.toString();
                                                      //               });

                                                      //               // Future.delayed(const Duration(seconds: 1))
                                                      //               //     .then((value) => setState(() {
                                                      //               //           print(val);
                                                      //               //           amount.add(val);
                                                      //               //         }));
                                                      //               // amount.add(val);
                                                      //             },
                                                      //             validator:
                                                      //                 (value) {
                                                      //               if (value ==
                                                      //                       null ||
                                                      //                   value
                                                      //                       .isEmpty) {
                                                      //                 return 'Sila masukkan amaun bayaran';
                                                      //               }
                                                      //               return null;
                                                      //             },
                                                      //           ),
                                                      //         ),
                                                      //         // onTap: () {
                                                      //         //   // print(_enquiryModel6[index].name!);
                                                      //         //   // setState(() {
                                                      //         //   //   gateway = _enquiryModel6[index].name!.toString();
                                                      //         //   //   gatewayMethod = _enquiryModel6[index].id!.toString();
                                                      //         //   // });

                                                      //         //   Get.back();
                                                      //         // },
                                                      //       ),
                                                      //       SizedBox(
                                                      //         height: 20,
                                                      //       ),
                                                      //       Padding(
                                                      //         padding:
                                                      //             const EdgeInsets
                                                      //                 .all(8.0),
                                                      //         child: ElevatedButton(
                                                      //           style:
                                                      //               ElevatedButton
                                                      //                   .styleFrom(
                                                      //             backgroundColor:
                                                      //                 Constants()
                                                      //                     .sixColor,
                                                      //             fixedSize:
                                                      //                 const Size(
                                                      //                     100, 60),
                                                      //             elevation: 0,
                                                      //             shape:
                                                      //                 RoundedRectangleBorder(
                                                      //               borderRadius:
                                                      //                   BorderRadius
                                                      //                       .circular(
                                                      //                           12.0),
                                                      //             ),
                                                      //           ),
                                                      //           onPressed:
                                                      //               () async {
                                                      //             if (_formKey
                                                      //                 .currentState!
                                                      //                 .validate()) {
                                                      //               print("yes");
                                                      //               if (_enquiryModel2[
                                                      //                           index]
                                                      //                       .bill!
                                                      //                       .amount
                                                      //                       .toString() ==
                                                      //                   "") {
                                                      //                 _enquiryModel2[
                                                      //                         index]
                                                      //                     .bill!
                                                      //                     .amount = _enquiryModel2[
                                                      //                         index]
                                                      //                     .bill!
                                                      //                     .nettAmount;
                                                      //               }
                                                      //               print(_enquiryModel2[
                                                      //                       index]
                                                      //                   .bill!
                                                      //                   .amount
                                                      //                   .toString());
                                                      //               ErrorResponse response = await api.addToCart(
                                                      //                   _enquiryModel2[
                                                      //                           index]
                                                      //                       .bill!
                                                      //                       .serviceId
                                                      //                       .toString(),
                                                      //                   "",
                                                      //                   _enquiryModel2[
                                                      //                           index]
                                                      //                       .bill!
                                                      //                       .referenceNumber
                                                      //                       .toString(),
                                                      //                   _enquiryModel2[
                                                      //                           index]
                                                      //                       .bill!
                                                      //                       .amount
                                                      //                       .toString(),
                                                      //                   []);
                                                      //               print(
                                                      //                   "response.data");
                                                      //               print(response
                                                      //                   .message);
                                                      //               print(response
                                                      //                   .data);
                                                      //               print(response
                                                      //                   .isSuccessful);
                                                      //               if (response
                                                      //                       .isSuccessful ==
                                                      //                   true) {
                                                      //                 Get.back();
                                                      //                 await snack(
                                                      //                     context,
                                                      //                     "Berjaya dimasukkan ke dalam troli");
                                                      //               }
                                                      //               await _getData();
                                                      //             }
                                                      //           },
                                                      //           child: SizedBox(
                                                      //             width: double
                                                      //                 .infinity,
                                                      //             child: Text(
                                                      //               "SUBMIT",
                                                      //               style: styles
                                                      //                   .raisedButtonTextWhite,
                                                      //               textAlign:
                                                      //                   TextAlign
                                                      //                       .center,
                                                      //             ),
                                                      //           ),
                                                      //         ),
                                                      //       )
                                                      //     ],
                                                      //   ),
                                                      //   backgroundColor:
                                                      //       Colors.white,
                                                      // );
                                                    }
                                                  },
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Text(
                                        //   _enquiryModel2[0]['bill']
                                        //           ['reference_number']
                                        //       .toString(),
                                        //   style: styles.heading6bold,
                                        // ),
                                        // Text(
                                        //   index.toString(),
                                        //   style: styles.heading6bold,
                                        // ),
                                        _enquiryModel2[index].payment != null
                                            ? Text(
                                                _enquiryModel2[index]
                                                    .payment!
                                                    .referenceNumber
                                                    .toString(),
                                                style: styles.heading6bold,
                                              )
                                            : Text("No Reference Number"),
                                        _enquiryModel2[index].payment != null
                                            ? Text(
                                                "RM " +
                                                    moneyFormat(double.parse(
                                                        _enquiryModel2[index]
                                                            .payment!
                                                            .nettCalculations!
                                                            .total
                                                            .toString())),
                                                style: styles.heading12bold,
                                              )
                                            : Text("No Nett Amount"),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('No Bil :'),
                                            Text('Tarikh :'),
                                            Text('Status :'),
                                            // Text('Pihak Tanggung Caj :'),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            _enquiryModel2[index].payment !=
                                                    null
                                                ? Text(
                                                    _enquiryModel2[index]
                                                        .payment!
                                                        .billNumber
                                                        .toString(),
                                                  )
                                                : Text(
                                                    "Tiada No Bill",
                                                  ),
                                            Text(
                                              formatDate(
                                                DateTime.parse(
                                                    _enquiryModel2[index]
                                                        .createdAt
                                                        .toString()),
                                                [dd, '/', mm, '/', yyyy],
                                              ),
                                            ),
                                            _enquiryModel2[index].payment !=
                                                        null &&
                                                    _enquiryModel2[index]
                                                            .payment!
                                                            .status ==
                                                        "Aktif"
                                                ? Text(_enquiryModel2[index]
                                                    .payment!
                                                    .status
                                                    .toString())
                                                : Text("Tidak Aktif"),

                                            // Text(
                                            //   _enquiryModel2[index]
                                            //       .service!
                                            //       .chargedTo!
                                            //       .toString(),
                                            // ),
                                            // Text(
                                            //   _enquiryModel2[index]
                                            //       .checked!
                                            //       .toString(),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
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
        ExpansionTile(
          tilePadding: EdgeInsets.all(1),
          title: ListTile(
            dense: true,
            title: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xFFE2EFE8),
                      child: Text(
                        favorite.service!.name
                                .split(" ")
                                .first
                                .capitalizeFirst![0] +
                            ((favorite.service!.name
                                    .split(" ")
                                    .asMap()
                                    .containsKey(1))
                                ? favorite.service!.name
                                    .split(" ")[1]
                                    .capitalizeFirst![0]
                                : ""),
                        style: TextStyle(
                          color: Color(0xFF8C9791)
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite),
                      color: Constants().primaryColor,
                      onPressed: () async {
                        // await api.favABill(
                        //     _enquiryModel2[
                        //             index]
                        //         .id
                        //         .toString());
                        // _enquiryModel2[index]
                        //             .favorite ==
                        //         1
                        //     ? snack(
                        //         context,
                        //         "Removed to favourite list successfully."
                        //             .tr,
                        //         level: SnackLevel
                        //             .Error)
                        //     : snack(
                        //         context,
                        //         "Added to favourite list successfully."
                        //             .tr,
                        //         level: SnackLevel
                        //             .Success);
                        // _getData();
                      },
                    ),
                  ],
                ),
                Align(
                  // alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: Expanded(
                      child: Text(
                        favorite.service!.name,
                        style: styles.heading12bold,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            onTap: () async {
              print(favorite.service!.billTypeId.toString());
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
                    "agencyName": "",
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
          children: [
            ListTile(
              title: Text(
                "Ministry / Department Name".tr,
                style: styles.heading12bold,
              ),
              subtitle: Text(favorite.service?.ministry?.ministryName ?? "",
                  style: styles.heading12sub),
            ),
            ListTile(
              title: Text(
                "Agency Name".tr,
                style: styles.heading12bold,
              ),
              subtitle: Text(favorite.service?.agency?.name ?? "",
                  style: styles.heading12sub),
            ),
            ListTile(
              title: Text(
                "Agency Profile".tr,
                style: styles.heading12bold,
              ),
              subtitle: Text(
                  favorite.service?.agency?.profile ??
                      "None".tr + " " + "Agency Profile".tr,
                  style: styles.heading12sub),
            ),
            ListTile(
              title: Text(
                "Menu",
                style: styles.heading12bold,
              ),
              subtitle: Text(favorite.service?.menu?.name ?? "",
                  style: styles.heading12sub),
            ),
            ListTile(
              title: Text(
                "Service Reference Number".tr,
                style: styles.heading12bold,
              ),
              subtitle: Text(favorite.service?.serviceReferenceNumber ?? "",
                  style: styles.heading12sub),
            ),
            ListTile(
              title: Text(
                "Charge To".tr,
                style: styles.heading12bold,
              ),
              subtitle: Text(favorite.service?.chargedTo ?? "Kerajaan",
                  style: styles.heading12sub),
            ),
          ],
        ),
        Divider(thickness: 1.2, indent: 10, endIndent: 10),
      ],
    );
  }
}
