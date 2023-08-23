import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/controller/history_controller.dart';
import 'package:flutterbase/screens/history/pdf_viewer.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class HistorySearchFilters extends StatelessWidget {

  final HistoryController controller;
  HistorySearchFilters(this.controller);

  final RxBool searchShown = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black26),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField(
                  icon: Visibility(visible: false, child: Icon(LineIcons.chevronCircleDown)),
                  isExpanded: true,
                  decoration: styles.inputDecoration.copyWith(
                    suffixIcon: Icon(LineIcons.chevronCircleDown),
                  ),
                  items: HistorySearchParams.paymentCategories.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(item.tr,overflow: TextOverflow.ellipsis,),
                      value: item,
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'This field cannot be left blank.'.tr;
                    }
                    return null;
                  },
                  onChanged: (newVal) {
                    controller.setSearchType(newVal.toString());
                  },
                  value: controller.searchParams.value.type,
                ),
              ),
              Obx(() => IconButton(
                onPressed: (){
                  searchShown.value = !searchShown.value;
                },
                icon: Icon(Icons.search, color: searchShown.value ? constants.primaryColor : Colors.black54,)
              )),
            ],
          ),
          Obx(() {
            Widget result = SizedBox();
            if(searchShown.value) {
              result = Column(
                children: [
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.searchTextController,
                          autocorrect: false,
                          decoration: styles.inputDecoration.copyWith(
                            labelText: 'Search'.tr,
                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                          onChanged: (val) async {
                            controller.setSearchQuery(val);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                          autocorrect: false,
                          controller: controller.fromTextController,
                          decoration: styles.inputDecoration.copyWith(
                              suffix: Icon(LineIcons.calendarAlt),
                              label: Text('Start Date'.tr)),
                          readOnly: true,
                          onTap: () async {
                            DateTime? _pickedDate = await showDatePicker(
                              context: context,
                              locale: Get.locale?.languageCode == 'en'
                                  ? Locale("en")
                                  : Locale("ms"),
                              fieldHintText: 'DD/MM/YYYY',
                              fieldLabelText: 'Enter Date'.tr,
                              helpText: 'Select Date'.tr,
                              cancelText: 'Cancel'.tr,
                              confirmText: 'Yes'.tr,
                              initialDate: controller.fromDate ?? DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                            );
                            controller.setSearchFromDate(_pickedDate);
                            controller.fromTextController.text = '';
                            if (_pickedDate != null) {
                              controller.fromTextController.text = dateFormatterDisplay.format(_pickedDate);
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextFormField(
                          autocorrect: false,
                          controller: controller.toTextController,
                          decoration: styles.inputDecoration.copyWith(
                              suffix: Icon(LineIcons.calendarAlt),
                              label: Text('End Date2'.tr)),
                          readOnly: true,
                          onTap: () async {
                            DateTime? _pickedDate = await showDatePicker(
                              context: context,
                              locale: Get.locale?.languageCode == 'en'
                                  ? Locale("en")
                                  : Locale("ms"),
                              fieldHintText: 'DD/MM/YYYY',
                              fieldLabelText: 'Enter Date'.tr,
                              helpText: 'Select Date'.tr,
                              cancelText: 'Cancel'.tr,
                              confirmText: 'Yes'.tr,
                              initialDate: controller.fromDate ?? DateTime.now(),
                              firstDate: controller.fromDate ?? DateTime.now().subtract(Duration(days: 365)),
                              lastDate: DateTime.now()
                            );

                            controller.toTextController.text = '';
                            controller.setSearchToDate(_pickedDate);
                            if (_pickedDate != null) {
                              controller.toTextController.text = dateFormatterDisplay.format(_pickedDate);
                            }
                          },
                        ),
                      ),

                      IconButton(
                        icon: Icon(Icons.picture_as_pdf),
                        onPressed: () async {
                          String url = await controller.getPdfUrl();

                          navigate(
                            context,
                            PdfViewer(
                              url: url,
                              pageName: "Sejarah Pembayaran",
                            ),
                          );
                        },
                      ),

                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () async {
                          controller.resetSearch();
                        },
                      ),
                    ],
                  ),
                ],
              );
            }
            return result;
          }),
        ],
      ),
    );
  }
}