import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/controller/bottom_bar_controller.dart';
import 'package:flutterbase/controller/cart_controller.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/models/cart/cart.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController
{
  final List<BottomBarItem> items;
  List<PaymentGateway> gateways = [];
  final List<Bank> banks = [];
  final List<Bank> ewallets = [];
  RxBool isLoading = true.obs;
  RxInt selectedGatewayId = 0.obs;
  PaymentGateway? selectedPaymentGateway;

  CheckoutController(this.items);
  List<CartChargedTo> chargedTos = [];
  final CartController cartController = CartController();
  final BottomBarController bottomBarController = BottomBarController(false);
  double get total => chargedTos.fold<double>(0, (previousValue, element) => previousValue + element.total);

  Future loadData() async {
    isLoading.value = true;
    var response = await api.getCarts(ids: items.map<int>((element) => element.cartId!).toList());
    if(response.isSuccessful) {
      for(var json in response.data) {
        chargedTos.add(CartChargedTo.fromJson(cartController, json, bottomBarController));
      }
    }

    response = await api.getBankList();
    if(response.isSuccessful) {
      for(var item in response.data) {
        if(item['redirectUrls'] != null) {
          for(var url in item['redirectUrls']) {
            if(url['type'] != null && url['url'] != null)
            banks.add(Bank.fromJson(url['type'], url['url'], item));
          }
        }
      }
    }

    response = await api.getEwalletList();
    if(response.isSuccessful) {
      for(var item in response.data) {
        ewallets.add(Bank.fromEwalletJson(item));
      }
    }

    banks.sort((a, b) => a.name.compareTo(b.name));

    ewallets.sort((a, b) => a.name.compareTo(b.name));

    gateways = await api.GetPaymentGateway();

    isLoading.value = false;
  }

  Future setGateway(PaymentGateway gateway) async {
    if(gateway.requiresBankSelected) {
      List<Bank> bankList = gateway.id == 2 ?
        banks :
        ewallets
        ;
      String popupTitle = gateway.id == 2 ?
        "List of Banks/E-wallets".tr :
        "List of E-wallets".tr
        ;

      var types = bankList.groupBy<String>((b) => b.type);

      Bank? bank = await showCupertinoModalPopup(context: getContext(), builder: (_) => BankPicker(popupTitle, types: types));
      if(bank != null) {
        gateway.selectedBank = bank;
        selectedGatewayId.value = gateway.id!;
        selectedPaymentGateway = gateway;
      }
    } else {
      selectedGatewayId.value = gateway.id!;
      selectedPaymentGateway = gateway;
    }
  }

  Map<String, dynamic> getPaymentRequest() {
    Map<String, dynamic> request = {
      'ids[]': chargedTos.fold<List<int>>([], (previousValue, element) {
        for(var item in element.agencies) {
          for(var entry in item.entries) {
            previousValue.add(entry.id);
          }
        }
        return previousValue;
      }),
      'payment_method': selectedPaymentGateway!.id,
      'source': 'mobile',
    };

    if(
      selectedPaymentGateway!.selectedBank != null &&
      selectedPaymentGateway!.selectedBank!.code.isNotEmpty &&
      selectedPaymentGateway!.selectedBank!.url.isNotEmpty &&
      selectedPaymentGateway!.selectedBank!.type.isNotEmpty
    ) {
      request['bank_code'] = selectedPaymentGateway!.selectedBank!.code;
      request['redirect_url'] = selectedPaymentGateway!.selectedBank!.url;
      request['bank_type'] = selectedPaymentGateway!.selectedBank!.type == 'Retail' ? 'RET' : 'COR';
    }

    return request;
  }
}

class BankPicker extends StatefulWidget {
  final String title;
  const BankPicker(this.title, {
    super.key,
    required this.types,
  });

  final Map<String, List<Bank>> types;

  @override
  State<BankPicker> createState() => _BankPickerState();
}

class _BankPickerState extends State<BankPicker> {
  String search = '';
  @override
  Widget build(BuildContext context) {
    Map<String, List<Bank>> types = {};
    var keys = widget.types.keys.toList();
    keys.sort((a, b) => b.compareTo(a));

    for(var key in keys) {
      types[key] = widget.types[key]!
        .where((element) {
          if(search.isEmpty) {
            return true;
          }
          return element.name.toLowerCase().contains(search.toLowerCase());
        })
        .toList();
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TextFormField(
              autofocus: true,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Search'.tr,
              ),
              onChanged: (v){
                setState(() {
                  search = v;
                });
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for(var type in types.keys)
                  ...[
                    if(type.isNotEmpty && types[type]!.isNotEmpty)
                      ListTile(
                        tileColor: constants.fiveColor,
                        dense: true,
                        title: Text(type.toUpperCase()),
                      ),
                    for(var bank in types[type]!)
                      ListTile(
                        onTap: (){
                          Navigator.of(context).pop<Bank>(bank);
                        },
                        title: Text(bank.name),
                      ),
                  ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

