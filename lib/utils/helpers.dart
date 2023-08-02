import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/default_button.dart';
import 'package:flutterbase/components/delete_button.dart';
import 'package:flutterbase/components/popup_button.dart';
import 'package:flutterbase/components/popper_generator.dart';
import 'package:flutterbase/controller/home_controller.dart';
import 'package:flutterbase/screens/auth/login.dart';
import 'package:flutterbase/screens/content/home/menu.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:localstorage/localstorage.dart';
import 'package:url_launcher/url_launcher.dart';

part 'singletons.dart';

Future navigate<T>(BuildContext context, Widget screen) async {
  var route = MaterialPageRoute<T>(builder: (_) => screen);
  return Navigator.of(context).push<T>(route);
}

Future navigateNamed<T>(BuildContext context, String name,
    {Object? arguments}) async {
  return Navigator.pushNamed(context, name, arguments: arguments);
}

back(BuildContext context) {
  Navigator.of(context).pop();
}

backX2(BuildContext context) {
  int count = 0;
  Navigator.of(context).popUntil((_) => count++ >= 2);
}

backX3(BuildContext context) {
  int count = 0;

  Navigator.of(context).popUntil((_) => count++ >= 3);
}

enum SnackLevel { Info, Error, Success, Warning }

snack(
  BuildContext context,
  String message, {
  SnackLevel level = SnackLevel.Info,
  SnackBarAction? action,
}) {
  Color color = Colors.black54;
  switch (level) {
    case SnackLevel.Info:
      color = Colors.black54;
      break;
    case SnackLevel.Error:
      color = Colors.red;
      break;
    case SnackLevel.Warning:
      color = Colors.orange;
      break;
    case SnackLevel.Success:
      color = constants.primaryColor;
      break;
  }

  var padding = EdgeInsets.only(
    left: AppStyles.u4,
    right: AppStyles.u4,
    top: AppStyles.u2,
    bottom: AppStyles.u6,
  );

  return ScaffoldMessenger.of(context).showSnackBar(
    action != null
        ? SnackBar(
            content: Text(message, textAlign: TextAlign.justify),
            padding: padding,
            backgroundColor: color,
            action: action,
          )
        : SnackBar(
            content: Text(message, textAlign: TextAlign.justify),
            padding: padding,
            backgroundColor: color,
            duration: Duration(
              seconds: message.split(' ').length * 700 ~/ 1000,
            ),
          ),
  );
}

