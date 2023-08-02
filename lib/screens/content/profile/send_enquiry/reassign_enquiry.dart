import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/enquiry/list_enquiry.dart';
import 'package:flutterbase/screens/content/profile/send_enquiry/view_enquiry.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/utils/helpers.dart';

class ReassignEnquiryScreen extends StatefulWidget {
  @override
  State<ReassignEnquiryScreen> createState() => _ReassignEnquiryScreenState();
}

class _ReassignEnquiryScreenState extends State<ReassignEnquiryScreen> {
  List<Enquiry> _enquiryModel2 = [];

  
  @override
  void initState() {
    super.initState();
    _getData();

  }

  void _getData() async {
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    _enquiryModel2 = await api.getReassignEnquiry();
    setState(() {
      _enquiryModel2 = _enquiryModel2;
    });

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  Future refresh() async {
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _enquiryModel2.isEmpty
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
                              'You have no reassign enquiry.'.tr,
                              style: styles.heading5,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        refresh();
                      },
                      child: Column(
                        children: [
                          ListView.builder(
                            // reverse: true,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _enquiryModel2.length,
                            itemBuilder: (context, index) {
                              final starttime = DateTime.parse(
                                      _enquiryModel2[index]
                                          .created_at
                                          .toString())
                                  .toLocal();
                              String enquiryStatus = '';
                              if (_enquiryModel2[index].status.toString() ==
                                  'Pertanyaan baharu') {
                                enquiryStatus = 'Pertanyaan baharu';
                              } else if (_enquiryModel2[index]
                                          .status
                                          .toString() ==
                                      'Dalam semakan PTJ' ||
                                  _enquiryModel2[index].status.toString() ==
                                      'Dalam semakan JANM') {
                                enquiryStatus = 'Dalam proses';
                              } else if (_enquiryModel2[index]
                                      .status
                                      .toString() ==
                                  'Menunggu pengesahan pelanggan') {
                                enquiryStatus = 'Menunggu pengesahan pelanggan';
                              } else if (_enquiryModel2[index]
                                      .status
                                      .toString() ==
                                  'Batal') {
                                enquiryStatus = 'Batal';
                              } else if (_enquiryModel2[index]
                                          .status
                                          .toString() ==
                                      'Selesai tanpa maklum balas' ||
                                  _enquiryModel2[index].status.toString() ==
                                      'Selesai dengan pengesahan') {
                                enquiryStatus = 'Selesai';
                              }
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Card(
                                  color: Color(0xffF1F3F6),
                                  child: InkWell(
                                    onTap: () async {
                                      bool a = await navigate(
                                          context,
                                          ViewEnquiryScreen(
                                              _enquiryModel2[index]));
                                      print(a);
                                      _getData();
                                    },
                                    child: ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Date & Time'.tr,
                                                        style: styles
                                                            .heading14sub),
                                                    SizedBox(height: 5),
                                                    Text(DateFormat(
                                                            'dd/MM/yyyy, hh:mm a')
                                                        .format(starttime)),
                                                  ],
                                                ),
                                                Text('${index + 1}',
                                                    style: styles.heading17),
                                              ],
                                            ),
                                            SizedBox(height: 16),
                                            Text('Ticket No.'.tr,
                                                style: styles.heading14sub),
                                            SizedBox(height: 5),
                                            Text(
                                              _enquiryModel2[index]
                                                  .ticket_number
                                                  .toString(),
                                            ),
                                            SizedBox(height: 16),
                                            Text('Enquiry Title'.tr,
                                                style: styles.heading14sub),
                                            SizedBox(height: 5),
                                            Text(
                                              _enquiryModel2[index]
                                                  .title
                                                  .toString(),
                                            ),
                                            SizedBox(height: 16),
                                            Text('Enquiry Description'.tr,
                                                style: styles.heading14sub),
                                            SizedBox(height: 5),
                                            Text(
                                              _enquiryModel2[index].enquiry_category != null ? _enquiryModel2[index].enquiry_category!.name.toString() : 'null'
                                            ),
                                            SizedBox(height: 16),
                                            Text('Status',
                                                style: styles.heading14sub),
                                            SizedBox(height: 5),
                                            Text(enquiryStatus,
                                                style: styles.heading5bold),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(20),
                          //   child: SuccessButton(
                          //     text: 'Load more data',
                          //     onPressed: () {
                          //       setState(() {
                          //         perPage = perPage + 10;
                          //         print(perPage);
                          //         refresh();
                          //       });
                          //     },
                          //   ),
                          // )

                          // !Load more UI/UX
                          // Visibility(
                          //   visible: _loadMore,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       Padding(
                          //         padding: const EdgeInsets.only(
                          //             top: 10, bottom: 16),
                          //         child: ElevatedButton(
                          //           style: ElevatedButton.styleFrom(
                          //             backgroundColor: Constants().primaryColor,
                          //             shape: RoundedRectangleBorder(
                          //               borderRadius:
                          //                   BorderRadius.circular(12.0),
                          //             ),
                          //           ),
                          //           child: Row(
                          //             children: [
                          //               Icon(LineIcons.spinner),
                          //               SizedBox(width: 5),
                          //               Text("Load more data".tr)
                          //             ],
                          //           ),
                          //           onPressed: () {
                          //             setState(() {
                          //               perPage += 10;

                          //               if (perPage > paginateTotal) {
                          //                 perPage = paginateTotal;

                          //                 if (perPage == paginateTotal) {
                          //                   _loadMore = false;
                          //                 }
                          //               }
                          //               print(perPage);
                          //               refresh();
                          //             });
                          //           },
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
