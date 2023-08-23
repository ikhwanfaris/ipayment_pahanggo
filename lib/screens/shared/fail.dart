import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/components/primary_button_two.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/screens/home/menu.dart';
import 'package:flutterbase/screens/pending_transactions/close_pending_transactions.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class FailPayment extends StatefulWidget {
  @override
  State<FailPayment> createState() => _FailPaymentState();
}

class _FailPaymentState extends State<FailPayment> {
  List<Payment> _enquiryModel2 = [];

    @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    print("yessss");
    _enquiryModel2 = await api.GetIncomplete();
    setState(() {
      _enquiryModel2 = _enquiryModel2;
    });

    Future.delayed(const Duration(seconds: 0)).then(
      (value) => setState(
        () {
          Navigator.pop(context);
        },
      ),
    );
  }


    billDetails(enquiryModel2) async {
    // ignore: unused_local_variable
    // bool init = await navigate(context, PendingDetailsScreen(enquiryModel2));
    // if (init) _getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFf9f9f9),
        iconTheme: IconThemeData(
          color: Constants().primaryColor,
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => ClosePendingTransactions()),
            icon: Icon(LineIcons.times),
          ),
        ],
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/dist/icon_x.svg'),
            Padding(
              padding: const EdgeInsets.fromLTRB(16,16,16,0),
              child: Text("Payment Failed".tr, style: TextStyle(fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Your payment was unsuccessful.".tr +"\n"+ "Please make a payment again.".tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              width: Get.width * 0.7,
              child: PrimaryButton2(
                text: "Pay".tr,
                onPressed: () => billDetails(_enquiryModel2[0]),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: Get.width * 0.7,
              child: PrimaryButton(
                text: "Home".tr,
                onPressed: () => Get.offAll(() => MenuScreen()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