Future<String?> confirmPayment(
  BuildContext context,
  double amount,
  String serviceCode,
  List<Widget> children, {
  String title = 'Confirmation',
  String yesTitle = 'Continue',
  String noTitle = 'Cancel',
  bool hasActions = true,
  bool hasClose = false,
}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        title: title == ''
            ? null
            : Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Text(
                    title.tr,
                    style: styles.heading9bold,
                    textAlign: TextAlign.center,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        back(context);
                      },
                      icon: const Icon(LineIcons.timesCircle),
                      color: Colors.black.withAlpha(64),
                    ),
                  )
                ],
              ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5),
              ...children,
              SizedBox(
                height: !hasActions ? 0 : 10,
              ),
              !hasActions
                  ? const SizedBox()
                  : Text("Please check the info before proceed to payment".tr,
                      style: const TextStyle(
                          color: Color(0xff666666), fontSize: 12),
                      textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: DefaultButton(
                        onPressed: () => Navigator.pop(context, 'no'),
                        text: noTitle.tr.toTitleCase(),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: PopupButton(
                          onPressed: () async {
                            var url = await api.pay(amount, serviceCode);
                            await launchUrl(url, mode: LaunchMode.inAppWebView);
                            await purchaseSuccessful(context);
                          },
                          text: yesTitle.tr.toTitleCase(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        actions: null,
      ),
    );

Future<String?> confirmPayment2(
  BuildContext context,
  double amount,
  List<Widget> children, {
  String title = 'Confirmation',
  String yesTitle = 'Continue',
  String noTitle = 'No',
  bool hasActions = true,
  bool hasClose = false,
}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        title: title == ''
            ? null
            : Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Text(
                    title.tr,
                    style: styles.heading9bold,
                    textAlign: TextAlign.center,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        back(context);
                      },
                      icon: const Icon(LineIcons.timesCircle),
                      color: Colors.black.withAlpha(64),
                    ),
                  )
                ],
              ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5),
              ...children,
              SizedBox(
                height: !hasActions ? 0 : 10,
              ),
              !hasActions
                  ? const SizedBox()
                  : Text('Please check the info before proceed to payment'.tr,
                      style: const TextStyle(
                          color: Color(0xff666666), fontSize: 12),
                      textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: DefaultButton(
                        onPressed: () => Navigator.pop(context, 'no'),
                        text: noTitle.tr.toTitleCase(),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: PopupButton(
                          onPressed: () async {
                            Navigator.pop(context, 'yes');
                            // var url = await api.pay(amount, serviceCode);
                            // await launchUrl(url, mode: LaunchMode.inAppWebView);
                            // await purchaseSuccessful(context);
                          },
                          text: yesTitle.tr.toTitleCase(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        actions: null,
      ),
    );

Future<String?> confirmAddtoCart(
  BuildContext context,
  double amount,
  List<Widget> children, {
  String title = 'Add To Cart',
  String yesTitle = 'Continue',
  String noTitle = 'Cancel',
  bool hasActions = true,
  bool hasClose = false,
}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        title: title == ''
            ? null
            : Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Text(
                    title.tr,
                    style: styles.heading9bold,
                    textAlign: TextAlign.center,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        back(context);
                      },
                      icon: const Icon(LineIcons.timesCircle),
                      color: Colors.black.withAlpha(64),
                    ),
                  )
                ],
              ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5),
              ...children,
              SizedBox(
                height: !hasActions ? 0 : 10,
              ),
              !hasActions
                  ? const SizedBox()
                  : Text("Please check the info before proceed to payment".tr,
                      style: const TextStyle(
                          color: Color(0xff666666), fontSize: 12),
                      textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: DefaultButton(
                        onPressed: () => Navigator.pop(context, 'no'),
                        text: noTitle.tr.toTitleCase(),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: PopupButton(
                          onPressed: () => Navigator.pop(context, 'yes'),
                          text: yesTitle.tr.toTitleCase(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        actions: null,
      ),
    );

Future<String?> errorConfirmation(
  BuildContext context,
  List<Widget> children, {
  String title = '',
  String noTitle = 'Main',
  bool hasActions = false,
  bool hasClose = false,
}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        title: title == ''
            ? null
            : Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        back(context);
                      },
                      icon: const Icon(LineIcons.timesCircle),
                      color: Colors.black.withAlpha(64),
                    ),
                  )
                ],
              ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5),
              ...children,
              SizedBox(
                height: !hasActions ? 0 : 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: DefaultButton(
                        onPressed: () {
                          var homeRoute =
                              MaterialPageRoute(builder: (_) => MenuScreen());
                          Navigator.of(context)
                              .pushAndRemoveUntil(homeRoute, (route) => false);
                        },
                        text: 'Main'.tr.toTitleCase(),
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        actions: null,
      ),
    );

