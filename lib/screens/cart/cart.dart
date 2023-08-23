import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/components/bottom_bar.dart';
import 'package:flutterbase/components/field/email_input.dart';
import 'package:flutterbase/components/field/integer_input.dart';
import 'package:flutterbase/components/field/phone_input.dart';
import 'package:flutterbase/components/field/rounded_amount_input.dart';
import 'package:flutterbase/components/field/text_input.dart';
import 'package:flutterbase/components/loading_blocker.dart';
import 'package:flutterbase/controller/bottom_bar_controller.dart';
import 'package:flutterbase/controller/cart_controller.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/language/pull_to_refresh.dart';
import 'package:flutterbase/models/cart/cart.dart';
import 'package:flutterbase/screens/services/bayaran_tanpa_bill.dart';
import 'package:flutterbase/screens/services/bill_detail.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final BottomBarController bottomBarController;
  final controller = CartController();
  final _refreshController = RefreshController();

  initState() {
    bottomBarController  = BottomBarCartController(false, hideCartButton: true);
    bottomBarController.alwaysShown.value = true;
    controller.setBottomBarController(bottomBarController);
    controller.loadCart();
    super.initState();

    loadingBlocker.bind(controller.isLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const MyShapeBorder(-20),
      ),
      body: SafeArea(
        child: Obx(() => controller.isLoading.value ? SizedBox() : controller.chargedTos.isEmpty ? Container(
          width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/dist/aduan.svg', height: MediaQuery.of(context).size.width / 3),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: Text((
                      "Trolly is empty.".tr
                  ), style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
                ),
              ],
            )) : SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  onRefresh: () async {
                    await controller.loadCart();
                    _refreshController.refreshCompleted();
                  },
                  header: MyWaterDropHeader(),
                  footer: MyClassicFooter(),
                  controller: _refreshController,
                  child: ListView(
                    padding: EdgeInsets.only(top: 16),
                    children: [
                      for(var item in controller.chargedTos)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: 16, right: 8),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(width: 1, color: constants.fiveColor),
                                  )
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 24,
                                          child: Checkbox(
                                            activeColor: constants.fiveColor,
                                            value: item.isSelected.value,
                                            onChanged: (v) => item.setChecked(v!),
                                            visualDensity: VisualDensity.compact,
                                          ),
                                        ),
                                        Text(
                                          'Transaction Charged To'.tr +
                                          ': ' +
                                          item.chargedTo,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87
                                          ),
                                        ),
                                      ],
                                    ),
                                    if(item.isSelected.value)
                                      Positioned(
                                        top: -3,
                                        right: 0,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: InkWell(
                                            onTap: (){
                                              item.removeAll();
                                            },
                                            child: Icon(LineIcons.trash, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              for(var agency in item.agencies)
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(width: .5, color: Colors.black26),
                                    )
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 24,
                                              child: Checkbox(
                                                activeColor: constants.fiveColor,
                                                value: agency.isSelected.value,
                                                onChanged: (v) => agency.setChecked(v),
                                                visualDensity: VisualDensity.compact,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(agency.ministry, overflow: TextOverflow.ellipsis,),
                                                  Text(agency.department, overflow: TextOverflow.ellipsis,),
                                                  Text(agency.agency, overflow: TextOverflow.ellipsis,),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        for(var cartEntry in agency.entries)
                                          if(cartEntry.billTypeId == 3)
                                            BTBCartEntry(agency, cartEntry, controller)
                                          else
                                            NormalCartEntry(agency, cartEntry)
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        )
                    ],
            )),
        ),
      ),
      bottomNavigationBar: BottomBar(bottomBarController),
    );
  }
}

class NormalCartEntry extends StatelessWidget {
  const NormalCartEntry(this.agency, this.cartEntry, {
    super.key,
  });

