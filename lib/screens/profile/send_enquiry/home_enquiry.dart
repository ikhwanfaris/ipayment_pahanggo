import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/field/search_input.dart';
// import 'package:flutterbase/components/form/form_both_date.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/models/enquiry/list_enquiry.dart';
import 'package:flutterbase/screens/profile/my_profile/faq_pdf_viewer.dart';
import 'package:flutterbase/screens/profile/send_enquiry/add_enquiry.dart';
import 'package:flutterbase/screens/profile/send_enquiry/view_enquiry.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:line_icons/line_icons.dart';

class HomeEnquiryScreen extends StatefulWidget {
  @override
  State<HomeEnquiryScreen> createState() => _HomeEnquiryScreenState();
}

class _HomeEnquiryScreenState extends State<HomeEnquiryScreen> {
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  List<Enquiry> _enquiryModel2 = [];
  // DateTime selectedStartDate; 

  String endpoint = ENDPOINT;
  String pdfUrl = '';

  int? orgId;
  // ignore: unused_field
  bool _isLoading = false;
  int? perPage = 200;
  // bool _loadMore = true;

  bool _isKeyBoardVisible = false;

  int paginateTotal = 0;

  bool _isLatest = true;

  String sort = 'desc';

  ScrollController _scrollController = ScrollController();
  bool _isBottomNavBarVisible = true; // Initial state

  @override
  void initState() {
    super.initState();
    _getData();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
  if (_scrollController.position.userScrollDirection ==
      ScrollDirection.reverse) {
    if (_isBottomNavBarVisible) {
      setState(() {
        _isBottomNavBarVisible = false;
      });
    }
  }
  if (_scrollController.position.userScrollDirection ==
      ScrollDirection.forward) {
    if (!_isBottomNavBarVisible) {
      setState(() {
        _isBottomNavBarVisible = true;
      });
    }
  }
}