Future<dynamic> purchaseSuccessful(BuildContext context) {
  return errorConfirmation(
    context,
    [
      PopperContainer([
        const SizedBox(height: 40),
        Image.asset(
          'assets/dist/payment_success.png',
          width: 128,
          height: 128,
        ),
        const SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 168, 241, 184),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
          child: const Text(
            'Transaksi Berjaya',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Rujukan'),
            Text(
              "P026770",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Untuk'),
            Text(
              "Taska",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Amaun'),
            Text(
              "RM 175.00",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Fi Perkhidmatan'),
            Text(
              "RM 0.61",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(
            500 ~/ 10,
            (index) => Expanded(
              child: Container(
                color: index % 2 == 0
                    ? Colors.transparent
                    : constants.secondaryColor,
                height: 0.4,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Jumlah',
              style: styles.heading6bold,
            ),
            Text(
              "RM 175.61",
              style: styles.heading6boldYellow,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(
            500 ~/ 10,
            (index) => Expanded(
              child: Container(
                color: index % 2 == 0
                    ? Colors.transparent
                    : constants.secondaryColor,
                height: 0.4,
              ),
            ),
          ),
        ),
      ]),
    ],
    title: '',
    hasActions: false,
  );
}

Future<String?> confirmation(
  BuildContext context,
  List<Widget> children, {
  String title = '',
  String noTitle = 'Tidak',
  String yesTitle = "Ya",
  bool hasActions = true,
  bool hasClose = false,
}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        title: title == ''
            ? null
            : Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Text(title),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        back(context);
                      },
                      icon: const Icon(LineIcons.timesCircle),
                      color: Colors.black.withAlpha(64),
                    ),
                  )
                ],
              ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5),
              ...children,
              SizedBox(
                height: !hasActions ? 0 : 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: PopupButton(
                        onPressed: () {
                          Navigator.pop(context, 'yes');
                        },
                        text: 'Yes'.tr.toTitleCase(),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      flex: 1,
                      child: DefaultButton(
                        onPressed: () => Navigator.pop(context, 'no'),
                        text: 'No'.tr.toTitleCase(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        actions: null,
      ),
    );

Future<String?> deactivateConfirmation(
  BuildContext context,
  List<Widget> children, {
  String title = 'Yes',
  String noTitle = 'No',
  bool hasActions = true,
  bool hasClose = false,
}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        title: title == ''
            ? null
            : Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        back(context);
                      },
                      icon: const Icon(LineIcons.timesCircle),
                      color: Colors.black.withAlpha(64),
                    ),
                  )
                ],
              ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5),
              ...children,
              SizedBox(
                height: !hasActions ? 0 : 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: DeleteButton(
                        onPressed: () => Navigator.pop(context, 'yes'),
                        text: title.tr.toTitleCase(),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      flex: 1,
                      child: DefaultButton(
                        onPressed: () => Navigator.pop(context, 'no'),
                        text: noTitle.tr.toTitleCase(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        actions: null,
      ),
    );

Future<String?> activateConfirmation(
  BuildContext context,
  List<Widget> children, {
  String title = 'Yes',
  String noTitle = 'No',
  bool hasActions = true,
  bool hasClose = false,
}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        title: title == ''
            ? null
            : Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        back(context);
                      },
                      icon: const Icon(LineIcons.timesCircle),
                      color: Colors.black.withAlpha(64),
                    ),
                  )
                ],
              ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5),
              ...children,
              SizedBox(
                height: !hasActions ? 0 : 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: PopupButton(
                        onPressed: () => Navigator.pop(context, 'yes'),
                        text: title.tr.toTitleCase(),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      flex: 1,
                      child: DefaultButton(
                        onPressed: () => Navigator.pop(context, 'no'),
                        text: noTitle.tr.toTitleCase(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        actions: null,
      ),
    );

Future<String?> deleteConfirmation(
  BuildContext context,
  List<Widget> children, {
  String title = 'Yes',
  String noTitle = 'No',
  bool hasActions = true,
  bool hasClose = false,
}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        title: title == ''
            ? null
            : Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        back(context);
                      },
                      icon: const Icon(LineIcons.timesCircle),
                      color: Colors.black.withAlpha(64),
                    ),
                  )
                ],
              ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5),
              ...children,
              SizedBox(
                height: !hasActions ? 0 : 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: PopupButton(
                        onPressed: () => Navigator.pop(context, 'yes'),
                        text: title.tr.toTitleCase(),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      flex: 1,
                      child: DefaultButton(
                        onPressed: () => Navigator.pop(context, 'no'),
                        text: noTitle.tr.toTitleCase(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        actions: null,
      ),
    );

Future<String?> demoteConfirmation(
  BuildContext context,
  List<Widget> children, {
  String title = 'Yes',
  String noTitle = 'No',
  bool hasActions = true,
  bool hasClose = false,
}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        title: title == ''
            ? null
            : Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        back(context);
                      },
                      icon: const Icon(LineIcons.timesCircle),
                      color: Colors.black.withAlpha(64),
                    ),
                  )
                ],
              ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5),
              ...children,
              SizedBox(
                height: !hasActions ? 0 : 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: PopupButton(
                        onPressed: () => Navigator.pop(context, 'yes'),
                        text: title.tr.toTitleCase(),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      flex: 1,
                      child: DefaultButton(
                        onPressed: () => Navigator.pop(context, 'no'),
                        text: noTitle.tr.toTitleCase(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        actions: null,
      ),
    );

Future<String?> cancelConfirmation(
  BuildContext context,
  List<Widget> children, {
  String title = 'Cancel',
  String noTitle = 'Back',
  bool hasActions = true,
  bool hasClose = false,
}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        title: title == ''
            ? null
            : Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        back(context);
                      },
                      icon: const Icon(LineIcons.timesCircle),
                      color: Colors.black.withAlpha(64),
                    ),
                  )
                ],
              ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5),
              ...children,
              SizedBox(
                height: !hasActions ? 0 : 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: DeleteButton(
                        onPressed: () => Navigator.pop(context, 'yes'),
                        text: title.tr.toTitleCase(),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      flex: 1,
                      child: DefaultButton(
                        onPressed: () => Navigator.pop(context, 'no'),
                        text: noTitle.tr.toTitleCase(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        actions: null,
      ),
    );

Future<String?> promoteUserToAdminConfirmation(
  BuildContext context,
  List<Widget> children, {
  String title = 'Yes',
  String noTitle = 'No',
  bool hasActions = true,
  bool hasClose = false,
}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        title: title == ''
            ? null
            : Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        back(context);
                      },
                      icon: const Icon(LineIcons.timesCircle),
                      color: Colors.black.withAlpha(64),
                    ),
                  )
                ],
              ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5),
              ...children,
              SizedBox(
                height: !hasActions ? 0 : 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: PopupButton(
                        onPressed: () => Navigator.pop(context, 'yes'),
                        text: title.tr.toTitleCase(),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      flex: 1,
                      child: DefaultButton(
                        onPressed: () => Navigator.pop(context, 'no'),
                        text: noTitle.tr.toTitleCase(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        actions: null,
      ),
    );

unfocus() {
  FocusManager.instance.primaryFocus?.unfocus();
}

hideSnacks(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
}

logout(BuildContext context) async {
  Get.find<HomeController>().favoriteServices.clear();
  var nextScreen = MaterialPageRoute(builder: (_) => LoginScreen());
  await store.deleteItem(kStoreUserToken);
  Navigator.of(context).pushAndRemoveUntil(nextScreen, (route) => false);
  state.clear();
  await store.clear();
  try {
    snack(context, 'You are logged out.'.tr, level: SnackLevel.Success);
  } catch (e) {
    print(e.toString());
  }
}

// Required label with asterisk
RichText getRequiredLabel(String fieldName) {
  return RichText(
      text: TextSpan(style: styles.heading2, text: fieldName, children: [
    TextSpan(text: ' *', style: TextStyle(color: Colors.red))
  ]));
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach(
    (strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    },
  );
  return MaterialColor(color.value, swatch);
}

class PopperContainer extends StatefulWidget {
  final List<Widget> children;
  const PopperContainer(this.children, {Key? key}) : super(key: key);

  @override
  State<PopperContainer> createState() => _PopperContainerState();
}

class UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
          TextEditingValue oldValue, TextEditingValue newValue) =>
      newValue.copyWith(text: (newValue.text).toUpperCase());
}

