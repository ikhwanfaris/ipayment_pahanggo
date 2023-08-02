import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/add_to_cart_button.dart';
import 'package:flutterbase/components/datepicker_form.dart';
import 'package:flutterbase/components/textfield_form.dart';
import 'package:flutterbase/controller/bill/bayaran_tanpa_bill_controller.dart';
import 'package:flutterbase/models/contents/matrix.dart';
import 'package:flutterbase/screens/content/home/service_detail.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../api/api.dart';
import '../../../../components/primary_button_two.dart';
import '../../../../helpers.dart';
import '../../../../models/bills/bills.dart';
import '../../../auth/login.dart';
import '../../cart/widgets/edit_amount_ticket.dart';
import 'bayaran_tanpa_bill_detail.dart';

// ignore: must_be_immutable
class BayaranTanpaBill extends StatelessWidget {
  final controller = Get.put(BayaranTanpaBillController());
  SingleCheckboxController checkboxController = SingleCheckboxController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Center(
          child: Center(
            child: Text(
              "Ticket".tr,
              style: styles.heading4,
            ),
          ),
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: 25),
          children: [
            // DrawerHeader(
            //   curve: Curves.bounceInOut,
            //   decoration: BoxDecoration(
            //     color: constants.secondaryColor,
            //   ),
            //   child:
            //   Text('Drawer Header'),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: constants.filterTicketColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('Pilihan',
                                        style: styles.heading10bold),
                                    Obx(() => Text(
                                          ' (@count)'.trParams({
                                            'count': checkboxController
                                                .checkedIds.length
                                                .toString(),
                                          }),
                                        )),
                                  ],
                                ),
                                GestureDetector(
                                    onTap: () {
                                      checkboxController.uncheckAll();
                                    },
                                    child: Text(
                                      'Reset Pilihan',
                                      style: styles.heading3,
                                    )),
                              ],
                            ),
                            Obx(
                              () => GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 5.5,
                                ),
                                itemCount: controller.items.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        color: constants.widgetFourColor,
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              controller.removeItem(index);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 2, 8, 2),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(controller.items[index],
                                                      style:
                                                          styles.heading3sub),
                                                  SizedBox(width: 5),
                                                  Icon(
                                                    getIcon('x'),
                                                    color:
                                                        constants.primaryColor,
                                                    size: 15,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                children: [
                                  ExpandableNotifier(
                                    child: ExpandablePanel(
                                      controller: ExpandableController(),
                                      collapsed: SizedBox(),
                                      header: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Text('Kategori',
                                            style: styles.heading10bold),
                                      ),
                                      expanded: Padding(
                                        padding: EdgeInsets.only(bottom: 12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (controller.filters.length > 1)
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: controller
                                                    .filters[0].length,
                                                itemBuilder: (context, index) {
                                                  var item = controller
                                                      .filters[0][index];
                                                  return Row(
                                                    children: [
                                                      SingleCheckbox(
                                                        controllerSingleCheckBox:
                                                            checkboxController,
                                                        item: Item(id: item.id),
                                                      ),
                                                      Text(
                                                        item.name,
                                                        style: styles
                                                            .heading10boldPrimary,
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  ExpandablePanel(
                                    controller: ExpandableController(),
                                    collapsed: SizedBox(),
                                    header: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text('Subkategori',
                                          style: styles.heading10bold),
                                    ),
                                    expanded: Padding(
                                      padding: EdgeInsets.only(bottom: 12),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller.filters.length,
                                        itemBuilder: (context, index) {
                                          if (index == 0) {
                                            // Skip the first list (index 0)
                                            return SizedBox.shrink();
                                          } else {
                                            var item =
                                                controller.filters[index];
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                for (var element in item)
                                                  Row(
                                                    children: [
                                                      SingleCheckbox(
                                                        controllerSingleCheckBox:
                                                            checkboxController,
                                                        item: Item(
                                                            id: element.id),
                                                      ),
                                                      Text(
                                                        element.name,
                                                        style:
                                                            styles.heading10,
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              TicketTitle(controller: controller),
              MenuSearchBar(),
              ExtraFieldsForm(controller: controller),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Row(
                  children: [
                    Icon(getIcon('info')),
                    SizedBox(width: 10),
                    Text('Add to cart to see all.'.tr),
                  ],
                ),
              ),
              Obx(
                () {
                  List<Widget> products = [];
                  List<Widget> ticketTiles = [];
                  if (controller.billType == 3) {
                    products.addAll([
                      SizedBox(height: 5),
                      controller.hasdailyQuota.value == true
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 3),
                                child: Text(
                                  "Remaining quota".tr +
                                      ": ${(controller.isFirst.value) ? "-" : controller.dailyQuota.value.remaining}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: constants.primaryColor),
                                ),
                              ),
                            )
                          : Container(),
                    ]);
                    products.add(
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.65,
                              ),
                              itemCount: controller.products.length,
                              itemBuilder: (context, index) {
                                if (index >= controller.products.length) {
                                  return SizedBox
                                      .shrink(); // Return an empty SizedBox if index is out of range
                                }

                                var element = controller.products[index];
                                // var filterItem = controller.filters;
                                
                                return TicketTile(
                                  hasStockTracing: element.checkStock,
                                  disableSingle: RxBool(false),
                                  disableAdd: controller.disableAdd,
                                  currentQuota: controller.currentQuota,
                                  quota: element.dailyQuota ?? 0,
                                  price: double.parse(element.price),
                                  value: element.amount,
                                  total: controller.total,
                                  unit: element.unit.toString(),
                                  option: "",
                                  count: controller.count,
                                  stock: element.stock,
                                  item: element,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    for (var element in controller.bills) {
                      // Category product
                      // for (var element in element.subitems) {
                      //   List<Widget> ticketTiles = [];
                      //   for (var quantity in element.quantities) {
                      ticketTiles.add(
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 2),
                          child: Text(
                            element.detail!,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                      ticketTiles.add(Column(
                        children: [
                          // Text("RM " + quantity.bill_mask.toString()),
                          // Text(quantity.favorite.toString()),
                          // Obx(
                          //   () => IconButton(
                          //     icon: Icon(quantity.favorite == true
                          //         ? Icons.favorite
                          //         : Icons.favorite_border),
                          //     color: Constants().primaryColor,
                          //     onPressed: () async {
                          //       await api.favABill(
                          //           controller.serviceId.toString());
                          //       quantity.favorite == true
                          //           ? snack(
                          //               context,
                          //               "Removed to favourite list successfully."
                          //                   .tr,
                          //               level: SnackLevel.Error)
                          //           : snack(
                          //               context,
                          //               "Added to favourite list successfully."
                          //                   .tr,
                          //               level: SnackLevel.Success);
                          //       // initApp();
                          //     },
                          //   ),
                          // ),
                          TicketTile2(
                              isFavorite: element.favorite!.obs,
                              price: element.amount1!,
                              id: element.id!,
                              onPressed: () {},
                              onPressed2: () {
                                element.billMask.toString();
                              },
                              total: controller.total,
                              select: element.select,
                              count: controller.count,
                              item: element)
                        ],
                      )
                          // TicketTile(
                          //   // price: quantity.rate.value ?? 0.0,
                          //   disableSingle: RxBool(false),
                          //   hasStockTracing: quantity.hasStockTracking!,
                          //   // isFirst: controller.isFirst,
                          //   disableAdd: controller.disableAdd,
                          //   quota: controller.dailyQuota,
                          //   price:
                          //       num.tryParse(quantity.rate.value ?? "0") ?? 0,
                          //   kadar: "",
                          //   value: quantity.amount,
                          //   total: controller.total,
                          //   unit: quantity.unit.value ?? "",
                          //   count: controller.count,
                          // ),
                          );
                    }
                    products.add(
                      Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                // fillColor: Colors.black,
                                value: controller.isChecked.value,
                                onChanged: (bool? value) {
                                  controller.isChecked.value = value!;
                                  controller.count.value = 0;
                                },
                              ),
                              Text(
                                "Bayaran Bagi Pihak",
                              ),
                            ],
                          ),
                          controller.isChecked.value == true
                              ? Container(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      label: Text('Name'),
                                    ),
                                    onSaved: (String? value) {
                                      // This optional block of code can be used to run
                                      // code when the user saves the form.
                                    },
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                    products.add(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...ticketTiles,
                        ],
                      ),
                    );
                    // }
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: products,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomBar(controller.barController),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: controller.billType == 3
              ? Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: AddToCartButton(
                        onPressed: () => controller.addToCart3(),
                        icon: LineIcons.addToShoppingCart,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 8,
                      child: Obx(
                        () => PrimaryButton2(
                          onPressed: () =>
                              // (controller.isFirst.value)
                              // ? showQuantityError()
                              // :
                              controller.bayar3(),
                          text: "Pay".tr +
                              '(${controller.count})' +
                              ' RM ${controller.total.toStringAsFixed(2)}',
                        ),
                      ),
                    ),
                  ],
                )
              : controller.billType == 5
                  ? Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: AddToCartButton(
                            onPressed: () => controller.addToCart5(),
                            icon: LineIcons.addToShoppingCart,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 8,
                          child: Obx(
                            () => PrimaryButton2(
                              onPressed: () =>
                                  // (controller.isFirst.value)
                                  // ? showQuantityError()
                                  // :
                                  controller.bayar5(),
                              text: "Pay".tr +
                                  '(${controller.count})' +
                                  ' RM ${controller.total.toStringAsFixed(2)}',
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: AddToCartButton(
                            onPressed: () => controller.addToCart(),
                            icon: LineIcons.addToShoppingCart,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 8,
                          child: Obx(
                            () => PrimaryButton2(
                              onPressed: () =>
                                  // (controller.isFirst.value)
                                  // ? showQuantityError()
                                  // :
                                  controller.bayar(),
                              text: "Pay".tr +
                                  '(${controller.count})' +
                                  ' RM ${controller.total.toStringAsFixed(2)}',
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}

class ExtraFieldsForm extends StatelessWidget {
  const ExtraFieldsForm({
    super.key,
    required this.controller,
  });

  final BayaranTanpaBillController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: constants.filterTicketColor),
        child: Obx(
          () => Column(
            children: controller.extraFields.map(
              (element) {
                print(element.type.toString());
                switch (element.type) {
                  case "date":
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: FormDatePicker(
                        title: "${element.source}".tr + "*",
                        selectedDate: element.value as Rx<DateTime>,
                        placeholder: element.placeholder ?? "",
                        isFirst: controller.isFirst,
                      ),
                    );
                  case "textarea":
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: FormTextField(
                        title: "${element.source}".tr + "*",
                        placeholder: element.placeholder ?? "",
                        text: (element.value as Rx<TextEditingController>),
                      ),
                    );
                  case "text":
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: FormTextField(
                        title: "${element.source}".tr + "*",
                        placeholder: element.placeholder ?? "",
                        text: (element.value as Rx<TextEditingController>),
                      ),
                    );
                  default:
                    return Container();
                }
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}

class TicketTitle extends StatelessWidget {
  const TicketTitle({
    super.key,
    required this.controller,
  });

  final BayaranTanpaBillController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Obx(() => Text(
                        controller.name.value,
                        style: TextStyle(fontSize: 24),
                      )),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => Get.to(
                    () => ServiceDetail(),
                    arguments: controller.serviceRefNum,
                  ),
                  child: Icon(Icons.info_outline),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'List of Services'.tr,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Item {
  final int id;

  Item({required this.id});
}

class SingleCheckboxController extends GetxController {
  final controller = Get.put(BayaranTanpaBillController());

  RxMap<int, RxBool> checkboxStates = <int, RxBool>{}.obs;
  RxList<int> checkedIds = <int>[].obs;

  RxBool isChecked(int itemId) {
    return checkboxStates[itemId] ??= false.obs;
  }

  List<int> getCheckedItemIds() {
    List<int> ids = [];
    for (var entry in checkboxStates.entries) {
      if (entry.value.value == true) {
        ids.add(entry.key);
      }
    }
    return ids;
  }

  void updateCheckbox(bool? value, Item item) {
    checkboxStates[item.id] = value?.obs ?? false.obs;
    checkedIds.assignAll(getCheckedItemIds());
    controller
        .filterCheckboxProducts(checkedIds.isNotEmpty ? checkedIds : null);
  }

  void uncheckAll() {
    for (var key in checkboxStates.keys) {
      checkboxStates[key] = false.obs;
    }
    checkedIds.clear();
    controller.filterCheckboxProducts(null);
  }
}

// ignore: must_be_immutable
class SingleCheckbox extends StatelessWidget {
  final SingleCheckboxController controllerSingleCheckBox;
  final Item item;

  SingleCheckbox({required this.controllerSingleCheckBox, required this.item});

  @override
  Widget build(BuildContext context) {
    return ValueBuilder<bool?>(
      initialValue: controllerSingleCheckBox.isChecked(item.id).value,
      builder: (value, updateFn) => SizedBox(
        height: 30,
        child: Checkbox(
          value: value ?? false,
          onChanged: (newValue) {
            updateFn(newValue);
            controllerSingleCheckBox.updateCheckbox(newValue ?? false, item);
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TicketTile extends StatelessWidget {
  final controller = Get.put(BayaranTanpaBillController());
  TicketTile(
      {Key? key,
      required this.price,
      required this.value,
      required this.total,
      required this.unit,
      // required this.isFirst,
      required this.disableAdd,
      this.hasStockTracing,
      this.option,
      this.kadar,
      this.currentQuota,
      required this.quota,
      // this.quantity,
      this.disableSingle,
      required this.count,
      required this.stock,
      this.item,
      this.hasChain})
      : super(key: key);

  final String? hasChain;
  final String? option;
  final String unit;
  final String? kadar;
  final num price;
  final bool? hasStockTracing;
  // final Quantity? quantity;
  late final RxInt value;
  final RxNum total;
  final RxInt? currentQuota;
  // final RxBool isFirst;
  final RxBool disableAdd;
  final RxBool? disableSingle;
  final int quota;
  final RxNum count;
  int? stock;
  final Products? item;

  @override
  Widget build(BuildContext context) {
    final RxInt stockRx = RxInt(0);
    stockRx.value = stock ?? 0;

    // ! all of this filteriTem variabke is not responisve

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xFFF1F2F4), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: EditAmountButtonTicket(onChanged: (val) {
              int intValue = int.parse(val);
              stockRx.value = stock ?? 0;
              if (intValue <= stockRx.value) {
                stockRx.value = stockRx.value - intValue;
                value.value = intValue;
              } else {
                Get.snackbar(
                  "".tr,
                  'Please enter an quantity that does not exceed the stock.'.tr,
                  messageText: Text(
                    'Please enter an quantity that does not exceed the stock.'
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
            }),
          ),
          Expanded(
            child: Text(
              item!.name,
              style: styles.heading10bold,
            ),
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! Hardcode for now
              item!.chains.length > 1
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item!.chains[0].name!,
                            style: styles.errorStyleTicket),
                        Text(' > ' + item!.chains[1].name!),
                      ],
                    )
                  : Container(),
              item!.chains.length > 2
                  ? Text('  > ' + item!.chains[2].name!)
                  : Container(),
              item!.chains.length > 3
                  ? Text('   > ' + item!.chains[3].name!)
                  : Container(),
              item!.chains.length > 4
                  ? Text('    > ' + item!.chains[4].name!)
                  : Container(),
              item!.chains.length > 5
                  ? Text('     > ' + item!.chains[5].name!)
                  : Container(),
            ],
          ),
          SizedBox(height: 5),
          Text(
            'Quota balance: @quota'.trParams({
              'quota': quota.toString(),
            }),
          ),
          Obx(() => Text(
                'Stock balance: @stock'.trParams({
                  'stock': stockRx.toString(),
                }),
              )),
          Padding(padding: const EdgeInsets.only(bottom: 5)),
          (option != null)
              ? Container(
                  width: Get.width * 0.32,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${kadar ?? "RM"} " + price.toStringAsFixed(2),
                            style: styles.heading10boldPrimary,
                          ),
                          Text("/" + unit),
                        ],
                      ),
                      // hasStockTracing.toString() == "true"
                      //     ? Text(
                      //         "Remaining stock".tr +
                      //             ":" +
                      //             item!.stock.toString(),
                      //       )
                      //     : Container(),
                    ],
                  ),
                )
              : Container(),

          // ? Tambah tolak quantity
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  // if (isFirst.value) {
                  //   print("a");
                  //   return null;
                  // }

                  if (value.value == 1) {
                    count.value--;
                  }
                  if (value.value == 0) {
                    print("b");
                    return null;
                  }
                  if (hasStockTracing!) {
                    print("c");
                    disableSingle!(false);
                  }
                  // ignore: unnecessary_null_comparison
                  if (quota != null) {
                    print("d");
                    // showQuotaError();
                    disableAdd(false);
                    currentQuota!.value--;
                  }
                  value.value--;
                  total.value = total.value - price;
                  if (value.value == 10) {
                    count.value--;
                  }

                  stockRx.value++;

                  print("- value.value " + value.value.toString());
                  print("- count.value " + count.value.toString());
                },
                child: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      color: value.value == 0
                          ? (constants.fiveColor).withOpacity(0.4)
                          : constants.fiveColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(Icons.remove, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Obx(
                  () => Text(
                    "$value",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // if (isFirst.value) {
                  //   return null;
                  // }

                  // ignore: unnecessary_null_comparison
                  if (quota != null) {
                    if (disableSingle!.value) {
                      return;
                    }
                    if (!disableAdd.value) {
                      if (value.value == 0) {
                        count.value++;
                      }

                      stockRx.value--;

                      currentQuota!.value++;
                      value.value++;
                      total.value = total.value + price;
                      if (hasStockTracing!) {
                        if (value.value == item!.stock) {
                          print(item!.stock.toString());
                          showQuotaQuantityError();
                          disableSingle!(true);
                          return null;
                        }
                        // if (value.value == quantity!.remainingStock) {
                        //   print(quantity!.remainingStock!.toString());
                        //   showQuotaQuantityError();
                        //   disableSingle!(true);
                        //   return null;
                        // }
                      }
                      print("+ value.value " + value.value.toString());
                      print("+ count.value " + count.value.toString());
                    }
                    // if (quota!.value.remaining != null) {
                    //   if (currentQuota!.value == quota!.value.remaining!) {
                    //     print("SINI");
                    //     showQuotaError();
                    //     disableAdd(true);
                    //     return null;
                    //   }
                    // } else {}
                  }
                },
                child: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                        color: (disableAdd.value || disableSingle!.value)
                            ? (constants.fiveColor).withOpacity(0.4)
                            : constants.fiveColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          // ? closed-Tambah tolak quantity
        ],
      ),
    );
  }
}

class TicketTile2 extends StatelessWidget {
  const TicketTile2(
      {Key? key,
      required this.price,
      this.isFavorite,
      required this.id,
      required this.onPressed,
      required this.onPressed2,
      required this.total,
      required this.count,
      this.select,
      this.item})
      : super(key: key);

  final String price;
  final RxBool? isFavorite;
  final int id;
  final Function onPressed;
  final Function onPressed2;
  final RxBool? select;
  final RxNum total;
  final RxNum count;
  final Bills? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xFFF1F2F4), borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Text(select!.value.toString()),
              Obx(
                () => Container(
                  child: Checkbox(
                    checkColor: Colors.white,
                    // fillColor: Colors.black,
                    value: select!.value,
                    onChanged: (bool? value) {
                      select!.value = value!;
                      if (select!.value == true) {
                        count.value++;
                        total.value += double.parse(price);
                      } else if (select!.value == false) {
                        count.value--;
                        total.value -= double.parse(price);
                      }
                    },
                  ),
                ),
              ),
              Container(
                child: Text(
                  "RM " + price,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Obx(
                () => IconButton(
                  icon: Icon((isFavorite!.value)
                      ? Icons.favorite
                      : Icons.favorite_border),
                  color: Constants().primaryColor,
                  onPressed: () async {
                    print(id.toString());
                    ErrorResponse response = await api.favABill(id.toString());
                    if (isLoggedIn()) {
                      isFavorite!.value = !isFavorite!
                          .value; // if (!response.message.contains("removed")) {
                      if (!response.message.contains("removed")) {
                        Get.showSnackbar(GetSnackBar(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          message: "Added to favourite list successfully.".tr,
                          backgroundColor: Color(0xFF33A36D),
                          snackPosition: SnackPosition.TOP,
                          duration: Duration(seconds: 2),
                        ));
                      } else {
                        Get.showSnackbar(GetSnackBar(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          message:
                              "Successfully removed from favorites list.".tr,
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.TOP,
                          isDismissible: true,
                          duration: Duration(seconds: 2),
                        ));
                        // Get.snackbar(
                        //   "",
                        //   backgroundColor: Color(0xFF33A36D),
                        //   colorText: Colors.white,
                        // );
                      }
                      onPressed();
                    } else {
                      Get.to(() => LoginScreen());
                    }
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.visibility),
                color: Constants().primaryColor,
                onPressed: () async {
                  Get.to(
                    () => BayaranTanpaBillDetail(
                      item!.billMask.toString(),
                    ),
                  );
                  onPressed2();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class MenuSearchBar extends StatelessWidget {
  MenuSearchBar({
    Key? key,
  }) : super(key: key);

  TextEditingController _searchController = TextEditingController();
  final controller = Get.put(BayaranTanpaBillController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 11,
              child: SizedBox(
                height: 30,
                child: TextFormField(
                  controller: _searchController,
                  textInputAction: TextInputAction.done,
                  decoration: styles.inputDecoration.copyWith(
                    labelText: 'Search...'.tr,
                  ),
                  onChanged: (value) {
                    controller.applyFilter(value);
                  },
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
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
          ],
        ),
      ),
    );
  }
}
