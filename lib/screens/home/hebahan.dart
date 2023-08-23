import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/contents/bulletin/bulletin.dart';
import 'package:flutterbase/screens/home/hebahan_detail.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';

class HebahanScreen extends StatefulWidget {
  HebahanScreen({Key? key}) : super(key: key);

  @override
  _HebahanScreenState createState() => _HebahanScreenState();
}

RxList<Bulletin> hebahanList = RxList<Bulletin>();
DateTime starttime = DateTime.now();
int _activeYear = 2023;

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
    hebahanList.value =
        (response.data as List).map((e) => Bulletin.fromJson(e)).toList();
    // log(jsonEncode(hebahanList));
  }

  void _setActiveYear(int year) {
    setState(() {
      _activeYear = year;
    });
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
          child: Text(
            "Hebahan".tr,
            style: styles.heading1sub,
          ),
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: constants.reverseWhiteColor,
        width: 150,
        child: ListView(children: [
          SizedBox(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Archives'.tr, style: styles.heading13Primary),
                    Text('Archive list'.tr),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 20),
            child: Container(
              child: Column(
                children: [
                  for (int year = 2023; year >= 2022; year--)
                    YearButton(
                      year: year,
                      isActive: _activeYear == year,
                      onPressed: () {
                        _setActiveYear(year);
                        setState(() {
                          if (year == 2022) {
                            hebahanList.value = hebahanList.where((item) {
                              return item.createdAt
                                  .toString()
                                  .toLowerCase()
                                  .contains(
                                      _activeYear.toString().toLowerCase());
                            }).toList();
                          } else {
                            setupHebahan();
                          }
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ]),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Card(
                      color: constants.widgetThreeColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '$_activeYear',
                          style: styles.heading8subWhite,
                        ),
                      )),
                  SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      child: Divider(
                        color: constants.sixColor,
                        thickness: 5,
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              // Use Obx instead of RxBuilder
              () => hebahanList.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/dist/aduan.svg',
                                height: MediaQuery.of(context).size.width / 3),
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: Text(
                                'No record found.'.tr,
                                style: styles.heading5,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: hebahanList.length,
                      itemBuilder: (context, index) {
                        final hebahanItem = hebahanList[index];
                        final starttime = DateTime.parse(
                                hebahanList[index].createdAt.toString())
                            .toLocal();
                        return Card(
                          color: constants.reverseWhiteColor,
                          child: InkWell(
                            onTap: () {
                              navigate(
                                  context,
                                  HebahanDetailScreen(hebahanList,
                                      bulletinId: hebahanList[index].id));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text('${index + 1}.',
                                          style: styles.heading10bold),
                                    ),
                                    Expanded(
                                      flex: 11,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              hebahanItem.translatables?.first
                                                      .content ??
                                                  '',
                                              textAlign: TextAlign.justify),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 25, top: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(getIcon('calendar'),
                                              size: 15,
                                              color: constants.sixColor),
                                          SizedBox(width: 5),
                                          Text(
                                            DateFormat('dd/MM/yyyy')
                                                .format(starttime),
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: constants.eightColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 6,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                          hebahanItem.translatables?.last
                                                  .content ??
                                              '',
                                          textAlign: TextAlign.justify),
                                    ],
                                  ),
                                ),
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

class YearButton extends StatelessWidget {
  final int year;
  final bool isActive;
  final VoidCallback onPressed;

  YearButton(
      {required this.year, required this.isActive, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.rotate(
          angle: math.pi / 2,
          child: Icon(getIcon('hand-pointing'),
              color: isActive ? constants.sixColor : null),
        ),
        SizedBox(width: 10),
        Container(
          child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: isActive
                    ? constants.widgetThreeColor
                    : constants.widgetFourColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('$year')),
        ),
      ],
    );
  }
}