class _PopperContainerState extends State<PopperContainer>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));

    _controller.forward().then((v) {
      _controller.reset();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.children,
        ),
        Positioned.fill(
          child: PartyPopperGenerator(
            direction: PopDirection.fowardX,
            motionCurveX: FunctionCurve(func: (t) {
              return -t * t / 2 + t;
            }),
            motionCurveY: FunctionCurve(func: (t) {
              return 4 / 3 * t * t - t / 3;
            }),
            numbers: 10,
            posX: -60.0,
            posY: 30.0,
            pieceHeight: 15.0,
            pieceWidth: 30.0,
            controller: _controller,
          ),
        ),
        Positioned.fill(
          child: PartyPopperGenerator(
            direction: PopDirection.backwardX,
            motionCurveX: FunctionCurve(func: (t) {
              return -t * t / 2 + t;
            }),
            motionCurveY: FunctionCurve(func: (t) {
              return 4 / 3 * t * t - t / 3;
            }),
            numbers: 10,
            posX: -60.0,
            posY: 30.0,
            pieceHeight: 15.0,
            pieceWidth: 30.0,
            controller: _controller,
          ),
        ),
      ],
    );
  }
}

// Make text uppercast on type
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toTitleCase(),
      selection: newValue.selection,
    );
  }
}

