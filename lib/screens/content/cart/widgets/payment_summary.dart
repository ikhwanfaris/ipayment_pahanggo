import 'package:flutter/material.dart';
import 'package:flutterbase/api/barrel/barrel.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/models/contents/bank.dart';
// import 'package:flutterbase/screens/content/cart/cart.dart';
import 'package:flutterbase/screens/content/cart/widgets/widgets.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';

class PaymentSummary extends StatefulWidget {
  const PaymentSummary({
    super.key,
    required this.onSelectedPaymentGateway,
    required this.onClickPay,
    required this.total,
    required this.paymentGateway,
  });

  final Function(PaymentGateway) onSelectedPaymentGateway;
  final Function(Bank? bank) onClickPay;
  final PaymentGateway? paymentGateway;
  final String total;

  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
}

class _PaymentSummaryState extends State<PaymentSummary> {
  late Future<List<Bank>> banksOptionFuture;

  Bank? bank;

  @override
  void initState() {
    super.initState();

    banksOptionFuture = Future.value([]);
  }

  @override
  Widget build(BuildContext context) {
    var isNeedBank = (widget.paymentGateway?.needPaynetBank() ?? false);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppStyles.paddingBaseX,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SecondarySection(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Total due
                PaymentTotal(
                  amountTitle: 'RM ${widget.total}',
                ),

                /// Separator
                SizedBox(
                  height: AppStyles.u4,
                ),
                Container(
                  height: 1,
                  color: Colors.white,
                ),
                SizedBox(
                  height: AppStyles.u4,
                ),

                /// Select Payment Method Button
                PaymentMethod(
                  onChange: (selectedGateway) {
                    bank = null;
                    widget.onSelectedPaymentGateway(selectedGateway);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: AppStyles.u3),
          if (isNeedBank)
            SecondarySection(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'List of banks'.tr,
                    style: AppStyles.f3w400.copyWith(
                      color: constants.green2,
                    ),
                  ),
                  SizedBox(
                    height: AppStyles.u4,
                  ),

                  /// Select Bank Button
                  GestureDetector(
                    onTap: () => selectPaynetBank(postChooseBank),
                    child: Container(
                      padding: EdgeInsets.all(AppStyles.u3),
                      decoration: AppStyles.decoRounded.copyWith(
                        color: Colors.white54,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppStyles.paddingBaseX,
                        ),
                        child: SizedBox(
                          height: AppStyles.u5,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: AppStyles.u12,
                                child: Icon(Icons.location_city_rounded),
                              ),
                              Expanded(
                                child: Text(
                                  bank == null
                                      ? "Select Bank or E-wallet".tr
                                      : bank!.name,
                                  style: AppStyles.f4w400,
                                ),
                              ),
                              Icon(
                                Icons.edit_outlined,
                                color: constants.splashColor,
                                size: AppStyles.u4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: AppStyles.u3),
          PrimaryButton(
            text: 'Pay'.tr,
            onPressed: haveToSelectBank() ? null : () => doPay(),
          ),
          SizedBox(height: kToolbarHeight),
        ],
      ),
    );
  }

  bool haveToSelectBank() {
    if (widget.paymentGateway == null) return true;

    return (widget.paymentGateway?.needPaynetBank() ?? false) && bank == null;
  }

  doPay() {
    if (haveToSelectBank()) {
      selectPaynetBank(postChooseBank);

      return;
    }

    widget.onClickPay(bank);
  }

  postChooseBank(Bank selectedBank) {
    setState(() {
      bank = selectedBank;
    });

    // Future.delayed(const Duration(milliseconds: 500), () {
    //   widget.onClickPay(selectedBank);
    // });
  }

  doChooseBank(Function(Bank bank) callback, Bank item) {
    bank = item;
    callback(item);

    Navigator.of(getContext()).pop();
  }

  selectPaynetBank(Function(Bank bank) callback) {
    setState(() {
      banksOptionFuture = ApiPayment().paynetBanks();
    });

    showAppBottomsheet(
      FutureBuilder<List<Bank>>(
        future: banksOptionFuture,
        builder: (context, future) {
          if (future.connectionState != ConnectionState.done) {
            return Center(child: DefaultLoadingBar());
          }

          return _ListOfBanks(
            callback: callback,
            future: future,
            doChooseBank: doChooseBank,
          );
        },
      ),
      title: 'Choose Bank'.tr,
    );
  }
}

class _ListOfBanks extends StatefulWidget {
  const _ListOfBanks({
    required this.future,
    required this.callback,
    required this.doChooseBank,
  });

  final AsyncSnapshot<List<Bank>> future;
  final Function(Bank bank) callback;
  final Function(Function(Bank bank) callback, Bank item) doChooseBank;

  @override
  State<_ListOfBanks> createState() => _ListOfBanksState();
}

class _ListOfBanksState extends State<_ListOfBanks> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(getContext()).size.height * 0.5,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var item in widget.future.data!)
              ListTile(
                title: Text(
                  item.name,
                  style: AppStyles.f4w400,
                ),
                onTap: () => widget.doChooseBank(widget.callback, item),
              )
          ],
        ),
      ),
    );
  }
}

class PaymentTotal extends StatelessWidget {
  const PaymentTotal({
    Key? key,
    required this.amountTitle,
  }) : super(key: key);

  final String amountTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Summary'.tr,
          style: AppStyles.f3w400.copyWith(
            color: constants.green2,
          ),
        ),
        SizedBox(
          height: AppStyles.u4,
        ),
        Container(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Payment Total'.tr,
                  style: AppStyles.f4w400,
                ),
              ),
              Expanded(
                child: Text(
                  amountTitle,
                  style: AppStyles.f4w400,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
