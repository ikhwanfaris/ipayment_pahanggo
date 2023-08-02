import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterbase/api/barrel/barrel.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/components/checkout_button.dart';
import 'package:flutterbase/events/event.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/models/contents/bank.dart';
import 'package:flutterbase/models/models.dart';
import 'package:flutterbase/models/payments/payments.dart';
import 'package:flutterbase/screens/auth/login.dart';
import 'package:flutterbase/screens/content/cart/cart_utils.dart';
import 'package:flutterbase/screens/content/cart/widgets/widgets.dart';
import 'package:flutterbase/screens/content/home/duitnow_qr.dart';
import 'package:flutterbase/screens/content/home/payment.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';

final cartFormKey = GlobalKey<FormBuilderState>();
final checkoutFormKey = GlobalKey<FormBuilderState>();
late _CartScreenState cartState;

enum CartContext {
  cart,
  checkout;
}

class CartScreen extends StatefulWidget {
  CartScreen({
    Key? key,
    this.selectedIds,
    this.readOnly = false,
    this.useContext = CartContext.cart,
    this.title = 'Cart',
  }) : super(key: key);

  final List<int>? selectedIds;
  final bool readOnly;
  final CartContext useContext;
  final String title;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController searchCtrl = TextEditingController(text: '');
  late Future<ApiCartIndex> cartItemsFuture;
  late Future<dynamic> cartPayFuture;

  late double totalCartValue;
  late List<int> selectCartItems;
  late List<CartItem> cartItems;
  late List<CartItem> cartItems2;

  PaymentGateway? paymentGateway;
  Bank? bank;

  late bool selectAll;

