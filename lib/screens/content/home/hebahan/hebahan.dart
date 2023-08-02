import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/bulletin/bulletin.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class HebahanScreen extends StatefulWidget {
  HebahanScreen({Key? key}) : super(key: key);

  @override
  _HebahanScreenState createState() => _HebahanScreenState();
}

RxList<Bulletin> hebahanList = RxList<Bulletin>();

class _HebahanScreenState extends State<HebahanScreen> {
  void initState() {
    super.initState();
    initApp();
    setupHebahan();
  }

  initApp() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));

    setState(() {});

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  setupHebahan() async {
    var response = await api.getBulletin(isBulletin: true);
    hebahanList.value = (response.data as List).map((e) => Bulletin.fromJson(e)).toList();
    // log(jsonEncode(hebahanList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
            icon: const Icon(
              LineIcons.angleLeft,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 55),
            child: Text(
              "Hebahan".tr,
              style: styles.heading1sub,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Announcements'.tr,
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
                Row(children: [
                  Expanded(
                    child: SizedBox(
                      child: Divider(
                        color: constants.primaryColor,
                        thickness: 5,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Card(
                      color: constants.sixColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '2023',
                          style: styles.heading8subWhite,
                        ),
                      )),
                ]),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              // Use Obx instead of RxBuilder
              () => hebahanList.isEmpty
                  ? Center(child: DefaultLoadingBar())
                  : ListView.builder(
                      itemCount: hebahanList.length,
                      itemBuilder: (context, index) {
                        final hebahanItem = hebahanList[index];
                        return Card(
                          color: constants.reverseWhiteColor,
                          child: InkWell(
                            onTap: () {
                              // navigate(context, SearchBillScreen());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Text('${index + 1}.',
                                    style: styles.heading10bold),
                                title: Text(
                                    hebahanItem.translatables?.first.content ??
                                        '', textAlign: TextAlign.justify),
                                subtitle: Text(
                                    hebahanItem.translatables?.last.content ??
                                        '', textAlign: TextAlign.justify),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
