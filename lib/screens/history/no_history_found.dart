import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';

class NoHistoryFound extends StatelessWidget {
  const NoHistoryFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            SvgPicture.asset('assets/dist/aduan.svg', height: MediaQuery.of(context).size.width / 3),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'You have no payment history for this category.'.tr,
                style: styles.heading5,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}