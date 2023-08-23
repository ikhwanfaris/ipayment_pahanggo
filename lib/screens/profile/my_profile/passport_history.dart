import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/users/passport_history.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PassportHistoryScreen extends StatefulWidget {
  PassportHistoryScreen({Key? key}) : super(key: key);

  @override
  _PassportHistoryScreenState createState() => _PassportHistoryScreenState();
}

class _PassportHistoryScreenState extends State<PassportHistoryScreen> {
  List<PassportHistory> _passportHistoryModel = [];

  void initState() {
    super.initState();
    initApp();
  }

  var myLocaleLang = Get.locale?.languageCode;

  initApp() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    _passportHistoryModel = await api.getPassportHistories();

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 55),
            child: Text(
              "Passport Record".tr,
              style: styles.heading1sub,
            ),
          ),
        ),
      ),
      body: Container(
        child: SafeArea(
          child: ListView(
            children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'List of Passport History'.tr +
                                            ' (' +
                                            _passportHistoryModel.length.toString() +
                                            ')',
                                        style: styles.heading5bold,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Divider(
                                      color: constants.primaryColor,
                                      thickness: 5,
                                    ),
                                    SizedBox(height: 20),
                    ],
                  ),
                ),

                    _passportHistoryModel.isEmpty
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(50),
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/dist/aduan.svg',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Text(
                                              'No passport history records found.'
                                                  .tr,
                                              style: styles.heading5,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                                
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _passportHistoryModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    final endDate = DateTime.parse(
                                      _passportHistoryModel[index]
                                          .passportEndDate
                                          .toString())
                                  .toLocal();
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(12,0,12,5),
                      child: Card(
                        color: constants.secondaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Passport Number:'.tr),
                                Text(_passportHistoryModel[index].passportNo ?? ''),
                              ],
                            ),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Passport Expiry Date:'.tr),
                                Text(DateFormat('dd/MM/yyyy').format(endDate)),
                                
                              ],
                            ),
                            _passportHistoryModel[index].reason != '' ?
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Reason of Change:'.tr),
                                Text( _passportHistoryModel[index].reason.toString())
                              ],
                            ) : Container()
                            ],
                          ),
                        )),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