  final CartAgency agency;
  final CartEntry cartEntry;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(cartEntry.id.toString()),
      endActionPane: ActionPane(
        extentRatio: .3,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              Get.to(() => BillDetailsScreen(), arguments: { 'id': cartEntry.billId });
            },
            backgroundColor: constants.fiveColor,
            foregroundColor: Colors.black,
            icon: LineIcons.eye,
          ),
          SlidableAction(
            onPressed: (_) {
              agency.remove(cartEntry, notify: true);
            },
            backgroundColor: constants.errorColor,
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
          ),
        ],
      ),
      child: Container(
        color: !cartEntry.canPay ? Colors.black12 : null,
        padding: const EdgeInsets.only(right: 8.0, bottom: 8),
        child: Obx(() => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              activeColor: constants.fiveColor,
              visualDensity: VisualDensity.compact,
              value: cartEntry.isSelected.value,
              onChanged: cartEntry.total == 0 ? null : (v) => cartEntry.setChecked(v),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(cartEntry.items[0].description!, maxLines: 2, overflow: TextOverflow.ellipsis,),
                      ),
                      if(cartEntry.billTypeId == 2 || cartEntry.billTypeId == 4)
                        InkWell(
                          onTap: (){
                            showBottomSheet(context: context, builder: (_) {
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                height: 96,
                                child: RoundedAmountInput('Please input amount:'.tr,
                                  (v){
                                    cartEntry.setValue(v);
                                  },
                                  onDone: () {
                                    Navigator.of(context).pop();
                                  },
                                  hasAsterisk: true,
                                  initialValue: cartEntry.total,
                                ),
                              );
                            });
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 3),
                                child: Icon(Icons.edit, size: 12, color: Colors.black54),
                              ),
                              Text(
                                "RM " + moneyFormat(double.parse(cartEntry.total.toString())),
                              ),
                            ],
                          )
                        )
                      else
                        Text("RM " + moneyFormat(double.parse(cartEntry.total.toString())),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(cartEntry.items.first.extraInfo.toString(), style: TextStyle(fontSize: 12, color: Colors.black54),),
                  ),

                  if(cartEntry.billTypeId == 5)
                    ThirdPartyDetails(cartEntry),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class BTBCartEntry extends StatefulWidget {
  const BTBCartEntry(this.agency, this.cartEntry, this.controller, {
    super.key,
  });

  final CartController controller;
  final CartAgency agency;
  final CartEntry cartEntry;

  @override
  State<BTBCartEntry> createState() => _BTBCartEntryState();
}

class _BTBCartEntryState extends State<BTBCartEntry> {

  List<String> categories = [];

  @override
  initState() {
    for(var item in widget.cartEntry.items) {
      if(!categories.contains(item.category)) {
        categories.add(item.category);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Slidable(
      key: Key(widget.cartEntry.id.toString()),
      endActionPane: ActionPane(
        extentRatio: .3,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) async {
              await Get.to(() => BayaranTanpaBilServiceScreen(), arguments: {
                'id': widget.cartEntry.serviceId,
                'cartEntry': widget.cartEntry
              });
              widget.controller.isLoading.value = true;
              widget.controller.loadCart();
            },
            backgroundColor: constants.fiveColor,
            foregroundColor: Colors.black,
            icon: Icons.edit,
          ),
          SlidableAction(
            onPressed: (_) {
              widget.agency.remove(widget.cartEntry, notify: true);
            },
            backgroundColor: constants.errorColor,
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      activeColor: constants.fiveColor,
                      visualDensity: VisualDensity.compact,
                      value: widget.cartEntry.isSelected.value,
                      onChanged: widget.cartEntry.total == 0 ? null : (v) => widget.cartEntry.setChecked(v),
                    ),
                    Text(widget.cartEntry.serviceName),
                  ],
                ),
                Text("RM " + moneyFormat(double.parse(widget.cartEntry.total.toString())),),
              ],
            ),
            if(widget.cartEntry.extraFields.isNotEmpty)
              BTBExtraFields(widget.cartEntry),
            for(var category in categories)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 42.0, right: 4, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(category.isNotEmpty ? category : 'Products'.tr.toUpperCase(), style: TextStyle(color: Colors.black54, fontSize: 12),),
                        Divider(
                          color: constants.fiveColor,
                          endIndent: MediaQuery.of(context).size.width - 100,
                          thickness: 1,
                          height: 3,
                        )
                      ],
                    ),
                  ),
                  for(var item in widget.cartEntry.items.where((element) => element.category == category,))
                    BTBItemRow(item: item),
                ],
              ),
          ],
        ),
      ),
    ));
  }
}

/// Other widgets

class BTBExtraFields extends StatelessWidget {
  final CartEntry entry;

  BTBExtraFields(this.entry);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for(var item in entry.extraFields)
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
              left: 42,
            ),
            child: Obx(() => InkWell(
              onTap: () async {
                if(item.type == 'date') {
                  var initialDate = DateTime.tryParse(item.value.value.split('/').reversed.join('-')) ?? DateTime.now();
                  var picked = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    locale: Locale('ms', 'MY'),
                  );

                  if(picked != null) {
                    item.setValue(dateFormatterDisplay.format(picked));
                  }
                } else {
                  showBottomSheet(context: context, builder: (_) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      height: item.type == 'textarea' ? 156 : 96,
                      child: TextInput(item.placeholder + ':',
                        (v){
                          item.setValue(v);
                        },
                        onDone: () {
                          Navigator.of(context).pop();
                        },
                        isMultiline: item.type == 'textarea',
                        initialValue: item.value.value,
                      ),
                    );
                  });
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 3.0),
                        child: Icon(Icons.edit, size: 12, color: Colors.black54,),
                      ),
                      Text(item.source, style: TextStyle(color: Colors.black87),),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(item.value.value, style: TextStyle(color: Colors.black87),),
                  ),
                ],
              ),
            )),
          ),
      ],
    );
  }
}

