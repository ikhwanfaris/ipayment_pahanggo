import 'package:flutter/material.dart';
import 'package:flutterbase/api/barrel/barrel.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/bills/bills.dart';
// import 'package:flutterbase/screens/content/cart/widgets/future_loading.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  final Function(PaymentGateway paymentGateway) onChange;

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  PaymentGateway? paymentGateway;

  late Future<List<PaymentGateway>> paymentGatewayOptionsFuture;

  @override
  void initState() {
    super.initState();

    paymentGatewayOptionsFuture = ApiPayment().gateways();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method'.tr,
          style: AppStyles.f3w400.copyWith(
            color: constants.green2,
          ),
        ),
        SizedBox(
          height: AppStyles.u4,
        ),
        GestureDetector(
          onTap: () => showPaymentOptions(),
          child: Container(
            padding: EdgeInsets.all(AppStyles.u3),
            decoration: AppStyles.decoRounded.copyWith(
              color: Colors.white54,
            ),
            child: SizedBox(
              height: AppStyles.u5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: AppStyles.u12,
                    decoration: paymentGateway?.logo != null
                        ? BoxDecoration(
                            image: DecorationImage(
                                image: Image.network(paymentGateway?.logo ?? '')
                                    .image))
                        : null,
                    child: paymentGateway?.logo != null
                        ? SizedBox.shrink()
                        : LineIcon.creditCard(),
                  ),
                  Expanded(
                    child: Text(
                      paymentGateway != null
                          ? "${paymentGateway?.title ?? ''}"
                          : 'Choose Payment Method'.tr,
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
      ],
    );
  }

  void showPaymentOptions() {
    showAppBottomsheet(
      FutureBuilder<List<PaymentGateway>>(
          future: paymentGatewayOptionsFuture,
          builder: (context, future) {
            if (future.connectionState != ConnectionState.done) {
              return Center(child: DefaultLoadingBar());
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var item in future.data!)
                  ListTile(
                    leading: LineIcon.creditCard(),
                    title: Text(
                      item.title ?? 'N/A',
                      style: AppStyles.f4w400,
                    ),
                    onTap: () => doTapPaymentGateway(item),
                  )
              ],
            );
          }),
      title: 'Choose Payment Method'.tr,
    );
  }

  void doTapPaymentGateway(PaymentGateway item) {
    setState(() {
      paymentGateway = item;
    });

    widget.onChange(paymentGateway!);

    Navigator.of(getContext()).pop();
  }
}