  @override
  void initState() {
    super.initState();

    cartPayFuture = Future.value(null);

    setup();

    pullCartItems();

    cartState = this;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const curveHeight = -20.0;
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        shape: const MyShapeBorder(curveHeight),
      ),
      bottomNavigationBar: (widget.useContext == CartContext.checkout)
          ? SizedBox(height: AppStyles.u3)
          : Container(
              color: constants.secondaryColor,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Row(
                        children: [
                          Checkbox(
                            value: selectAll,
                            onChanged: toggleAllCheckboxes,
                          ),
                          //    Text(
                          //   'All'.tr,
                          //   style: styles.heading19,
                          //   textAlign: TextAlign.start,
                          //   softWrap: true,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              height: 40,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('Total'.tr),
                                  Text(
                                    "RM @amount".trParams({
                                      'amount': moneyFormat(totalCartValue),
                                    }),
                                    style: styles.heading13Primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: constants.primaryColor,
                      child: CheckoutButton(
                        onPressed: () {
                          // if (!isLoggedIn()) {
                          //   toast('Login to proceed payment.'.tr);
                          //   return;
                          // }

                          if (selectCartItems.length == 0) {
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CartScreen(
                                  selectedIds: selectCartItems,
                                  readOnly: true,
                                  useContext: CartContext.checkout,
                                  title: 'Checkout'.tr,
                                ),
                              ),
                            );
                          }
                        },
                        text: "Checkout (@count)".trParams(
                            {'count': selectCartItems.length.toString()}),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      body: RefreshIndicator(
        onRefresh: pullRefreshCart,
        child: FutureBuilder<ApiCartIndex>(
          future: cartItemsFuture,
          builder: (context, future) {
            // Condition: Loading
            if (future.connectionState != ConnectionState.done) {
              return Center(child: DefaultLoadingBar());
            }

            // Condition: Empty Data
            if (future.data == null) {
              return SizedBox(
                child: Center(
                  child: Text('Cart empty'.tr),
                ),
                height: MediaQuery.of(getContext()).size.height,
              );
            }

            cartItems = future.data!.cartItems;
            // cartItems.sort((a, b) => a.service!.chargedTo
            //     .toString()
            //     .compareTo(b.service!.chargedTo.toString()));

            String total =
                moneyFormat(double.parse("${future.data?.total ?? '0'}"));

            // State: Data Loaded
            return cartItems.isEmpty
                ? Container(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width / 3),
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/dist/aduan.svg',
                                height: MediaQuery.of(context).size.width / 3),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                'You have no bill added to cart.'.tr,
                                style: styles.heading5,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: FormBuilder(
                          key: widget.useContext == CartContext.checkout
                              ? checkoutFormKey
                              : cartFormKey,
                          autovalidateMode: AutovalidateMode.always,
                          onChanged: () {
                            cartFormKey.currentState!.saveAndValidate();
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ...cartItems.map((item) {
                                  // Cart Row
                                  Widget cartRow = CartRow(
                                    readOnly: widget.readOnly,
                                    item: item,
                                    onChanged: onChangedCartRow,
                                    onSelected: (isSelected) =>
                                        onCartRowSelected(item, isSelected),
                                  );

                                  var row = widget.readOnly
                                      ? CartRowWrapper(
                                          child: cartRow,
                                        )
                                      : Dismissible(
                                          key: Key('${item.id}'),
                                          confirmDismiss: (direction) =>
                                              onConfirmDismiss(direction, item),
                                          onDismissed: (direction) {
                                            cartItems.remove(item);
                                            onChanged(true);
                                          },
                                          background: Container(
                                            color: Colors.red.shade400,
                                            child: LineIcon.trash(
                                              color: Colors.white,
                                            ),
                                          ),
                                          child: CartRowWrapper(
                                            child: cartRow,
                                          ),
                                        );

                                  return row;
                                }).toList(),

                                /// Cart Total
                                if (widget.readOnly)
                                  PaymentSummary(
                                    onClickPay: onClickPay,
                                    onSelectedPaymentGateway:
                                        onSelectedPaymentGateway,
                                    paymentGateway: paymentGateway,
                                    total: total,
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  Future<bool?> onConfirmDismiss(direction, item) async {
    return confirmDeleteCart(item);
  }

  void onChangedCartRow(_item) {
    pushChanges(_item);

    onChanged(true);
  }

  void closeCartScreen() async {
    Navigator.pop(getContext(), true);
  }

  Future<void> pullRefreshCart() {
    pullCartItems(refresh: true);
    return Future.value();
  }

  void toggleAllCheckboxes(value) {
    cartFormKey.currentState!.fields.forEach((key, field) {
      if (key.contains('_checked')) {
        field.didChange(value);
      }
    });

    setState(() {
      selectAll = value ?? false;

      if (selectAll == false) {
        selectCartItems = [];
        print(selectCartItems.length.toString() + ': CURRENT CART ITEM');
        totalCartValue = 0;
      }
    });
  }

  void setup() {
    totalCartValue = 0;
    selectCartItems = [];
    cartItems = [];
    paymentGateway = null;
    bank = null;
    selectAll = false;
  }

  void pullCartItems({bool refresh = false}) {
    if (isLoggedIn()) {
      cartItemsFuture = ApiCart().getIndex(
        ids: widget.selectedIds,
        withTotal: widget.readOnly,
      );
    } else {
      cartItemsFuture = Future.value(
        ApiCartIndex(
          cartItems: getGuestCart().all(),
          total: getGuestCart().total().toString(),
        ),
      );
    }

    setup();

    if (refresh) {
      setState(() {});
    }
  }

  void onChanged(value) {
    cartFormKey.currentState!.saveAndValidate();

    // Recalculate during cart row change
    setState(() {
      totalCartValue = calculateGrandTotal();
    });
  }

  onClickPay(Bank? selectedBank) {
    if (!isLoggedIn()) {
      Navigator.of(getContext()).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (route) => route.isFirst,
      );
      return;
    }

    setState(() {
      bank = selectedBank;
    });

    if ((paymentGateway?.needPaynetBank() ?? false) && bank == null) {
      // user will click pay and choose bank bottomsheet will appear again.
      return;
    }

    confirmToProceed();
  }

  onSelectedPaymentGateway(selectedPaymentGateway) => setState(() {
        paymentGateway = selectedPaymentGateway;
        bank = null;
      });

  void confirmToProceed() async {
    appConfimationDialog(
      'Proceed payment?'.tr,
      'Proceed to payment gateway'.tr,
      submitPayCart,
    );
  }

  void submitPayCart() async {
    Map<String, dynamic> form = {};

    List<int> ids = widget.selectedIds ?? [];

    for (var count = 0; count < ids.length; count++) {
      form["ids[$count]"] = ids[count];
    }

    if (paymentGateway != null) {
      form['payment_method'] = paymentGateway?.id ?? 0;
    }

    if (bank != null) {
      form['bank_code'] = bank?.code ?? '';

      var urls = bank?.redirectUrls ?? [];

      if (urls.isNotEmpty) {
        form['redirect_url'] = urls.first.url;
        form['bank_type'] = urls.first.type;
      }
    }

    setState(() {
      if (paymentGateway!.isQrPayment()) {
        cartPayFuture = ApiCart().payQr(form).then((qrPayResult) async {
          if (qrPayResult == null) {
            return qrPayResult;
          }

          if (qrPayResult.isError()) {
            return qrPayResult;
          }

          Uint8List bytes =
              Base64Decoder().convert(qrPayResult.qrImage.toString());

          Get.to(() => DuitnowQR(), arguments: {
            "payments": Payments(
              referenceNumber: qrPayResult.referenceNumber,
            ),
            "image": bytes,
          });

          return qrPayResult;
        }).onError((error, stackTrace) {
          //
          xlog([error, stackTrace].toString());
          toast(
            "Something went wrong, please try again later.".tr,
            level: SnackLevel.Error,
          );

          return null;
        });

        return;
      }

      cartPayFuture = ApiCart().pay(form).then((payResult) async {
        if (payResult?.redirect != null) {
          Payments payments = Payments.fromJson({});

          payments.amount = await cartItemsFuture.then((value) => value.total);
          payments.redirect = payResult?.redirect;
          payments.referenceNumber = payResult?.referenceNumber;

          Get.to(() => Payment(), arguments: payments);
        }

        return payResult;
      });
    });
  }

  void onCartRowSelected(CartItem item, bool isSelected) {
    var cartId = (item.id ?? 0);

    setState(() {
      if (isSelected == true) {
        if (cartId != 0) {
          selectCartItems.add(cartId);
        }
      } else {
        if (cartId != 0) {
          selectCartItems.remove(cartId);
        }
      }
    });

    // Recalculate during cart row selection changed
    setState(() {
      totalCartValue = calculateGrandTotal();
    });
  }

  double calculateGrandTotal() {
    double grandTotal = 0.0;

    cartItems.forEach((element) {
      if (selectCartItems.contains(element.id)) {
        grandTotal += CartItemUtils(element).getSubTotal();
      }
    });

    return grandTotal;
  }

  /// Save cart row changes
  Future<void> pushChanges(CartItem item) async {
    for (var entry in cartItems) {
      var cartItemId = entry.id;

      if (cartItemId == item.id) {
        if (isLoggedIn()) {
          await ApiCart().update(
            cartItemId ?? 0,
            body: entry.toJson(),
          );
        } else {
          await getGuestCart().update(entry);
        }

        break;
      }
    }

    return Future.value();
  }

  Future<bool?> confirmDeleteCart(CartItem item) async {
    var isDeleted = true;
    // var isConfirm = await appDialogDelete(
    //   "Are you sure?".tr,
    //   "Would you like to continue delete this cart item?".tr,
    // );

    // xlog(isConfirm.toString());

    // if (isConfirm != true) {
    //   return false;
    // }

    if (isLoggedIn()) {
      /// Call api delete cart item
      await ApiCart()
          .delete(item.id ?? 0)
          .then((deleted) => isDeleted = deleted)
          .onError((e, s) {
        xlog([e, s].toString());
        isDeleted = false;
        return false;
      });
    } else {
      // Trigger GuestCart delete
      await getGuestCart().delete(item).then((value) => isDeleted = true);
    }

    if (isDeleted) {
      setState(() {
        selectCartItems.remove(item);
      });
      snack(context, "Succesfully removed.".tr, level: SnackLevel.Success);
      eventBus.fire(CartUpdatedEvent());
    }

    return isDeleted;
  }
}
