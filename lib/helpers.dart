import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/enums/enums.dart';
import 'package:flutterbase/main.dart';
import 'package:flutterbase/models/models.dart';
import 'package:flutterbase/providers/providers.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

void xlog(String text) {
  if (kDebugMode) developer.log(text, name: 'iPayment');
}

void xdd(dynamic any) {
  if (kDebugMode) xlog(any.toString());
}

String doubleToString(double any) {
  return any.toString();
}

Map<String, dynamic>? nullableJsonDecode(dynamic any) {
  if (any == null) {
    return any;
  }

  if (any.runtimeType == String) {
    return json.decode(any);
  }

  if (any.runtimeType == Map<String, dynamic>) {
    return any as Map<String, dynamic>;
  }

  return null;
}

List<Map<String, dynamic>>? nullableJsonDecodeList(dynamic any) {
  if (any == null) {
    return null;
  }

  List<Map<String, dynamic>> list = [];

  if (any.runtimeType == List<Map<String, dynamic>>) {
    list = any;
  }

  if (any.runtimeType == String) {
    List<dynamic> sample = json.decode(any);

    for (var item in sample) {
      list.add(item as Map<String, dynamic>);
    }
  }

  return list;
}

bool nullableIntCastBool(dynamic any) {
  if (any == null) {
    return false;
  }

  if (any.runtimeType == bool) {
    return any as bool;
  }

  return any != 0 ? true : false;
}

String? nullableIntToString(dynamic any) {
  if (any == null) {
    return any;
  }

  if (any.runtimeType == int) {
    return any.toString();
  }

  if (any.runtimeType == double) {
    return any.toString();
  }

  return "$any";
}

void mergeMapsRecursive(Map<String, dynamic> map1, Map<String, dynamic> map2) {
  for (var entry in map2.entries) {
    if (map1[entry.key] is Map && entry.value is Map) {
      mergeMapsRecursive(map1[entry.key], entry.value);
    } else {
      map1[entry.key] = entry.value;
    }
  }
}

Map<String, dynamic> dottedKeyValueToMap(Map<String, dynamic> form) {
  Map<String, dynamic> payload = {};

  for (var entry in form.entries) {
    Map<String, dynamic> map = {};

    int count = 0;
    for (var fieldSegment in entry.key.split('.').reversed) {
      if (count == 0) {
        map = {"$fieldSegment": "${entry.value}"};
      } else {
        map = {"$fieldSegment": map};
      }

      count++;
    }

    mergeMapsRecursive(payload, map);
  }

  return payload;
}

List<CartMatrix> castListCartMatrix(dynamic any) {
  if (any == null) {
    return [];
  }

  if (any.runtimeType == List<Map<String, dynamic>>) {
    List<Map<String, dynamic>> rawList = any;

    return rawList.map((e) => CartMatrix.fromJson(e)).toList();
  } else if (any.runtimeType == String && (any as String).startsWith('[')) {
    List<dynamic> rawList = jsonDecode(any);

    return rawList
        .map((e) => CartMatrix.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  return [];
}

int acceptStringOrInt(dynamic any) {
  if (any.runtimeType == int) {
    return any;
  }

  if (any.runtimeType == String) {
    return int.parse(any);
  }

  return 0;
}

BuildContext getContext() {
  return MyApp.navigatorKey.currentContext!;
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> toast(
  String text, {
  SnackBarAction? action,
  SnackLevel level = SnackLevel.Info,
}) {
  return snack(getContext(), text, action: action, level: level);
}

ExtraFieldType extraFieldFromJson(String any) {
  return ExtraFieldType.from(any);
}

String extraFieldToString(ExtraFieldType any) {
  return any.name;
}

void showAppBottomsheet(Widget child,
    {String title = '', List<Widget>? actions}) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    context: getContext(),
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Bottomsheet Header
            Container(
              height: AppStyles.u10,
              child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: AppStyles.u10,
                  leading: IconButton(
                    icon: Icon(
                      LineIcons.times,
                      color: constants.green2,
                      size: AppStyles.u7,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: Text(
                    title,
                    style: AppStyles.f4w400.copyWith(
                      color: constants.green2,
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: constants.green1,
                  actions: actions,
                ),
                body: const SizedBox.shrink(),
              ),
            ),

            /// Bottomsheet Body
            Container(
              color: Colors.white,
              child: child,
            ),
          ],
        ),
      );
    },
  );

  FocusScope.of(getContext()).unfocus();
}

