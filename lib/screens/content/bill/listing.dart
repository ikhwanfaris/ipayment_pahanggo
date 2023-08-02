import 'package:flutter/material.dart';
import 'package:flutterbase/components/add_to_cart_button.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/screens/content/bill/pre_payment.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:line_icons/line_icons.dart';

class ListingScreen extends StatefulWidget {
  final Map from;
  const ListingScreen({Key? key, required this.from}) : super(key: key);

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

bool allChecked = false;
bool _isVisibileBtn = false;

class _ListingScreenState extends State<ListingScreen> {
  late Map from = {};

  @override
  void initState() {
    super.initState();
    initPage();
  }

  initPage() async {
    setState(() {
      from = widget.from;
    });

    print("from ListingScreen " + from.toString());
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tajuk Yuran',
                      style: styles.heading8,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Tajuk Yuran Kecil',
                      style: styles.heading8sub,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                child: Visibility(
                  visible: true,
                  child: Column(
                    children: [
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Constants().thirdColor,
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text('Nama Pembayar',
                                            style: styles.heading1sub2),
                                        SizedBox(height: 10),
                                        Text('No IC Pembayar',
                                            style: styles.heading1sub2),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Constants().primaryColor,
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text('Jumlah Keseluruhan',
                                            style: styles.heading1sub2),
                                        SizedBox(height: 10),
                                        Text('RM 8,500.00',
                                            style: styles.heading1),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Senarai Bil", style: styles.heading14sub),
                          const SizedBox(width: 5),
                          Text('Transaksi Bayaran >',
                              style: styles.heading14sub),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Checkbox(
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 1.5,
                            ),
                            checkColor: Colors.white,
                            activeColor: Colors.amber,
                            value: allChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                allChecked = !allChecked;
                                _isVisibileBtn = !_isVisibileBtn;
                              });
                            },
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: 'Pilih Semua',
                                style: styles.heading10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: billDetails,
                        child: Card(
                          elevation: 0,
                          color: Color(0xFFF5F6F9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // for (var item in bills)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Checkbox(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        side: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.5,
                                        ),
                                        checkColor: Colors.white,
                                        activeColor: Colors.amber,
                                        value: allChecked,
                                        onChanged: (bool? value) {
                                          if (value != null) {}
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          LineIcons.heart,
                                          color: Constants().primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Klj . Komuniti Paya Besar',
                                        style: styles.heading14sub,
                                      ),
                                      Text(
                                        'RM 24.00',
                                        style: styles.heading12bold,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('No Bil :'),
                                          Text('Tarikh :'),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text('L6024116'),
                                          Text('28/4/2017, 1:22pm'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: billDetails,
                        child: Card(
                          elevation: 0,
                          color: Color(0xFFF5F6F9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // for (var item in bills)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Checkbox(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        side: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.5,
                                        ),
                                        checkColor: Colors.white,
                                        activeColor: Colors.amber,
                                        value: allChecked,
                                        onChanged: (bool? value) {
                                          if (value != null) {}
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          LineIcons.heart,
                                          color: Constants().primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Klj . Komuniti Paya Besar',
                                        style: styles.heading14sub,
                                      ),
                                      Text(
                                        'RM 24.00',
                                        style: styles.heading12bold,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('No Bil :'),
                                          Text('Tarikh :'),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text('L6024116'),
                                          Text('28/4/2017, 1:22pm'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: billDetails,
                        child: Card(
                          elevation: 0,
                          color: Color(0xFFF5F6F9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // for (var item in bills)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Checkbox(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          side: const BorderSide(
                                            color: Colors.grey,
                                            width: 1.5,
                                          ),
                                          checkColor: Colors.white,
                                          activeColor: Colors.amber,
                                          value: allChecked,
                                          onChanged: (bool? value) {
                                            if (value != null) {}
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            LineIcons.heart,
                                            color: Constants().primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Klj . Komuniti Paya Besar',
                                          style: styles.heading14sub,
                                        ),
                                        Text(
                                          'RM 24.00',
                                          style: styles.heading12bold,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('No Bil :'),
                                            Text('Tarikh :'),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text('L6024116'),
                                            Text('28/4/2017, 1:22pm'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: _isVisibileBtn,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: AddToCartButton(
                  onPressed: () {},
                  icon: LineIcons.addToShoppingCart,
                ),
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
        ),
      ),
    );
  }

  billDetails() {
    print("object");
    // navigate(context, BillDetailsScreen());
  }
}
