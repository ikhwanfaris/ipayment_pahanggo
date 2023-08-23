import 'package:flutter/material.dart';
import 'package:flutterbase/components/add_to_cart_button.dart';
import 'package:flutterbase/components/checkout_button.dart';
import 'package:flutterbase/controller/bottom_bar_controller.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';

class BottomBar extends StatelessWidget
{
  final BottomBarController controller;

  BottomBar(this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx(() => (controller.alwaysShown.value || controller.items.length > 0)
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
                      value: controller.allChecked.value,
                      onChanged: (bool? value) async {
                        controller.allChecked.value = value!;
                        if(controller.onAllChecked != null) {
                          controller.onAllChecked!(value);
                        }
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
                              Text('Total'.tr  +
                                (controller.length > 1 ? ' ('+ controller.length.toString() +')' : ''),),
                              Text(
                                "RM " + moneyFormat(controller.total),
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
                if(!controller.hideCartButton)
                  Expanded(
                    flex: 2,
                    child: AddToCartButton(
                      isEnabled: controller.total > 0,
                      onPressed: () async {
                        await controller.addToCart();
                      },
                    ),
                  ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: constants.primaryColor,
                    child: CheckoutButton(
                      isEnabled: controller.total > 0,
                      onPressed: () async {
                        await controller.checkout();
                      },
                      text: 'Checkout'.tr,
                    ),
                  ),
                ),
              ],
            ),
          )))
            : SizedBox());
  }

}