import 'package:flutter/material.dart';
import 'package:flutterbase/components/add_to_cart_button.dart';
import 'package:flutterbase/components/checkout_button.dart';
import 'package:flutterbase/controller/bottom_bar_controller.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class BottomBar extends StatelessWidget
{
  final BottomBarController controller;

  BottomBar(this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx(() => (controller.items.length > 0)
            ? Container(
      color: constants.secondaryColor,
      child: SafeArea(
        child: Container(
            color: constants.secondaryColor,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: !controller.hasCheckbox.value ? SizedBox() : SizedBox(
                    height: 20,
                    child: Checkbox(
                      side: const BorderSide(
                        color: Colors.amber,
                        width: 1.5,
                      ),
                      checkColor: Colors.white,
                      activeColor: Colors.amber,
                      value: false,
                      onChanged: (bool? value) async {
                      },
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
                                "RM " + controller.total.toStringAsFixed(2).toString(),
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
                    isEnabled: controller.total > 0,
                    onPressed: () async {

                    },
                    icon: LineIcons.addToShoppingCart,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: constants.primaryColor,
                    child: CheckoutButton(
                      isEnabled: controller.total > 0,
                      onPressed: () async {
                      },
                      text: controller.length > 1 ? "Checkout (@count)"
                          .trParams({'count': controller.length.toString()})
                          : 'Checkout'.tr,
                    ),
                  ),
                ),
              ],
            ),
          )))
            : SizedBox());
  }

}