  void _getData() async {
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    _enquiryModel2 = await api.getEnquiry(perPage, sort);
    setState(() {
      _enquiryModel2 = _enquiryModel2;
    });

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          paginateTotal = store.getItem('paginateTotalLS');
          print(paginateTotal);
          Navigator.pop(context);
        }));
  }

  Future refresh() async {
    _getData();
  }

  void _getPDF(format) async {
    pdfUrl = await api.exportFile(format);

    navigate(
      context,
      FaqPdfViewer(
        url: pdfUrl,
        pageName: "Enquiry".tr,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        _isKeyBoardVisible = isKeyboardVisible;
        return _buildScaffold();
      },
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            LineIcons.angleLeft,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
          child: Text(
            'Enquiry'.tr,
            style: styles.heading1sub,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
                onTap: () {
                  _getPDF('pdf=true');
                },
                child: Icon(getIcon('file-pdf'))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            SearchInput(
              onTap: () {},
              backgroundColor: Colors.white,
              onChanged: (v) {
                setState(() {
                  if (v.isEmpty) {
                    _getData();
                  } else {
                    _enquiryModel2 = _enquiryModel2.where((item) {
                      return item.reference_number
                              .toString()
                              .toLowerCase()
                              .contains(v.toLowerCase()) ||
                          item.ticket_number
                              .toString()
                              .toLowerCase()
                              .contains(v.toLowerCase()) ||
                          item.title
                              .toString()
                              .toLowerCase()
                              .contains(v.toLowerCase()) ||
                          item.description
                              .toString()
                              .toLowerCase()
                              .contains(v.toLowerCase());
                    }).toList();
                  }
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  Container(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: constants.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(getIcon('calendar')),
                            SizedBox(width: 2),
                            Text("Date".tr)
                          ],
                        ),
                        onPressed: () async {
                          setState(() {});
                        }),
                  ),
                  SizedBox(width: 10),
                  Container(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isLatest
                              ? constants.widgetThreeColor
                              : constants.sevenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLatest
                            ? Row(
                                children: [
                                  Icon(getIcon('arrow-circle-up')),
                                  SizedBox(width: 2),
                                  Text("Newest".tr)
                                ],
                              )
                            : Row(
                                children: [
                                  Icon(getIcon('arrow-circle-down')),
                                  SizedBox(width: 2),
                                  Text("Oldest".tr)
                                ],
                              ),
                        onPressed: () async {
                          setState(() {
                            _isLatest = !_isLatest;
                            sort = _isLatest ? 'desc' : 'asc';
                            _getData();
                          });
                        }),
                  ),
                ],
              ),
            ),
            // DateRangePicker(
            //   startDateController: startDateController,
            //   endDateController: endDateController,
            //   startDateLabel: 'Start Date',
            //   endDateLabel: 'End Date',
            //   onStartDateChanged: (newStartDate) {

            //     setState(() {
            //       _enquiryModel2 = _enquiryModel2.where((item) {
            //         return item.created_at.toString().toLowerCase().contains(
            //             DateFormat('yyyy-MM-dd').format(newStartDate));
            //       }).toList();
            //     });
            //   },
            //   onEndDateChanged: (newEndDate) {
            //   },
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12,16,12,0),
              child: Text('#Revamp UI/UX is in progress' .tr, style: styles.errorStyle,),
            ),
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
                              'You have no enquiry.'.tr,
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
                                enquiryStatus = 'Baru';
                              } else if (_enquiryModel2[index]
                                          .status
                                          .toString() ==
                                      'Dalam semakan PTJ' ||
                                  _enquiryModel2[index].status.toString() ==
                                      'Dalam semakan JANM') {
                                enquiryStatus = 'Dalam tindakan';
                              } else if (_enquiryModel2[index]
                                      .status
                                      .toString() ==
                                  'Menunggu pengesahan pelanggan') {
                                enquiryStatus = 'Dalam tindakan';
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
                              } else if (_enquiryModel2[index]
                                      .status
                                      .toString() ==
                                  'Menunggu Maklum Balas Pelanggan') {
                                enquiryStatus = 'Dalam tindakan';
                              }

                              var listTiles = [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 8, 8, 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
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
                                          _enquiryModel2[index]
                                              .enquiry_category!
                                              .name
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ];

                              return Padding(
                                padding: const EdgeInsets.all(12),
                                child: Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text('${index + 1}.',
                                                  style:
                                                      styles.heading13bold))),
                                      Expanded(
                                        flex: 11,
                                        child: ExpansionTile(
                                          textColor: constants.sevenColor,
                                          collapsedBackgroundColor:
                                              constants.reverseWhiteColor,
                                          backgroundColor:
                                              constants.filterTicketColor,
                                          title: InkWell(
                                            onTap: () async {
                                              bool a = await navigate(
                                                  context,
                                                  ViewEnquiryScreen(
                                                      _enquiryModel2[index]));
                                              print(a);
                                              _getData();
                                            },
                                            child: ListTile(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('Date & Time'.tr,
                                                              style: styles
                                                                  .heading14sub),
                                                          SizedBox(height: 5),
                                                          Text(DateFormat(
                                                                  'dd/MM/yyyy, hh:mm a')
                                                              .format(
                                                                  starttime)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 16),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('Ticket No.'.tr,
                                                              style: styles
                                                                  .heading14sub),
                                                          Text(
                                                            _enquiryModel2[
                                                                    index]
                                                                .ticket_number
                                                                .toString(),
                                                          ),
                                                          SizedBox(height: 16),
                                                          Text('Status',
                                                              style: styles
                                                                  .heading14sub),
                                                          SizedBox(height: 5),
                                                          Text(enquiryStatus,
                                                              style: styles
                                                                  .heading5bold),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          children: listTiles,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
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
      bottomNavigationBar: !_isKeyBoardVisible
          ? AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _isBottomNavBarVisible ? 70 : 0,
              child: _isBottomNavBarVisible
                  ? BottomAppBar(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: PrimaryButton(
                            text: 'New Enquiry'.tr,
                            onPressed: () async {
                              bool a =
                                  await navigate(context, AddEnquiryScreen());
                              print(a);
                              _getData();
                            },
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            )
          : null,
    );
  }
}