String moneyFormat(double value) {
  return NumberFormat("#,##0.00", "en_US").format(value);
}

Future<bool?> appConfimationDialog(
  String title,
  String message,
  Function() onConfirm, {
  bool autoPop = true,
}) async {
  return Get.defaultDialog<bool>(
    radius: 14,
    title: "",
    titlePadding: EdgeInsets.zero,
    content: Column(
      children: [
        Icon(
          Icons.info,
          color: constants.eightColor,
          size: AppStyles.u12,
        ),
        SizedBox(height: AppStyles.u2),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: AppStyles.u2),
        Text(
          message,
          textAlign: TextAlign.center,
        ),
      ],
    ),
    textConfirm: 'OK'.tr,
    confirmTextColor: Colors.white,
    textCancel: 'Cancel'.tr,
    contentPadding: EdgeInsets.fromLTRB(
      AppStyles.u2,
      0,
      AppStyles.u2,
      AppStyles.u5,
    ),
    onConfirm: () {
      Future.delayed(Duration(milliseconds: 350), onConfirm);

      if (autoPop) {
        Navigator.pop(getContext(), true);
      }
    },
  );
}

Future<bool?> appDialog(
  String title,
  String message,
  List<Widget> Function(BuildContext context) buildActions,
) async {
  var result = await showDialog(
    context: getContext(),
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.info,
            color: constants.eightColor,
            size: AppStyles.u12,
          ),
          SizedBox(height: AppStyles.u2),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: AppStyles.u2),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      contentPadding: EdgeInsets.fromLTRB(
        AppStyles.u2,
        AppStyles.u5,
        AppStyles.u2,
        AppStyles.u5,
      ),
      actions: buildActions(context),
      actionsAlignment: MainAxisAlignment.center,
    ),
  );

  return result;
}

Future<bool?> appDialog2(
  String title,
  List<Widget> Function(BuildContext context) buildActions,
) async {
  var result = await showDialog(
    context: getContext(),
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
      contentPadding: EdgeInsets.fromLTRB(
        AppStyles.u2,
        AppStyles.u5,
        AppStyles.u2,
        AppStyles.u5,
      ),
      actions: buildActions(context),
      actionsAlignment: MainAxisAlignment.center,
    ),
  );

  return result;
}

Future<bool?> appDialogDelete(
  String title,
  String message,
) async {
  var result = await appDialog2(
    title,
    (context) {
      return [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('Yes'.tr),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text('No'.tr),
        ),
      ];
    },
  );

  return result;
}

Future<bool?> appDialogPay(
  String title,
  String message,
) async {
  var result = await appDialog(
    title,
    message,
    (context) {
      return [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text('Yes'.tr),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('No'.tr),
        ),
      ];
    },
  );

  return result;
}

GuestCartProvider getGuestCart() {
  return Provider.of<GuestCartProvider>(getContext(), listen: false);
}

bool isLoggedIn() {
  String _token = store.getItem(kStoreUserToken) ?? '';
  return _token.isNotEmpty;
}

MatrixTitleValue toMatrixTitleValue(dynamic any) {
  try {
    return MatrixTitleValue.fromJson(any as Map<String, dynamic>);
  } catch (_) {}

  if (any.runtimeType == Map<String, dynamic>) {
    return MatrixTitleValue.fromJson(any);
  }

  return MatrixTitleValue.fromJson({});
}

String? toNull(dynamic any) {
  return null;
}

double maybeDouble(dynamic any) {
  if (any.runtimeType == double) {
    return any;
  }

  if (any.runtimeType == int) {
    return double.parse(any.toString());
  }

  if (any.runtimeType == String) {
    return double.parse(any);
  }

  return 0;
}

String fixStatus(String string) {
  var lowercased = string.toLowerCase();
  switch (lowercased) {
    case "failed":
      return "Bayaran Gagal"; // Boleh
    case "pending":
      return "Menunggu Pengesahan"; // Tak boleh
    case "incomplete":
    case "cancelled":
      return "Tidak Lengkap"; // Boleh
    case 'successful':
      return "Bayaran Penuh";
  }
  return string;
}
