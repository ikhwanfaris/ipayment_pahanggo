import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({Key? key}) : super(key: key);

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/dist/maintenance-mobile.png'),
            SizedBox(height: 20),
            Text('iPayment is under maintenance.'.tr, style: styles.heading13Primary),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                  'iPayment is undergoing a scheduled maintenance process to ensure the best performance and provide smoother usage.'.tr, style: styles.heading13PrimarySub, textAlign: TextAlign.justify,),
            ),
          ],
        ),
      ),
    );
  }
}
