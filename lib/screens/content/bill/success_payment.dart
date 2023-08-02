import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterbase/utils/constants.dart';

import '../../../components/primary_button.dart';
import '../../../utils/helpers.dart';
import '../home/menu.dart';

class SuccessPaymentScreen extends StatefulWidget {
  const SuccessPaymentScreen({Key? key}) : super(key: key);

  @override
  State<SuccessPaymentScreen> createState() => _SuccessPaymentScreenState();
}

class _SuccessPaymentScreenState extends State<SuccessPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/dist/aduan.svg',
                          height: MediaQuery.of(context).size.width / 3),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Bayaran Berjaya!',
                          style: styles.heading5,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          "Lorem ipsum dolor amet, consectetur adipid sum dolor consectetur adipiscing ",
                          style: styles.heading14sub),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("No Ref", style: styles.heading14sub),
                                Text("123689786")
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Jumlah Bayaran ",
                                      style: styles.heading14sub),
                                  Text("RM 3000")
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PrimaryButton(
                          text: "Kembali ke Utama",
                          onPressed: () {
                            navigate(context, MenuScreen());
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
