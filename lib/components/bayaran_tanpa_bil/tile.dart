
import 'package:flutter/material.dart';
import 'package:flutterbase/components/field/integer_input.dart';
import 'package:flutterbase/controller/bill/bayaran_tanpa_bill_controller.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';

class ProductTile extends StatelessWidget {

  late final BayaranTanpaBillController btbController;
  late final ProductController controller;

  ProductTile(this.btbController, Product product) {
    this.controller = ProductController(product, btbController);
    btbController.productControllers[product.id] = controller;
    btbController.quotaControllers[product.quotaGroup] = controller.quotaController;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xFFF1F2F4), borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.product.name,
                style: styles.heading10bold,
              ),
              SizedBox(height: 8),
              ProductChainDisplay(controller.product.chains),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StockDisplay(controller),
              DailyQuotaDisplay(controller),
              SizedBox(height: 8),
              ProductQuantity(controller),
            ],
          ),
        ],
      )
    );
  }
}

class ProductQuantity extends StatelessWidget {
  final ProductController controller;
  ProductQuantity(this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: controller.btbController.isValid.value && controller.canDeduct ? controller.deduct : null,
              child: Container(
                decoration: BoxDecoration(
                  color: constants.fiveColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Material(
                child: InkWell(
                  onTap: controller.btbController.isValid.value ? () {

                    showBottomSheet(context: context, builder: (_) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        height: 96,
                        child: IntegerInput('Sila masukkan kuantiti:',
                          (v){
                            controller.setQuantity(v);
                          },
                          onDone: () {
                            Navigator.of(context).pop();
                          },
                          maxValue: 100,
                          initialValue: controller.quantity,
                        ),
                      );
                    });
                  } : null,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    width: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    child: Text(
                      "${controller.quantity}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: controller.btbController.isValid.value && controller.canAdd ? controller.add : null,
              child: Container(
                decoration: BoxDecoration(
                    color: constants.primaryColor,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        RichText(
          text: TextSpan(
              children: [
                TextSpan(
                  text:  "RM " + moneyFormat(double.tryParse(controller.product.price.toString()) ?? 0),
                  style: styles.heading10boldPrimary,
                ),
                TextSpan(
                  text: ' ' + (controller.product.unit.isEmpty ? 'Unit' : controller.product.unit),
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
        ),
      ],
    ));
  }

}
class DailyQuotaDisplay extends StatelessWidget {
  final ProductController controller;

  const DailyQuotaDisplay(this.controller);

  @override
  Widget build(BuildContext context) {
    return controller.product.checkQuota ? Obx(() => Text('Quota balance: @quota'.trParams({
      'quota': (controller.quotaController.remainaing).toString(),
    }))) : SizedBox();
  }
}
class StockDisplay extends StatelessWidget {
  final ProductController controller;

  const StockDisplay(this.controller);

  @override
  Widget build(BuildContext context) {
    return controller.product.checkStock ? Obx(() => Text('Stock balance: @stock'.trParams({
      'stock': (controller.product.stock - controller.quantity).toString(),
    }))) : SizedBox();
  }
}

class ProductChainDisplay extends StatelessWidget {
  final List<Chain> chains;

  const ProductChainDisplay(this.chains);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for(int i = 0; i < chains.length; i++)
          Padding(
            padding: EdgeInsets.only(left: 6.0 * i + 4, bottom: 4),
            child: Text('> ' + chains[i].name, style: i == 0 ? styles.errorStyleTicket : null),
          ),
      ],
    );
  }
}