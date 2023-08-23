import 'package:flutter/material.dart';
import 'package:flutterbase/api/barrel/barrel.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/components/checkout_button.dart';
import 'package:flutterbase/components/loading_blocker.dart';
import 'package:flutterbase/components/page_title.dart';
import 'package:flutterbase/controller/bottom_bar_controller.dart';
import 'package:flutterbase/controller/cart_counter_controller.dart';
import 'package:flutterbase/controller/checkout_controller.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/models/cart/cart.dart';
import 'package:flutterbase/screens/home/payment.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';

class Checkout extends StatefulWidget {
  final RxList<BottomBarItem> items;
  Checkout(this.items);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  late CheckoutController controller;

  @override
  initState() {
    controller = CheckoutController(widget.items);
    controller.loadData();
    super.initState();

    loadingBlocker.bind(controller.isLoading);
  }

  @override
  Widget build(BuildContext context) {
    RxInt no = 0.obs;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        shape: const MyShapeBorder(-20),
      ),
      body: SafeArea(
        child: Obx(() => controller.isLoading.value ? SizedBox() : ListView(
          padding: EdgeInsets.all(16),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Checkout',
                    style: styles.heading8,
                  ),
                ),
              ],
            ),
            Divider(
              color: constants.sixColor,
              thickness: 5,
              endIndent: 250,
            ),
            SizedBox(height: 8),
            for(var chargeTo in controller.chargedTos)
              CheckoutChargedTo(no, chargeTo),
            SizedBox(height: 24),
            PageTitle('Payment Method'.tr),
            SizedBox(height: 8),
            PaymentMethods(controller.gateways, controller),
            SizedBox(height: 16),
          ],
        )),
      ),
      bottomNavigationBar: CheckoutBottomBar(controller),
    );
  }
}
class CheckoutChargedTo extends StatelessWidget {
  final RxInt no;
  final CartChargedTo chargeTo;

  const CheckoutChargedTo(this.no, this.chargeTo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for(var agency in chargeTo.agencies)
          CheckoutAgency(no, agency),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: constants.fiveColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Total Payment:'.tr + ' ', style: TextStyle(fontWeight: FontWeight.w500),),
                Text('RM' + moneyFormat(chargeTo.total), style: TextStyle(fontWeight: FontWeight.w500),),
              ],
            ),
          ),
          SizedBox(height: 4),
          Container(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text('Charge Bearer'.tr + ': ' + chargeTo.chargedTo, style: TextStyle(color: Colors.black45),),
            )
          ),
      ],
    );
  }

}

class CheckoutAgency extends StatelessWidget
{
  final CartAgency agency;
  final RxInt no;
  CheckoutAgency(this.no, this.agency);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(agency.ministry, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black45),),
        Text(agency.department, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black45),),
        Text(agency.agency, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black45),),
        SizedBox(height: 8),
        for(var entry in agency.entries)
          ...[
            if(entry.billTypeId > 2)
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: Row(
                  children: [
                    NoCounter(no: no),
                    Text(entry.serviceName, style: TextStyle(color: Colors.black87),),
                  ],
                ),
              ),
            if(entry.billTypeId < 3)
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: Row(
                  children: [
                    NoCounter(no: no),
                    Text('Bayaran Bil', style: TextStyle(color: Colors.black87),),
                  ],
                ),
              ),
            if(entry.billTypeId == 3)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(entry.extraFieldsSummary.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom:2),
                        child: Text(entry.extraFieldsSummary, style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        )),
                      ),
                    CheckoutEntryBtb(entry: entry),
                  ],
                ),
              ),
            if(entry.billTypeId != 3)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CheckoutEntry(entry: entry),
              ),
          ],
        SizedBox(height: 16),
      ],
    );
  }
}

class NoCounter extends StatelessWidget {
  const NoCounter({
    super.key,
    required this.no,
  });

  final RxInt no;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        no.value = no.value + 1;
        return SizedBox(
          width: 20,
          child: Text(no.value.toString() + '.'),
        );
      }
    );
  }
}

class CheckoutEntry extends StatelessWidget {
  const CheckoutEntry({
    super.key,
    required this.entry,
  });

  final CartEntry entry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for(var item in entry.items)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(item.description ?? '', maxLines: 2,),
              ),
              Text('RM ' + moneyFormat(item.amount)),
            ],
          ),
        if(entry.customerName.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 2),
              Text('Payment on Behalf'.tr + ':', style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              )),
              SizedBox(height: 2),
              Text(entry.customerDetails, style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              )),
            ],
          )
      ],
    );
  }
}

class CheckoutEntryBtb extends StatefulWidget {
  const CheckoutEntryBtb({
    super.key,
    required this.entry,
  });

  final CartEntry entry;

  @override
  State<CheckoutEntryBtb> createState() => _CheckoutEntryBtbState();
}

class _CheckoutEntryBtbState extends State<CheckoutEntryBtb> {
  List<String> categories = [];

  @override
  initState() {
    for(var item in widget.entry.items) {
      if(!categories.contains(item.category)) {
        categories.add(item.category);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(var category in categories)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:4, bottom: 8),
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
              for(var item in widget.entry.items.where((element) => element.category == category,))
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        (item.description ?? '') + ' x ' + item.quantity.toString(),
                        maxLines: 2,
                      )
                    ),
                    Text('RM ' + moneyFormat(item.amount)),
                  ],
                ),
            ],
          ),
      ],
    );
  }
}

class CheckoutBottomBar extends StatelessWidget
{
  final CheckoutController controller;

  CheckoutBottomBar(this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx(() => (!controller.isLoading.value && controller.total > 0 && controller.selectedGatewayId.value != 0)
            ? Container(
      color: constants.secondaryColor,
      child: SafeArea(
        child: Container(
            color: constants.secondaryColor,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox()
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
                Expanded(
                  flex: 3,
                  child: Container(
                    color: constants.primaryColor,
                    child: CheckoutButton(
                      isEnabled: controller.total > 0,
                      onPressed: () async {
                        var response = await ApiCart().pay(controller.getPaymentRequest());
                        await cartCount.refreshCount();
                        if(response != null) {
                          Get.to(() => PaymentScreen(redirectUrl: response.redirect));
                          print(response.redirect);
                        }
                      },
                      text: 'Pay'.tr,
                    ),
                  ),
                ),
              ],
            ),
          )))
          : SizedBox());
  }
}


class PaymentMethods extends StatelessWidget {

  final List<PaymentGateway> gateways;
  final CheckoutController controller;

  PaymentMethods(this.gateways, this.controller);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(var gateway in gateways)
          PaymentMethod(gateway, controller),
      ],
    );
  }
}

class PaymentMethod extends StatelessWidget {
  final PaymentGateway gateway;
  final CheckoutController controller;
  PaymentMethod(this.gateway, this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
      elevation: 0,
      color: controller.selectedGatewayId.value == gateway.id ? constants.primaryColor : constants.fourColor,
      child: ListTile(
        onTap: (){
          controller.setGateway(gateway);
        },
        leading: Builder(
          builder: (context) {
            if(gateway.logo != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  gateway.logo!,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.credit_card)
                ),
              );
            }
            return Icon(Icons.credit_card);
          }
        ),
        title: Text(
          gateway.title!,
          style: TextStyle(color: controller.selectedGatewayId.value == gateway.id? Colors.white : Colors.black),
        ),
        subtitle: (gateway.selectedBank != null) ? Text(
          gateway.selectedBank!.name,
          style: TextStyle(color: controller.selectedGatewayId.value == gateway.id? Colors.white : Colors.black),
        ) : null,
      ),
    ));
  }
}
