import 'package:flutter/material.dart';
import 'package:flutterbase/components/add_to_cart_button.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/screens/content/home/menu.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class PaymentWithoutBillTourismScreen extends StatefulWidget {
  const PaymentWithoutBillTourismScreen({Key? key}) : super(key: key);

  @override
  State<PaymentWithoutBillTourismScreen> createState() => _PaymentWithoutBillTourismScreenState();
}

TextEditingController dateInput = TextEditingController();
TextEditingController dateOutput = TextEditingController();

int counter = 1;

class _PaymentWithoutBillTourismScreenState extends State<PaymentWithoutBillTourismScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
            child: Text(
          'Bayar Tanpa Bil Pelancongan',
          style: styles.heading1sub,
        )),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              var homeRoute = MaterialPageRoute(builder: (_) => MenuScreen());
              Navigator.of(context).pushAndRemoveUntil(homeRoute, (route) => false);
            },
            icon: Icon(LineIcons.times),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 36, 16, 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pulau Tioman',
                  style: styles.heading6bold,
                ),
                Row(
                  children: [
                    Text(
                      'Kegemaran ',
                      style: styles.heading2sub,
                    ),
                    Icon(LineIcons.heart)
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0x0f000000)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14.0),
                              child: Image.asset(
                                'assets/dist/taman_laut.jpeg',
                                fit: BoxFit.cover,
                                height: 200,
                                width: 500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: dateInput,
                          decoration: styles.inputDecoration.copyWith(suffix: Icon(LineIcons.calendarAlt), label: getRequiredLabel('Tarikh Lawatan')),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                locale: Get.locale?.languageCode == 'en' ? Locale("en") : Locale("ms"),
                                fieldHintText: 'DD/MM/YYYY',
                                fieldLabelText: 'Enter Date'.tr,
                                helpText: 'Select Date'.tr,
                                cancelText: 'Cancel'.tr,
                                confirmText: 'Yes'.tr,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              String formattedDate = dateFormatter.format(pickedDate);
                              setState(() {
                                dateInput.text = formattedDate;
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 24,
                        width: 92,
                        decoration: BoxDecoration(
                          color: const Color(0xffd3eaff),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async {
                              // await _openShowModal();
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // color: constants.secondaryColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 46),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Warganegara
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Warganegara', style: styles.heading10bold),
                                            ),
                                            SizedBox(height: 10),
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                              Text('Dewasa'),
                                              SizedBox(width: 80),
                                              Column(
                                                children: [
                                                  Text('RM ' + 5.toString()),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Material(
                                                            borderRadius: BorderRadius.circular(12),
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  counter--;
                                                                  // amount -=
                                                                  //     200;
                                                                });
                                                              },
                                                              borderRadius: BorderRadius.circular(12),
                                                              child: Container(
                                                                height: 24,
                                                                width: 24,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.red,
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                                child: const Center(
                                                                    child: Text(
                                                                  '-',
                                                                  style: TextStyle(color: Colors.white),
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(counter.toString()),
                                                          SizedBox(width: 10),
                                                          Material(
                                                            borderRadius: BorderRadius.circular(12),
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  counter++;
                                                                  // amount +=
                                                                  //     200;
                                                                });
                                                              },
                                                              borderRadius: BorderRadius.circular(12),
                                                              child: Container(
                                                                height: 24,
                                                                width: 24,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.blue,
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                                child: const Center(
                                                                    child: Text(
                                                                  '+',
                                                                  style: TextStyle(color: Colors.white),
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ]),
                                            SizedBox(height: 10),
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Kanak-kanak / Warga emas',
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text('RM ' + 2.toString()),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Material(
                                                            borderRadius: BorderRadius.circular(12),
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  counter--;
                                                                  // amount -=
                                                                  //     200;
                                                                });
                                                              },
                                                              borderRadius: BorderRadius.circular(12),
                                                              child: Container(
                                                                height: 24,
                                                                width: 24,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.red,
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                                child: const Center(
                                                                    child: Text(
                                                                  '-',
                                                                  style: TextStyle(color: Colors.white),
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(counter.toString()),
                                                          SizedBox(width: 10),
                                                          Material(
                                                            borderRadius: BorderRadius.circular(12),
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  counter++;
                                                                  // amount +=
                                                                  //     200;
                                                                });
                                                              },
                                                              borderRadius: BorderRadius.circular(12),
                                                              child: Container(
                                                                height: 24,
                                                                width: 24,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.blue,
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                                child: const Center(
                                                                    child: Text(
                                                                  '+',
                                                                  style: TextStyle(color: Colors.white),
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ]),
                                            SizedBox(height: 10),
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'OKU',
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 110),
                                              Column(
                                                children: [
                                                  Text('RM ' + 0.toString()),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Material(
                                                            borderRadius: BorderRadius.circular(12),
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  counter--;
                                                                  // amount -=
                                                                  //     200;
                                                                });
                                                              },
                                                              borderRadius: BorderRadius.circular(12),
                                                              child: Container(
                                                                height: 24,
                                                                width: 24,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.red,
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                                child: const Center(
                                                                    child: Text(
                                                                  '-',
                                                                  style: TextStyle(color: Colors.white),
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(counter.toString()),
                                                          SizedBox(width: 10),
                                                          Material(
                                                            borderRadius: BorderRadius.circular(12),
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  counter++;
                                                                  // amount +=
                                                                  //     200;
                                                                });
                                                              },
                                                              borderRadius: BorderRadius.circular(12),
                                                              child: Container(
                                                                height: 24,
                                                                width: 24,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.blue,
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                                child: const Center(
                                                                    child: Text(
                                                                  '+',
                                                                  style: TextStyle(color: Colors.white),
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ]),
                                            //Closed Warganegara
                                            SizedBox(height: 30),
                                            //Open  bukan Warganegara
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Bukan Warganegara', style: styles.heading10bold),
                                            ),
                                            SizedBox(height: 10),
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                              Text('Dewasa'),
                                              SizedBox(width: 80),
                                              Column(
                                                children: [
                                                  Text('RM ' + 30.toString()),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Material(
                                                            borderRadius: BorderRadius.circular(12),
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  counter--;
                                                                  // amount -=
                                                                  //     200;
                                                                });
                                                              },
                                                              borderRadius: BorderRadius.circular(12),
                                                              child: Container(
                                                                height: 24,
                                                                width: 24,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.red,
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                                child: const Center(
                                                                    child: Text(
                                                                  '-',
                                                                  style: TextStyle(color: Colors.white),
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(counter.toString()),
                                                          SizedBox(width: 10),
                                                          Material(
                                                            borderRadius: BorderRadius.circular(12),
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  counter++;
                                                                  // amount +=
                                                                  //     200;
                                                                });
                                                              },
                                                              borderRadius: BorderRadius.circular(12),
                                                              child: Container(
                                                                height: 24,
                                                                width: 24,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.blue,
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                                child: const Center(
                                                                    child: Text(
                                                                  '+',
                                                                  style: TextStyle(color: Colors.white),
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ]),
                                            SizedBox(height: 10),
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Kanak-kanak / Warga emas',
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text('RM ' + 15.toString()),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Material(
                                                            borderRadius: BorderRadius.circular(12),
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  counter--;
                                                                  // amount -=
                                                                  //     200;
                                                                });
                                                              },
                                                              borderRadius: BorderRadius.circular(12),
                                                              child: Container(
                                                                height: 24,
                                                                width: 24,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.red,
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                                child: const Center(
                                                                    child: Text(
                                                                  '-',
                                                                  style: TextStyle(color: Colors.white),
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(counter.toString()),
                                                          SizedBox(width: 10),
                                                          Material(
                                                            borderRadius: BorderRadius.circular(12),
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  counter++;
                                                                  // amount +=
                                                                  //     200;
                                                                });
                                                              },
                                                              borderRadius: BorderRadius.circular(12),
                                                              child: Container(
                                                                height: 24,
                                                                width: 24,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.blue,
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                                child: const Center(
                                                                    child: Text(
                                                                  '+',
                                                                  style: TextStyle(color: Colors.white),
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ]),
                                            SizedBox(height: 10),
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'OKU',
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 110),
                                              Column(
                                                children: [
                                                  Text('RM ' + 0.toString()),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Material(
                                                            borderRadius: BorderRadius.circular(12),
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  counter--;
                                                                  // amount -=
                                                                  //     200;
                                                                });
                                                              },
                                                              borderRadius: BorderRadius.circular(12),
                                                              child: Container(
                                                                height: 24,
                                                                width: 24,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.red,
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                                child: const Center(
                                                                    child: Text(
                                                                  '-',
                                                                  style: TextStyle(color: Colors.white),
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(counter.toString()),
                                                          SizedBox(width: 10),
                                                          Material(
                                                            borderRadius: BorderRadius.circular(12),
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  counter++;
                                                                  // amount +=
                                                                  //     200;
                                                                });
                                                              },
                                                              borderRadius: BorderRadius.circular(12),
                                                              child: Container(
                                                                height: 24,
                                                                width: 24,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.blue,
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                                child: const Center(
                                                                    child: Text(
                                                                  '+',
                                                                  style: TextStyle(color: Colors.white),
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ]),
                                            //Closed Bukan Warganegara
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                              setState(() {});
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: Text(
                                  'Tambah',
                                  style: GoogleFonts.openSans(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xff6ebaff)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Card(
                    color: Color(0xFFF5F6F9),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {},
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jumlah Bayaran',
                                style: styles.heading11,
                              ),
                              SizedBox(height: 10),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Text(
                                  'RM 59.00',
                                  style: styles.heading12bold,
                                ),
                              ]),
                              SizedBox(height: 13),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'WARGANEGARA',
                                        style: styles.heading10bold,
                                      ),
                                      SizedBox(height: 10),
                                      Text('2 X Dewasa , 2 X Kanak-kanak'),
                                      SizedBox(height: 10),
                                      Text(
                                        'BUKAN WARGANEGARA',
                                        style: styles.heading10bold,
                                      ),
                                      SizedBox(height: 10),
                                      Text('1 X Dewasa , 1 X Kanak-kanak'),
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
                ],
              ),
            ),
            Padding(
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
                        confirmPayment(context, 59, '01', [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                    text: 'Bayar RM 59.00 ?',
                                    style: TextStyle(
                                      color: constants.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ),
                        ]);
                      },
                      text: 'Bayar',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