class BTBItemRow extends StatelessWidget {
  const BTBItemRow({
    super.key,
    required this.item,
  });

  final CartEntryItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Padding(
                padding: const EdgeInsets.only(left: 34.0, right: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (item.description ?? '-')
                      ,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                    Text('RM' + moneyFormat(item.perUnit.value) + ' / ' + item.unit, style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),),
                    SizedBox(height: 12),
                  ],
                ),
              )),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BTBItemQtyInput(item: item),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 4),
                    child: Text(
                      "RM " + moneyFormat(item.amount),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ]
          ),
        ],
      ),
    );
  }
}

class BTBItemQtyInput extends StatelessWidget {
  const BTBItemQtyInput({
    super.key,
    required this.item,
  });

  final CartEntryItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => item.decrement(),
          child: SizedBox(
            width: 30,
            height: 30,
            child: Container(
              alignment: Alignment.center,
              child: Icon(Icons.remove, size: 16),
              decoration: BoxDecoration(
                color: constants.fiveColor,
                border: Border.all(
                  width: .5, color: Colors.black45,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3),
                  bottomLeft: Radius.circular(3),
                )
              ),
            ),
          ),
        ),
        InkWell(
          onTap: (){
            showBottomSheet(context: context, builder: (_) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                height: 96,
                child: IntegerInput('Sila masukkan kuantiti:',
                  (v){
                    item.setQuantity(v);
                  },
                  onDone: () {
                    Navigator.of(context).pop();
                  },
                  maxValue: 10000,
                  initialValue: item.quantity.value,
                ),
              );
            });
          },
          child: SizedBox(
            width: 50,
            height: 30,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: .5, color: Colors.black45),
                  bottom: BorderSide(width: .5, color: Colors.black45),
                ),
              ),
              child: Text(item.quantity.toString(), style: TextStyle(fontSize: 14),),
            ),
          ),
        ),
        InkWell(
          onTap: () => item.increment(),
          child: SizedBox(
            width: 30,
            height: 30,
            child: Container(
              alignment: Alignment.center,
              child: Icon(Icons.add, size: 16, color: Colors.white),
              decoration: BoxDecoration(
                color: constants.primaryColor,
                border: Border.all(
                  width: .5, color: Colors.black45,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(3),
                  bottomRight: Radius.circular(3),
                )
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ThirdPartyDetails extends StatelessWidget {
  final CartEntry entry;

  ThirdPartyDetails(this.entry);

  @override
  Widget build(BuildContext context) {
    return (entry.customerName.isEmpty && entry.customerPhone.isEmpty && entry.customerEmail.isEmpty) ? SizedBox() : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 4,
              bottom: 8.0,
              left: 4,
            ),
            child: Obx(() => InkWell(
              onTap: () async {
                showBottomSheet(context: context, builder: (_) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    height: 96,
                    child: TextInput('Payment on Behalf'.tr + ':',
                      (v){
                        entry.setCustomerDetails('name', v);
                      },
                      onDone: () {
                        Navigator.of(context).pop();
                      },
                      initialValue: entry.customerName.value,
                    ),
                  );
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 3.0),
                        child: Icon(Icons.edit, size: 12, color: Colors.black54,),
                      ),
                      Text('Payment on Behalf'.tr, style: TextStyle(color: Colors.black87),),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(entry.customerName.value, style: TextStyle(color: Colors.black87),),
                  ),
                ],
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
              left: 4,
            ),
            child: Obx(() => InkWell(
              onTap: () async {
                showBottomSheet(context: context, builder: (_) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    height: 96,
                    child: PhoneInput('Phone Number'.tr + ':',
                      (v){
                        entry.setCustomerDetails('phone', v);
                      },
                      onDone: () {
                        Navigator.of(context).pop();
                      },
                      initialValue: entry.customerPhone.value,
                    ),
                  );
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 3.0),
                        child: Icon(Icons.edit, size: 12, color: Colors.black54,),
                      ),
                      Text('Phone Number'.tr, style: TextStyle(color: Colors.black87),),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(entry.customerPhone.value, style: TextStyle(color: Colors.black87),),
                  ),
                ],
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
              left: 4,
            ),
            child: Obx(() => InkWell(
              onTap: () async {
                showBottomSheet(context: context, builder: (_) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    height: 96,
                    child: EmailInput('Email Address'.tr + ':',
                      (v){
                        entry.setCustomerDetails('email', v);
                      },
                      onDone: () {
                        Navigator.of(context).pop();
                      },
                      initialValue: entry.customerEmail.value,
                    ),
                  );
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 3.0),
                        child: Icon(Icons.edit, size: 12, color: Colors.black54,),
                      ),
                      Text('Email Address'.tr, style: TextStyle(color: Colors.black87),),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(entry.customerEmail.value, style: TextStyle(color: Colors.black87),),
                  ),
                ],
              ),
            )),
          ),
      ],
    );
  }
}