// Loading bar
showLoadingBar(BuildContext context) {
  AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: DefaultLoadingBar());

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showQuantityError() {
  Get.snackbar(
    snackPosition: SnackPosition.TOP,
    "",
    "Please enter quantity.".tr,
    messageText: Text(
      "Please enter quantity.".tr,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 16,
      ),
    ),
    padding: EdgeInsets.only(bottom: 30, left: 16),
    backgroundColor: Colors.red,
  );
}

showExtraFieldError() {
  Get.snackbar(
    snackPosition: SnackPosition.TOP,
    "",
    "Please enter field.".tr,
    messageText: Text(
      "Please enter field.".tr,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 16,
      ),
    ),
    padding: EdgeInsets.only(bottom: 30, left: 16),
    backgroundColor: Colors.red,
  );
}

showQuotaQuantityError() {
  Get.snackbar(
    snackPosition: SnackPosition.TOP,
    "",
    "The quota for quantity has reached the maximum limit.".tr,
    messageText: Text(
      "The quota for quantity has reached the maximum limit.".tr,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 16,
      ),
    ),
    padding: EdgeInsets.only(bottom: 30, left: 16),
    backgroundColor: Colors.red,
  );
}

showAmountError() {
  Get.snackbar(
    snackPosition: SnackPosition.TOP,
    "".tr,
    "Please enter amount.".tr,
    messageText: Text(
      "Please enter amount.".tr,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 16,
      ),
    ),
    padding: EdgeInsets.only(bottom: 30, left: 16),
    backgroundColor: Colors.red,
  );
}

showSelectError() {
  Get.snackbar(
    snackPosition: SnackPosition.TOP,
    "".tr,
    "Please select item.".tr,
    messageText: Text(
      "Please select item.".tr,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 16,
      ),
    ),
    padding: EdgeInsets.only(bottom: 30, left: 16),
    backgroundColor: Colors.red,
  );
}

showQuotaError() {
  Get.snackbar(
    snackPosition: SnackPosition.TOP,
    "".tr,
    "The quota on selected date has reached the maximum limit.".tr,
    messageText: Text(
      "The quota on selected date has reached the maximum limit.".tr,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 16,
      ),
    ),
    padding: EdgeInsets.only(bottom: 30, left: 16),
    backgroundColor: Colors.red,
  );
}

Future<bool?> confirmPaymentv2() {
  return Get.defaultDialog<bool>(
    radius: 14,
    title: "",
    titlePadding: EdgeInsets.zero,
    content: Column(
      children: [
        Icon(
          Icons.info,
          color: constants.eightColor,
          size: 50,
        ),
        SizedBox(height: 10),
        Text(
          "Proceed payment?".tr,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
        Text(
          "Proceed to payment gateway".tr,
          textAlign: TextAlign.center,
        ),
      ],
    ),
    // middleText: "Teruskan Pembayaran?",
    textConfirm: "Ya".tr,
    confirmTextColor: Colors.white,
    textCancel: "Tidak".tr,
    contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 20),
    onConfirm: () => Get.back(result: true),
  );
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

String maskEmail(String email) {
  int atIndex = email.indexOf('@');
  String maskedSubstring =
      email.substring(0, atIndex).replaceRange(1, atIndex, '*' * atIndex);
  return maskedSubstring + email.substring(atIndex);
}
