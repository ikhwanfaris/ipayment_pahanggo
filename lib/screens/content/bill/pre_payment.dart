import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'success_payment.dart';

class PrePaymentScreen extends StatefulWidget {
  const PrePaymentScreen({Key? key}) : super(key: key);

  @override
  State<PrePaymentScreen> createState() => _PrePaymentScreenState();
}

class _PrePaymentScreenState extends State<PrePaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
        title: Text(
          "Title",
          style: styles.heading5,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Tajuk Bill"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(
                      color: Colors.white70,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  height: 200,
                  child: Card(
                    color: Colors.grey[200],
                    elevation: 5,
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      children: <Widget>[
                        ListTile(
                          leading: Column(
                            children: [
                              Text("Yuran Pengajian"),
                              Text("T1233/AR1234"),
                            ],
                          ),
                          trailing: Column(
                            children: [
                              Text("RM 1500.00"),
                              Text("QTY - 1 "),
                            ],
                          ),
                        ),
                        ListTile(
                          leading: Column(
                            children: [
                              Text("Yuran Pengajian"),
                              Text("T1233/AR1234"),
                            ],
                          ),
                          trailing: Column(
                            children: [
                              Text("RM 1500.00"),
                              Text("QTY - 1 "),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        ListTile(
                          leading: Text("Jumlah "),
                          trailing: Text("RM 3000.00"),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: true,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 250,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Constants().fourColor,
                    border: Border.all(
                      color: Constants().fourColor,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Ringkasan Bayaran",
                            style: styles.heading5bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Jumlah Bayaran",
                              style: styles.heading12bold,
                            ),
                            Text(
                              "RM 3000",
                              style: styles.heading12bold,
                            )
                          ],
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Text(
                            "Kaedah Bayaran",
                            style: styles.heading5bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Constants().secondaryColor,
                            border: Border.all(
                              color: Constants().secondaryColor,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.money),
                            title: Text("Online Banking "),
                            trailing: Icon(
                              LineIcons.heart,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: PrimaryButton(
                        onPressed: () {
                          navigate(context, SuccessPaymentScreen());
                        },
                        text: 'Proceed Payment'.tr,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
