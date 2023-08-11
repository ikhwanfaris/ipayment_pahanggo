import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/add_to_cart_button.dart';
import 'package:flutterbase/components/checkout_button.dart';
import 'package:flutterbase/screens/content/bill/bill_details.dart';
import 'package:flutterbase/screens/content/bill/checkout.dart';
import 'package:flutterbase/screens/content/bill/precart2_bil.dart';
import 'package:flutterbase/screens/content/bill/precheckout_bil.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import '../../../models/bills/bills.dart' as model;
import '../../../models/bills/bills.dart';
import '../cart/widgets/edit_amount_modal2.dart';

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
  List<model.Bills> billTypeOne = [];
  List<model.Bills> tempbillTypeOne = [];
  List<model.Bills> billTypeTwo = [];
  List<model.Bills> tempbillTypeTwo = [];
  List precart = [];
  List precart2 = [];
  List realcart = [];
  List realcart2 = [];
  double sum = 0.00;
  double sum2 = 0.00;
  double sum3 = 0.00;
  int preTick = 0;
  int preTick2 = 0;
  String search = "";
  String search2 = "";
  bool isSearching = false;
  bool isSearching2 = false;
  TextEditingController textStringBillTypeOne = TextEditingController();
  TextEditingController textStringBillTypeTwo = TextEditingController();
  bool disableCart = false;
  bool disablePay = false;
  bool caseOne = false;
  bool caseTwo = false;
  bool dataKerajaan = false;
  bool dataPelanggan = false;
  bool dataKerajaan2 = false;
  bool dataPelanggan2 = false;
  int count = 0;
  int countCheck = 0;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));

    billTypeOne = [];
    tempbillTypeOne = [];
    sum = 0.00;
    billTypeTwo = [];
    tempbillTypeTwo = [];
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

    billTypeOne = await api.GetBills(search, "individu");
    billTypeTwo = await api.GetBills(search2, "organisasi");

    if (isSearching == true && billTypeOne.length == 0) {
      for (var i = 0; i < billTypeOne.length; i++) {
        if (billTypeOne[i].status == "Aktif") {
          sum += billTypeOne[i].nettCalculations!.total!;
        }
        if (billTypeOne[i].service!.chargedTo.toString() == "Kerajaan" &&
            billTypeOne[i].status.toString() == "Aktif") {
          setState(() {
            dataKerajaan = true;
          });
        }
        if (billTypeOne[i].service!.chargedTo.toString() == "Pelanggan" &&
            billTypeOne[i].status.toString() == "Aktif") {
          setState(() {
            dataPelanggan = true;
          });
        }
      }
      for (var i = 0; i < billTypeTwo.length; i++) {
        if (billTypeTwo[i].service!.chargedTo.toString() == "Kerajaan" &&
            billTypeTwo[i].status.toString() == "Aktif") {
          setState(() {
            dataKerajaan2 = true;
          });
        }
        if (billTypeTwo[i].service!.chargedTo.toString() == "Pelanggan" &&
            billTypeTwo[i].status.toString() == "Aktif") {
          setState(() {
            dataPelanggan2 = true;
          });
        }
      }
      sum.toStringAsFixed(2).toString();

      snack(context, search + " tidak dijumpai.".tr);
      textStringBillTypeOne.text = "";
      search = "";
    } else {
      setState(() {
        billTypeOne = billTypeOne;
        tempbillTypeOne = billTypeOne;
      });

      for (var i = 0; i < billTypeOne.length; i++) {
        if (billTypeOne[i].status == "Aktif") {
          sum += billTypeOne[i].nettCalculations!.total!;
        }

        if (billTypeOne[i].service!.chargedTo.toString() == "Kerajaan" &&
            billTypeOne[i].status.toString() == "Aktif") {
          setState(() {
            dataKerajaan = true;
          });
        }
        if (billTypeOne[i].service!.chargedTo.toString() == "Pelanggan" &&
            billTypeOne[i].status.toString() == "Aktif") {
          setState(() {
            dataPelanggan = true;
          });
        }
        if (billTypeOne[i].status.toString() == "Aktif") {
          count += 1;
        }
      }
      for (var i = 0; i < billTypeTwo.length; i++) {
        if (billTypeTwo[i].service!.chargedTo.toString() == "Kerajaan" &&
            billTypeTwo[i].status.toString() == "Aktif") {
          setState(() {
            dataKerajaan2 = true;
          });
        }
        if (billTypeTwo[i].service!.chargedTo.toString() == "Pelanggan" &&
            billTypeTwo[i].status.toString() == "Aktif") {
          setState(() {
            dataPelanggan2 = true;
          });
        }
      }
      sum.toStringAsFixed(2).toString();
      print("count " + count.toString());
    }
    print("billTypeOne.length");
    print(billTypeOne.length);

    print("billTypeTwo.length");
    print(billTypeTwo.length);

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
            TabBar(
              onTap: _handleTabChange,
              indicatorWeight: 5.0,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  child: Text(
                    "Individual (@count)".trParams(
                      {'count': billTypeOne.length.toString()},
                    ),
                    style: styles.heading6bold,
                  ),
                ),
                Tab(
                  child: Text(
                      "Organization (@count)".trParams(
                        {'count': billTypeTwo.length.toString()},
                      ),
                      style: styles.heading6bold),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    children: [
                      HeaderTopList(
                        list: billTypeOne,
                        refreshIcon: IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () async {
                            setState(() {
                              search = "";
                              textStringBillTypeOne.text = "";
                            });

                            _getData();
                          },
                        ),
                      ),
                      ListTile(
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
                          controller: textStringBillTypeOne,
                          autocorrect: false,
                          decoration: styles.inputDecoration.copyWith(
                            labelText: 'Search'.tr,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                if (textStringBillTypeOne.text != "") {
                                  setState(() {
                                    search = textStringBillTypeOne.text;
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
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            search != "" && billTypeOne.isNotEmpty
                                ? Row(
                                    children: [
                                      Text(
                                        "You have @count bill(s) to be paid."
                                            .trParams(
                                                {"count": count.toString()}),
                                      ),
                                      const SizedBox(width: 5),
                                    ],
                                  )
                                : Container(),
                            const SizedBox(height: 5),
                            billTypeOne.isEmpty ? NoBillWidget() : Container(),
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
                              itemCount: billTypeOne.length,
                              itemBuilder: (context, index) {
                                return billTypeOne[index]
                                                .service
                                                ?.chargedTo
                                                .toString() ==
                                            "Kerajaan" &&
                                        billTypeOne[index].status.toString() ==
                                            "Aktif"
                                    ? BillItem(
                                        item: billTypeOne[index],
                                        checked: billTypeOne[index].checked!,
                                        checkBox: Checkbox(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          side: const BorderSide(
                                            color: Colors.amber,
                                            width: 1.5,
                                          ),
                                          checkColor: Colors.white,
                                          activeColor: Colors.amber,
                                          value: billTypeOne[index].checked,
                                          onChanged: (bool? value) async {
                                            if (value != null) {
                                              setState(() {
                                                billTypeOne[index].checked =
                                                    !billTypeOne[index]
                                                        .checked!;
                                              });
                                              await checkVisibility();
                                              await checkAllTick();
                                            }
                                          },
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
                              itemCount: billTypeOne.length,
                              itemBuilder: (context, index) {
                                return billTypeOne[index]
                                                .service
                                                ?.chargedTo
                                                .toString() ==
                                            "Pelanggan" &&
                                        billTypeOne[index].status.toString() ==
                                            "Aktif"
                                    ? BillItem(
                                        item: billTypeOne[index],
                                        checked: billTypeOne[index].checked!,
                                        checkBox: Checkbox(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          side: const BorderSide(
                                            color: Colors.amber,
                                            width: 1.5,
                                          ),
                                          checkColor: Colors.white,
                                          activeColor: Colors.amber,
                                          value: billTypeOne[index].checked,
                                          onChanged: (bool? value) async {
                                            if (value != null) {
                                              setState(() {
                                                billTypeOne[index].checked =
                                                    !billTypeOne[index]
                                                        .checked!;
                                              });
                                              await checkVisibility();
                                              await checkAllTick();
                                            }
                                          },
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
                      HeaderTopList(
                        list: billTypeTwo,
                        refreshIcon: IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () async {
                            setState(() {
                              search2 = "";
                            });
                            textStringBillTypeTwo.text = "";
                            _getData();
                          },
                        ),
                      ),
                      ListTile(
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
                          controller: textStringBillTypeTwo,
                          autocorrect: false,
                          decoration: styles.inputDecoration.copyWith(
                            labelText: 'Search'.tr,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                if (textStringBillTypeTwo.text != "") {
                                  setState(() {
                                    search2 = textStringBillTypeTwo.text;
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
                        ),
                      ),

                      //Jumlah keseluruhan
                      Padding(
                        padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            search2 != "" && billTypeTwo.isNotEmpty
                                ? Row(
                                    children: [
                                      Text("You have ".tr +
                                          billTypeTwo.length.toString() +
                                          " bill(s) to be paid.".tr),
                                      const SizedBox(width: 5),
                                    ],
                                  )
                                : Container(),
                            billTypeTwo.isEmpty ? NoBillWidget() : Container(),
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
                              itemCount: billTypeTwo.length,
                              itemBuilder: (context, index) {
                                return billTypeTwo[index]
                                                .service!
                                                .chargedTo!
                                                .toString() ==
                                            "Kerajaan" &&
                                        billTypeTwo[index].status.toString() ==
                                            "Aktif"
                                    ? BillItem(
                                        item: billTypeTwo[index],
                                        checked: billTypeTwo[index].checked!,
                                        checkBox: Checkbox(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          side: const BorderSide(
                                            color: Colors.amber,
                                            width: 1.5,
                                          ),
                                          checkColor: Colors.white,
                                          activeColor: Colors.amber,
                                          value: billTypeTwo[index].checked,
                                          onChanged: (bool? value) async {
                                            if (value != null) {
                                              setState(() {
                                                billTypeTwo[index].checked =
                                                    !billTypeTwo[index]
                                                        .checked!;
                                              });
                                              await checkVisibility();
                                              await checkAllTick2();
                                            }
                                          },
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
                              itemCount: billTypeTwo.length,
                              itemBuilder: (context, index) {
                                return billTypeTwo[index]
                                                .service!
                                                .chargedTo!
                                                .toString() ==
                                            "Pelanggan" &&
                                        billTypeTwo[index].status.toString() ==
                                            "Aktif"
                                    ? BillItem(
                                        item: billTypeTwo[index],
                                        checked: billTypeTwo[index].checked!,
                                        checkBox: Checkbox(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          side: const BorderSide(
                                            color: Colors.amber,
                                            width: 1.5,
                                          ),
                                          checkColor: Colors.white,
                                          activeColor: Colors.amber,
                                          value: billTypeTwo[index].checked,
                                          onChanged: (bool? value) async {
                                            if (value != null) {
                                              setState(() {
                                                billTypeTwo[index].checked =
                                                    !billTypeTwo[index]
                                                        .checked!;
                                              });
                                              await checkVisibility();
                                              await checkAllTick2();
                                            }
                                          },
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
                                  for (var i = 0; i < billTypeOne.length; i++) {
                                    if (billTypeOne[i].checked == true) {
                                      count++;
                                    }
                                  }
                                  if (count == 0) {
                                    for (var e = 0;
                                        e < billTypeOne.length;
                                        e++) {
                                      setState(() {
                                        billTypeOne[e].checked =
                                            !billTypeOne[e].checked!;
                                        allChecked = !allChecked;
                                      });
                                    }
                                  }
                                  if (count > 0) {
                                    for (var e = 0;
                                        e < billTypeOne.length;
                                        e++) {
                                      setState(() {
                                        billTypeOne[e].checked = true;
                                        allChecked = !allChecked;
                                      });
                                    }
                                  }
                                  if (count == billTypeOne.length) {
                                    for (var e = 0;
                                        e < billTypeOne.length;
                                        e++) {
                                      setState(() {
                                        billTypeOne[e].checked = false;
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
                                  for (var i = 0; i < billTypeTwo.length; i++) {
                                    if (billTypeTwo[i].checked == true) {
                                      count++;
                                    }
                                  }
                                  if (count == 0) {
                                    for (var e = 0;
                                        e < billTypeTwo.length;
                                        e++) {
                                      setState(() {
                                        billTypeTwo[e].checked =
                                            !billTypeTwo[e].checked!;
                                        allChecked2 = !allChecked2;
                                      });
                                    }
                                  }
                                  if (count > 0) {
                                    for (var e = 0;
                                        e < billTypeTwo.length;
                                        e++) {
                                      setState(() {
                                        billTypeTwo[e].checked = true;
                                        allChecked2 = !allChecked2;
                                      });
                                    }
                                  }
                                  if (count == billTypeTwo.length) {
                                    for (var e = 0;
                                        e < billTypeTwo.length;
                                        e++) {
                                      setState(() {
                                        billTypeTwo[e].checked = false;
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
                              "RM " + sum3.toStringAsFixed(2).toString(),
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

  checkVisibility() {
    int count = 0;
    var newList = [
      ...billTypeOne,
      ...billTypeTwo,
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
        status.add(newList[i].status);
      }
      if (newList[i].checked == true &&
          (newList[i].status == "Tidak Aktif" ||
              newList[i].status == "Dibayar" ||
              newList[i].status == "Tamat Tempoh" ||
              newList[i].status == "Batal")) {
        status.add(newList[i].status);
      }
      status = status.toSet().toList();
      for (var i = 0; i < status.length; i++) {}
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

    if (count == 0) {
      setState(() {
        _isVisibileBtn = false;
      });
    }

    if (count > 1) {
      setState(() {
        _isVisibileBtn = true;
      });
    }

    setState(() {
      countCheck = count;
    });
  }

  checkAllTick() {
    setState(() {
      preTick = 0;
    });
    for (var i = 0; i < billTypeOne.length; i++) {
      if (billTypeOne[i].checked == true) {
        preTick++;
      }

      setState(() {});
    }

    if (billTypeOne.length >= preTick) {
      setState(() {
        allChecked = true;
      });
    }
    if (preTick < billTypeOne.length) {
      setState(() {
        allChecked = false;
      });
    }
  }

  checkAllTick2() {
    setState(() {
      preTick = 0;
    });
    for (var i = 0; i < billTypeTwo.length; i++) {
      if (billTypeTwo[i].checked == true) {
        preTick++;
      }

      setState(() {});
      if (billTypeTwo.length >= preTick) {
        setState(() {
          allChecked2 = true;
        });
      }
      if (preTick < billTypeTwo.length) {
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
      caseOne = false;
      caseTwo = false;
    });

    for (var i = 0; i < billTypeOne.length; i++) {
      if (billTypeOne[i].checked == true) {
        precart.add(billTypeOne[i].service!.chargedTo);
        precart2.add(billTypeOne[i].billTypeId.toString());
        if (billTypeOne[i].status == "Aktif") {
          print(billTypeOne[i].referenceNumber.toString());
          realcart.add(billTypeOne[i]);
        }
      }
    }

    for (var i = 0; i < billTypeTwo.length; i++) {
      if (billTypeTwo[i].checked == true) {
        precart.add(billTypeTwo[i].service!.chargedTo);
        precart2.add(billTypeTwo[i].billTypeId.toString());
        if (billTypeTwo[i].status == "Aktif") {
          realcart2.add(billTypeTwo[i]);
        }
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

    for (var i = 0; i < precart2.length; i++) {
      if (precart2[i].contains("1")) {
        setState(() {
          caseOne = true;
        });
      }
      if (precart2[i].contains("2")) {
        setState(() {
          caseTwo = true;
        });
      }
    }

    print(caseOne);
    print("------");
    print(caseTwo);

    //Bill type 1 only
    if (cartable == true && caseOne == true && caseTwo == false) {
      print("Bill type 1 only");
      print("length");
      print(realcart.length.toString());
      double sum2 = 0.0;
      for (var i = 0; i < realcart.length; i++) {
        sum2 += (realcart[i].nettCalculations!.total!);
      }
      print(sum2.toString());

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
    } else if (cartable == true && caseOne == false && caseTwo == true) {
      print("Bill type 2 only");
      var newList = [
        ...realcart2,
        ...realcart,
      ];
      bool a = await navigate(context, TestingBill2(newList));
      if (a) {
        _getData();
      }
    } else if (cartable == true && caseOne == true && caseTwo == true) {
      print("Both Bill");
      var newList = [
        ...realcart2,
        ...realcart,
      ];
      bool a = await navigate(context, PreCheckout(newList));
      if (a) {
        _getData();
      }
    } else {}
  }

  checkCartable2() async {
    print("cart Organisasi");
    setState(() {
      cartable = true;
      precart = [];
      precart2 = [];
      realcart = [];
      caseOne = false;
      caseTwo = false;
    });
//Bill Individu
    for (var i = 0; i < billTypeOne.length; i++) {
      if (billTypeOne[i].checked == true) {
        precart.add(billTypeOne[i].service!.chargedTo);
        precart2.add(billTypeOne[i].billTypeId.toString());
        if (billTypeOne[i].status == "Aktif"
            //  && billTypeOne[i].billTypeId == 1
            ) {
          realcart.add(billTypeOne[i]);
        }
      }
    }
//Bill Organisasi
    for (var i = 0; i < billTypeTwo.length; i++) {
      if (billTypeTwo[i].checked == true) {
        precart.add(billTypeTwo[i].service!.chargedTo);
        precart2.add(billTypeTwo[i].billTypeId.toString());
        if (billTypeTwo[i].status == "Aktif") {
          realcart2.add(billTypeTwo[i]);
        }
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

    for (var i = 0; i < precart2.length; i++) {
      if (precart2[i].contains("1")) {
        setState(() {
          caseOne = true;
        });
      }
      if (precart2[i].contains("2")) {
        setState(() {
          caseTwo = true;
        });
      }
    }

    print(caseOne);
    print("------");
    print(caseTwo);

    //Bil Sahaja
    if (cartable == true && caseOne == true && caseTwo == false) {
      print("Bill type 1 only");
      double sum2 = 0.0;
      print("realcart.length.toString() " + realcart.length.toString());
      for (var i = 0; i < realcart.length; i++) {
        sum2 += realcart[i].nettCalculations!.total!;
      }
      print(sum2.toString());
      String? afterModal = await confirmPayment2(context, sum, [
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
      if (afterModal == 'yes') {
        navigate(context, CheckoutScreen(realcart, sum2));
      }
    } else if (cartable == true && caseOne == false && caseTwo == true) {
      //Bil Tanpa Amaun Sahaja
      print("Bill type 2 only");
      var newList = [
        ...realcart2,
        ...realcart,
      ];
      bool a = await navigate(context, PreCheckout(newList));
      if (a) {
        _getData();
      }
    } else if (cartable == true && caseOne == true && caseTwo == true) {
      // Bil Sahaja dan Bil Tanpa Amaun Sahaja
      var newList = [
        ...realcart2,
        ...realcart,
      ];
      print("Both Bill");
      bool a = await navigate(context, PreCheckout(newList));
      if (a) {
        _getData();
      }
    }
  }
}

// ignore: must_be_immutable
class BillItem extends StatelessWidget {
  BillItem({
    Key? key,
    required this.item,
    required this.checked,
    required this.checkBox,
  });

  final Bills item;
  bool checked;
  Widget checkBox;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        bool init = await navigate(context, BillDetailsScreen(item, ""));
        if (init) _PlaceholderBillingScreenState()._getData();
      },
      child: Card(
        color: item.status == "Aktif" ? Color(0xFFF5F6F9) : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [checkBox],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            item.detail!.toString(),
                            style: styles.heading6bold,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      "RM " +
                          item.nettCalculations!.total!
                              .toStringAsFixed(2)
                              .toString(),
                      style: styles.heading12bold,
                    ),
                    item.billTypeId == 2
                        ? EditAmountButton2(
                            onChanged: (value) {
                              String userValue = "";
                              print(userValue.toString());
                              userValue = value.toString();

                              double a = double.parse(value);
                              if (a > 0.00) {
                                Future.delayed(const Duration(seconds: 1))
                                    .then((value) {
                                  print("main");
                                  print(value.toString());
                                  navigate(
                                    context,
                                    BillDetailsScreen(
                                      item,
                                      userValue,
                                    ),
                                  );
                                });
                              }
                            },
                          )
                        : Container()
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                        ),
                        SizedBox(
                          child: Text(
                            item.referenceNumber!.toString() +
                                " | " +
                                item.billNumber!.toString(),
                          ),
                        ),
                        item.startAt != null
                            ? Text(
                                formatDate(
                                  DateTime.parse(item.startAt.toString()),
                                  [dd, '/', mm, '/', yyyy],
                                ),
                              )
                            : Text("No date".tr),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class HeaderTopList extends StatelessWidget {
  HeaderTopList({
    Key? key,
    required this.list,
    required this.refreshIcon,
  });

  final List<Bills> list;
  Widget refreshIcon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'List of Bills'.tr,
                  style: styles.heading8,
                ),
                refreshIcon
              ],
            ),
            SizedBox(height: 5),
            list.isEmpty
                ? Container()
                : Text(
                    'List of Bills to be Paid'.tr,
                    style: styles.heading8sub,
                  ),
          ],
        ),
      ),
    );
  }
}

class NoBillWidget extends StatelessWidget {
  const NoBillWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            SvgPicture.asset('assets/dist/aduan.svg',
                height: MediaQuery.of(context).size.width / 3),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'You have no outstanding bill.'.tr,
                style: styles.heading5,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
