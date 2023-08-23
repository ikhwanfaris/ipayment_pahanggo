

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/field/search_input.dart';
import 'package:flutterbase/controller/bill/bayaran_tanpa_bill_controller.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:get/get.dart';

class BTBFilter extends StatelessWidget {
  const BTBFilter({
    super.key,
    required this.controller,
  });

  final BayaranTanpaBillController controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: constants.filterTicketColor,
      child: ListView(
        children: [
          Container(
              color: constants.paleWhite,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('Pilihan', style: styles.heading10bold),
                            // Obx(() => Text(
                            //       ' (@count)'.trParams({
                            //         'count': checkboxController
                            //             .checkedIds.length
                            //             .toString(),
                            //       }),
                            //     )),
                          ],
                        ),
                        GestureDetector(
                            onTap: () {
                              // checkboxController.uncheckAll();
                            },
                            child: Text(
                              'Reset Pilihan',
                              style: styles.heading3,
                            )),
                      ],
                    ),
                    SearchInput(
                        padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
                        backgroundColor: Colors.transparent,
                        onTap: () {},
                        onChanged: (value) {
                          controller.applyFilter(value);
                        }),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Obx(
                            () => GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                childAspectRatio: 5,
                              ),
                              itemCount: controller.items.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      color: constants.widgetFourColor,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            controller.removeItem(index);
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.fromLTRB(
                                                    8, 2, 8, 2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(controller.items[index],
                                                    style:
                                                        styles.heading3sub),
                                                SizedBox(width: 5),
                                                Icon(
                                                  getIcon('x'),
                                                  color:
                                                      constants.primaryColor,
                                                  size: 15,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Card(
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              children: [
                                ExpandableNotifier(
                                  child: ExpandablePanel(
                                    controller: ExpandableController(),
                                    collapsed: SizedBox(),
                                    header: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Text('Kategori',
                                          style: styles.heading10bold),
                                    ),
                                    expanded: Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (controller.filters.length > 1)
                                            ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: controller
                                                  .filters[0].length,
                                              itemBuilder: (context, index) {
                                                var item = controller
                                                    .filters[0][index];
                                                return Row(
                                                  children: [
                                                    // SingleCheckbox(
                                                    //   controllerSingleCheckBox:
                                                    //       checkboxController,
                                                    //   item: Item(id: item.id),
                                                    // ),
                                                    Text(
                                                      item.name,
                                                      style: styles
                                                          .heading10boldPrimary,
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ExpandablePanel(
                                  controller: ExpandableController(),
                                  collapsed: SizedBox(),
                                  header: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('Subkategori',
                                        style: styles.heading10bold),
                                  ),
                                  expanded: Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: controller.filters.length,
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          // Skip the first list (index 0)
                                          return SizedBox.shrink();
                                        } else {
                                          var item =
                                              controller.filters[index];
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              for (var element in item)
                                                Row(
                                                  children: [
                                                    // SingleCheckbox(
                                                    //   controllerSingleCheckBox:
                                                    //       checkboxController,
                                                    //   item: Item(
                                                    //       id: element.id),
                                                    // ),
                                                    Text(
                                                      element.name,
                                                      style: styles.heading10,
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}