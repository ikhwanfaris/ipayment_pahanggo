// ignore_for_file: unrelated_type_equality_checks, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutterbase/components/add_to_cart_button.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/screens/bill/listing.dart';
import 'package:flutterbase/screens/bill/pre_payment.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class PreListingScreen extends StatefulWidget {
  final Map from;
  const PreListingScreen({Key? key, required this.from}) : super(key: key);

  @override
  State<PreListingScreen> createState() => _PreListingScreenState();
}

class _PreListingScreenState extends State<PreListingScreen> {
  late Map from = {};
  TextEditingController dateInput = TextEditingController();
  bool selectedMykad = false;
  bool selectedNotMykad = false;
  late bool enabled = true;
  ColorScheme get colors => Theme.of(context).colorScheme;

  @override
  void initState() {
    super.initState();
    initPage();
  }

  initPage() async {
    setState(() {
      from = widget.from;
    });

    print("from PreListingScreen " + from.toString());
  }

  onPressedMykad() async {
    setState(() {
      selectedMykad = true;
      selectedNotMykad = false;
    });
  }

  onPressedNotMykad() async {
    setState(() {
      selectedNotMykad = true;
      selectedMykad = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          from["from"] == "Bil"
              ? "Carian Bil"
              : from["from"] == "BilNoAmaun"
                  ? "Bayaran Bil"
                  : from["from"] == "BilNoBilAmount"
                      ? "Sumbangan"
                      : from["from"] == "BilNoBil"
                          ? "Pelancongan"
                          : from["from"] == "BilNoRate"
                              ? "Kursus & Latihan"
                              : "",
          style: styles.heading4,
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              from["from"] == "Bil"
                  ? Container(
                      color: constants.primaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Heading 1",
                            style: styles.heading1,
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Heading 2",
                              style: styles.heading1sub2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Sila masukkan nombor MyKad pelajar",
                              style: styles.heading1sub,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(11),
                                ),
                              ),
                              child: TextFormField(
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                decoration: styles.inputDecoration2.copyWith(
                                  suffixIcon: LineIcon(Icons.search),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : from["from"] == "BilNoAmaun"
                      ? Container(
                          color: constants.primaryColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Pinjaman Pendidikan (KPM)",
                                style: styles.heading1,
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Kementerian Pendidikan Malaysia",
                                  style: styles.heading1sub2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "No Rujukan Bil",
                                  style: styles.heading1sub,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(11),
                                    ),
                                  ),
                                  child: TextFormField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.number,
                                    decoration:
                                        styles.inputDecoration2.copyWith(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "No MyKad",
                                  style: styles.heading1sub,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(11),
                                    ),
                                  ),
                                  child: TextFormField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.number,
                                    decoration:
                                        styles.inputDecoration2.copyWith(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Jumlah Bayaran",
                                  style: styles.heading1sub,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(11),
                                    ),
                                  ),
                                  child: TextFormField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.number,
                                    decoration:
                                        styles.inputDecoration2.copyWith(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : from["from"] == "BilNoBilAmount"
                          ? Container(
                              color: constants.primaryColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Tabung Bantuan Bencana Negara (TBNN)",
                                    style: styles.heading1,
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      "Agensi Pengurusan Bencana Negara",
                                      style: styles.heading1sub2,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      "Sila masukkan amaun sumbangan",
                                      style: styles.heading1sub,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(11),
                                        ),
                                      ),
                                      child: TextFormField(
                                        autocorrect: false,
                                        keyboardType: TextInputType.number,
                                        decoration:
                                            styles.inputDecoration2.copyWith(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : from["from"] == "BilNoBil"
                              ? Container(
                                  height: 200,
                                  // color: constants.primaryColor,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff7c94b6),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Taman Eko Rimba Kuala Lumpur , Bukit Nenas",
                                        style: styles.heading1,
                                        textAlign: TextAlign.center,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          "Bayaran Permit Memasuki Hutan Simpan Kekal (HSK)",
                                          style: styles.heading1sub2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : from["from"] == "BilNoRate"
                                  ? Container(
                                      width: double.infinity,
                                      color: constants.primaryColor,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            "Pulau Redang, Terengganu",
                                            style: styles.heading1,
                                            textAlign: TextAlign.center,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              "Redang Tourism Malaysia",
                                              style: styles.heading1sub2,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
              AppBar(
                shape: const MyShapeBorder(-10.0),
                automaticallyImplyLeading: false,
              ),
              Container(
                height: 10,
              ),
              from["from"] == "Bil"
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Akaun Kesukaan"),
                              Text("Tambah +")
                            ],
                          ),
                        ),
                        Container(
                          height: 200,
                          child: ListView(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            children: <Widget>[
                              ListTile(
                                title: Text("Yuran Adik Mikail"),
                                subtitle: Text("8768768635"),
                                trailing: Icon(
                                  LineIcons.heart,
                                  color: Constants().primaryColor,
                                ),
                              ),
                              ListTile(
                                title: Text("Maya Amani"),
                                subtitle: Text("8768768635"),
                                trailing: Icon(
                                  LineIcons.heart,
                                  color: Constants().primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : from["from"] == "BilNoBilAmount"
                      ? Container()
                      : from["from"] == "BilNoBil"
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Pilih Tarikh"),
                                  ),
                                  TextFormField(
                                    autocorrect: false,
                                    controller: dateInput,
                                    decoration: styles.inputDecoration.copyWith(
                                        suffix: Icon(LineIcons.calendarAlt),
                                        label:
                                            getRequiredLabel('Tarikh Lawatan')),
                                    readOnly: true,
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              locale:
                                                  Get.locale?.languageCode ==
                                                          'en'
                                                      ? Locale("en")
                                                      : Locale("ms"),
                                              fieldHintText: 'DD/MM/YYYY',
                                              fieldLabelText: 'Enter Date'.tr,
                                              helpText: 'Select Date'.tr,
                                              cancelText: 'Cancel'.tr,
                                              confirmText: 'Yes'.tr,
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2101));

                                      if (pickedDate != null) {
                                        String formattedDate =
                                            dateFormatter.format(pickedDate);
                                        setState(() {
                                          dateInput.text = formattedDate;
                                        });
                                      } else {
                                        print("Date is not selected");
                                      }
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Kategori"),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: selectedMykad == true
                                              ? Constants().primaryColor
                                              : Constants().secondaryColor,
                                          minimumSize: const Size(100, 40),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                        ),
                                        onPressed: onPressedMykad,
                                        child: Text("Pemegang MyKad"),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              selectedNotMykad == true
                                                  ? Constants().primaryColor
                                                  : Constants().secondaryColor,
                                          minimumSize: const Size(100, 40),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                        ),
                                        onPressed: onPressedNotMykad,
                                        child: Text("Bukan Pemegang MyKad"),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Citizen",
                                      style: styles.heading5bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Adult",
                                          style: styles.heading5,
                                        ),
                                        Text(
                                          "RM 30",
                                          style: styles.heading5,
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: onPressed,
                                          style: IconButton.styleFrom(
                                            focusColor: colors.onSurfaceVariant
                                                .withOpacity(0.12),
                                            highlightColor: colors.onSurface
                                                .withOpacity(0.12),
                                            side: onPressed == null
                                                ? BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface
                                                        .withOpacity(0.12))
                                                : BorderSide(
                                                    color: colors.outline),
                                          ).copyWith(
                                            foregroundColor:
                                                MaterialStateProperty
                                                    .resolveWith(
                                                        (Set<MaterialState>
                                                            states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return colors.onSurface;
                                              }
                                              return null;
                                            }),
                                          ),
                                        ),
                                        Text("0", style: styles.heading5),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: onPressed,
                                          style: IconButton.styleFrom(
                                            focusColor: colors.onSurfaceVariant
                                                .withOpacity(0.12),
                                            highlightColor: colors.onSurface
                                                .withOpacity(0.12),
                                            // ignore:
                                            side: onPressed == null
                                                ? BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface
                                                        .withOpacity(0.12))
                                                : BorderSide(
                                                    color: colors.outline),
                                          ).copyWith(
                                            foregroundColor:
                                                MaterialStateProperty
                                                    .resolveWith(
                                                        (Set<MaterialState>
                                                            states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return colors.onSurface;
                                              }
                                              return null;
                                            }),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Kids  ",
                                          style: styles.heading5,
                                        ),
                                        Text(
                                          "RM 30",
                                          style: styles.heading5,
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: onPressed,
                                          style: IconButton.styleFrom(
                                            focusColor: colors.onSurfaceVariant
                                                .withOpacity(0.12),
                                            highlightColor: colors.onSurface
                                                .withOpacity(0.12),
                                            // ignore:
                                            side: onPressed == null
                                                ? BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface
                                                        .withOpacity(0.12))
                                                : BorderSide(
                                                    color: colors.outline),
                                          ).copyWith(
                                            foregroundColor:
                                                MaterialStateProperty
                                                    .resolveWith(
                                                        (Set<MaterialState>
                                                            states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return colors.onSurface;
                                              }
                                              return null;
                                            }),
                                          ),
                                        ),
                                        Text("0", style: styles.heading5),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: onPressed,
                                          style: IconButton.styleFrom(
                                            focusColor: colors.onSurfaceVariant
                                                .withOpacity(0.12),
                                            highlightColor: colors.onSurface
                                                .withOpacity(0.12),
                                            // ignore:
                                            side: onPressed == null
                                                ? BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface
                                                        .withOpacity(0.12))
                                                : BorderSide(
                                                    color: colors.outline),
                                          ).copyWith(
                                            foregroundColor:
                                                MaterialStateProperty
                                                    .resolveWith(
                                                        (Set<MaterialState>
                                                            states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return colors.onSurface;
                                              }
                                              return null;
                                            }),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Non Citizen",
                                      style: styles.heading5bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Adult",
                                          style: styles.heading5,
                                        ),
                                        Text(
                                          "RM 30",
                                          style: styles.heading5,
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: onPressed,
                                          style: IconButton.styleFrom(
                                            focusColor: colors.onSurfaceVariant
                                                .withOpacity(0.12),
                                            highlightColor: colors.onSurface
                                                .withOpacity(0.12),
                                            // ignore:
                                            side: onPressed == null
                                                ? BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface
                                                        .withOpacity(0.12))
                                                : BorderSide(
                                                    color: colors.outline),
                                          ).copyWith(
                                            foregroundColor:
                                                MaterialStateProperty
                                                    .resolveWith(
                                                        (Set<MaterialState>
                                                            states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return colors.onSurface;
                                              }
                                              return null;
                                            }),
                                          ),
                                        ),
                                        Text("0", style: styles.heading5),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: onPressed,
                                          style: IconButton.styleFrom(
                                            focusColor: colors.onSurfaceVariant
                                                .withOpacity(0.12),
                                            highlightColor: colors.onSurface
                                                .withOpacity(0.12),
                                            // ignore:
                                            side: onPressed == null
                                                ? BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface
                                                        .withOpacity(0.12))
                                                : BorderSide(
                                                    color: colors.outline),
                                          ).copyWith(
                                            foregroundColor:
                                                MaterialStateProperty
                                                    .resolveWith(
                                                        (Set<MaterialState>
                                                            states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return colors.onSurface;
                                              }
                                              return null;
                                            }),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Kids  ",
                                          style: styles.heading5,
                                        ),
                                        Text(
                                          "RM 30",
                                          style: styles.heading5,
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: onPressed,
                                          style: IconButton.styleFrom(
                                            focusColor: colors.onSurfaceVariant
                                                .withOpacity(0.12),
                                            highlightColor: colors.onSurface
                                                .withOpacity(0.12),
                                            // ignore:
                                            side: onPressed == null
                                                ? BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface
                                                        .withOpacity(0.12))
                                                : BorderSide(
                                                    color: colors.outline),
                                          ).copyWith(
                                            foregroundColor:
                                                MaterialStateProperty
                                                    .resolveWith(
                                                        (Set<MaterialState>
                                                            states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return colors.onSurface;
                                              }
                                              return null;
                                            }),
                                          ),
                                        ),
                                        Text("0", style: styles.heading5),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: onPressed,
                                          style: IconButton.styleFrom(
                                            focusColor: colors.onSurfaceVariant
                                                .withOpacity(0.12),
                                            highlightColor: colors.onSurface
                                                .withOpacity(0.12),
                                            // ignore:
                                            side: onPressed == null
                                                ? BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface
                                                        .withOpacity(0.12))
                                                : BorderSide(
                                                    color: colors.outline),
                                          ).copyWith(
                                            foregroundColor:
                                                MaterialStateProperty
                                                    .resolveWith(
                                                        (Set<MaterialState>
                                                            states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return colors.onSurface;
                                              }
                                              return null;
                                            }),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "OKU  ",
                                            style: styles.heading5,
                                          ),
                                          Text(
                                            "RM 30",
                                            style: styles.heading5,
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: onPressed,
                                            style: IconButton.styleFrom(
                                              focusColor: colors
                                                  .onSurfaceVariant
                                                  .withOpacity(0.12),
                                              highlightColor: colors.onSurface
                                                  .withOpacity(0.12),
                                              // ignore:
                                              side: onPressed == null
                                                  ? BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface
                                                          .withOpacity(0.12))
                                                  : BorderSide(
                                                      color: colors.outline),
                                            ).copyWith(
                                              foregroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith(
                                                          (Set<MaterialState>
                                                              states) {
                                                if (states.contains(
                                                    MaterialState.pressed)) {
                                                  return colors.onSurface;
                                                }
                                                return null;
                                              }),
                                            ),
                                          ),
                                          Text("0", style: styles.heading5),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: onPressed,
                                            style: IconButton.styleFrom(
                                              focusColor: colors
                                                  .onSurfaceVariant
                                                  .withOpacity(0.12),
                                              highlightColor: colors.onSurface
                                                  .withOpacity(0.12),
                                              // ignore:
                                              side: onPressed == null
                                                  ? BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface
                                                          .withOpacity(0.12))
                                                  : BorderSide(
                                                      color: colors.outline),
                                            ).copyWith(
                                              foregroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith(
                                                          (Set<MaterialState>
                                                              states) {
                                                if (states.contains(
                                                    MaterialState.pressed)) {
                                                  return colors.onSurface;
                                                }
                                                return null;
                                              }),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            )
                          : from["from"] == "BilNoRate"
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Pilih Tarikh",
                                          style: styles.heading5bold,
                                        ),
                                      ),
                                      TextFormField(
                                        autocorrect: false,
                                        controller: dateInput,
                                        decoration: styles.inputDecoration
                                            .copyWith(
                                                suffix:
                                                    Icon(LineIcons.calendarAlt),
                                                label: getRequiredLabel(
                                                    'Tarikh Lawatan')),
                                        readOnly: true,
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  locale: Get.locale
                                                              ?.languageCode ==
                                                          'en'
                                                      ? Locale("en")
                                                      : Locale("ms"),
                                                  fieldHintText: 'DD/MM/YYYY',
                                                  fieldLabelText:
                                                      'Enter Date'.tr,
                                                  helpText: 'Select Date'.tr,
                                                  cancelText: 'Cancel'.tr,
                                                  confirmText: 'Yes'.tr,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2101));

                                          if (pickedDate != null) {
                                            String formattedDate = dateFormatter
                                                .format(pickedDate);
                                            setState(() {
                                              dateInput.text = formattedDate;
                                            });
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Citizen",
                                          style: styles.heading5bold,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Adult",
                                              style: styles.heading5,
                                            ),
                                            Text(
                                              "RM 30",
                                              style: styles.heading5,
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.remove),
                                              onPressed: onPressed,
                                              style: IconButton.styleFrom(
                                                focusColor: colors
                                                    .onSurfaceVariant
                                                    .withOpacity(0.12),
                                                highlightColor: colors.onSurface
                                                    .withOpacity(0.12),
                                                // ignore:
                                                side: onPressed == null
                                                    ? BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface
                                                            .withOpacity(0.12))
                                                    : BorderSide(
                                                        color: colors.outline),
                                              ).copyWith(
                                                foregroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith(
                                                            (Set<MaterialState>
                                                                states) {
                                                  if (states.contains(
                                                      MaterialState.pressed)) {
                                                    return colors.onSurface;
                                                  }
                                                  return null;
                                                }),
                                              ),
                                            ),
                                            Text("0", style: styles.heading5),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: onPressed,
                                              style: IconButton.styleFrom(
                                                focusColor: colors
                                                    .onSurfaceVariant
                                                    .withOpacity(0.12),
                                                highlightColor: colors.onSurface
                                                    .withOpacity(0.12),
                                                // ignore:
                                                side: onPressed == null
                                                    ? BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface
                                                            .withOpacity(0.12))
                                                    : BorderSide(
                                                        color: colors.outline),
                                              ).copyWith(
                                                foregroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith(
                                                            (Set<MaterialState>
                                                                states) {
                                                  if (states.contains(
                                                      MaterialState.pressed)) {
                                                    return colors.onSurface;
                                                  }
                                                  return null;
                                                }),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Kids  ",
                                              style: styles.heading5,
                                            ),
                                            Text(
                                              "RM 30",
                                              style: styles.heading5,
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.remove),
                                              onPressed: onPressed,
                                              style: IconButton.styleFrom(
                                                focusColor: colors
                                                    .onSurfaceVariant
                                                    .withOpacity(0.12),
                                                highlightColor: colors.onSurface
                                                    .withOpacity(0.12),
                                                // ignore:
                                                side: onPressed == null
                                                    ? BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface
                                                            .withOpacity(0.12))
                                                    : BorderSide(
                                                        color: colors.outline),
                                              ).copyWith(
                                                foregroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith(
                                                            (Set<MaterialState>
                                                                states) {
                                                  if (states.contains(
                                                      MaterialState.pressed)) {
                                                    return colors.onSurface;
                                                  }
                                                  return null;
                                                }),
                                              ),
                                            ),
                                            Text("0", style: styles.heading5),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: onPressed,
                                              style: IconButton.styleFrom(
                                                focusColor: colors
                                                    .onSurfaceVariant
                                                    .withOpacity(0.12),
                                                highlightColor: colors.onSurface
                                                    .withOpacity(0.12),
                                                // ignore:
                                                side: onPressed == null
                                                    ? BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface
                                                            .withOpacity(0.12))
                                                    : BorderSide(
                                                        color: colors.outline),
                                              ).copyWith(
                                                foregroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith(
                                                            (Set<MaterialState>
                                                                states) {
                                                  if (states.contains(
                                                      MaterialState.pressed)) {
                                                    return colors.onSurface;
                                                  }
                                                  return null;
                                                }),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Non Citizen",
                                          style: styles.heading5bold,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Adult",
                                              style: styles.heading5,
                                            ),
                                            Text(
                                              "RM 30",
                                              style: styles.heading5,
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.remove),
                                              onPressed: onPressed,
                                              style: IconButton.styleFrom(
                                                focusColor: colors
                                                    .onSurfaceVariant
                                                    .withOpacity(0.12),
                                                highlightColor: colors.onSurface
                                                    .withOpacity(0.12),
                                                // ignore:
                                                side: onPressed == null
                                                    ? BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface
                                                            .withOpacity(0.12))
                                                    : BorderSide(
                                                        color: colors.outline),
                                              ).copyWith(
                                                foregroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith(
                                                            (Set<MaterialState>
                                                                states) {
                                                  if (states.contains(
                                                      MaterialState.pressed)) {
                                                    return colors.onSurface;
                                                  }
                                                  return null;
                                                }),
                                              ),
                                            ),
                                            Text("0", style: styles.heading5),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: onPressed,
                                              style: IconButton.styleFrom(
                                                focusColor: colors
                                                    .onSurfaceVariant
                                                    .withOpacity(0.12),
                                                highlightColor: colors.onSurface
                                                    .withOpacity(0.12),
                                                // ignore:
                                                side: onPressed == null
                                                    ? BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface
                                                            .withOpacity(0.12))
                                                    : BorderSide(
                                                        color: colors.outline),
                                              ).copyWith(
                                                foregroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith(
                                                            (Set<MaterialState>
                                                                states) {
                                                  if (states.contains(
                                                      MaterialState.pressed)) {
                                                    return colors.onSurface;
                                                  }
                                                  return null;
                                                }),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Kids  ",
                                              style: styles.heading5,
                                            ),
                                            Text(
                                              "RM 30",
                                              style: styles.heading5,
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.remove),
                                              onPressed: onPressed,
                                              style: IconButton.styleFrom(
                                                focusColor: colors
                                                    .onSurfaceVariant
                                                    .withOpacity(0.12),
                                                highlightColor: colors.onSurface
                                                    .withOpacity(0.12),
                                                // ignore:
                                                side: onPressed == null
                                                    ? BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface
                                                            .withOpacity(0.12))
                                                    : BorderSide(
                                                        color: colors.outline),
                                              ).copyWith(
                                                foregroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith(
                                                            (Set<MaterialState>
                                                                states) {
                                                  if (states.contains(
                                                      MaterialState.pressed)) {
                                                    return colors.onSurface;
                                                  }
                                                  return null;
                                                }),
                                              ),
                                            ),
                                            Text("0", style: styles.heading5),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: onPressed,
                                              style: IconButton.styleFrom(
                                                focusColor: colors
                                                    .onSurfaceVariant
                                                    .withOpacity(0.12),
                                                highlightColor: colors.onSurface
                                                    .withOpacity(0.12),
                                                // ignore:
                                                side: onPressed == null
                                                    ? BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface
                                                            .withOpacity(0.12))
                                                    : BorderSide(
                                                        color: colors.outline),
                                              ).copyWith(
                                                foregroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith(
                                                            (Set<MaterialState>
                                                                states) {
                                                  if (states.contains(
                                                      MaterialState.pressed)) {
                                                    return colors.onSurface;
                                                  }
                                                  return null;
                                                }),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "OKU  ",
                                              style: styles.heading5,
                                            ),
                                            Text(
                                              "RM 30",
                                              style: styles.heading5,
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.remove),
                                              onPressed: onPressed,
                                              style: IconButton.styleFrom(
                                                focusColor: colors
                                                    .onSurfaceVariant
                                                    .withOpacity(0.12),
                                                highlightColor: colors.onSurface
                                                    .withOpacity(0.12),
                                                // ignore:
                                                side: onPressed == null
                                                    ? BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface
                                                            .withOpacity(0.12))
                                                    : BorderSide(
                                                        color: colors.outline),
                                              ).copyWith(
                                                foregroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith(
                                                            (Set<MaterialState>
                                                                states) {
                                                  if (states.contains(
                                                      MaterialState.pressed)) {
                                                    return colors.onSurface;
                                                  }
                                                  return null;
                                                }),
                                              ),
                                            ),
                                            Text("0", style: styles.heading5),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: onPressed,
                                              style: IconButton.styleFrom(
                                                focusColor: colors
                                                    .onSurfaceVariant
                                                    .withOpacity(0.12),
                                                highlightColor: colors.onSurface
                                                    .withOpacity(0.12),
                                                // ignore:
                                                side: onPressed == null
                                                    ? BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface
                                                            .withOpacity(0.12))
                                                    : BorderSide(
                                                        color: colors.outline),
                                              ).copyWith(
                                                foregroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith(
                                                            (Set<MaterialState>
                                                                states) {
                                                  if (states.contains(
                                                      MaterialState.pressed)) {
                                                    return colors.onSurface;
                                                  }
                                                  return null;
                                                }),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container()
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: from["from"] == "Bil"
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: PrimaryButton(
                        onPressed: () {
                          navigate(
                              context,
                              ListingScreen(
                                from: from,
                              ));
                        },
                        text: 'BUAT CARIAN',
                      ),
                    ),
                  ],
                ),
              )
            : from["from"] == "BilNoAmaun" ||
                    from["from"] == "BilNoBil" ||
                    from["from"] == "BilNoBilAmount" ||
                    from["from"] == "BilNoRate"
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: AddToCartButton(),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 8,
                          child: PrimaryButton(
                            onPressed: () {
                              navigate(context, PrePaymentScreen());
                            },
                            text: 'Bayar - RM 3000.00',
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
      ),
    );
  }

  void onPressed() {}
}
