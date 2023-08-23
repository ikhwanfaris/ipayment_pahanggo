import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterbase/components/loading_blocker.dart';
import 'package:flutterbase/controller/search_controller.dart' as search_controller;
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/screens/services/bayaran_tanpa_bill.dart';
import 'package:flutterbase/screens/services/bill_detail.dart';
import 'package:flutterbase/screens/services/bayaran_tanpa_bill_dan_amaun.dart';
import 'package:flutterbase/screens/services/bayaran_tanpa_kadar.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  final Menu? menu;

  Search({this.menu});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  late search_controller.SearchController controller;

  @override
  initState() {
    controller = Get.put(search_controller.SearchController(menu: widget.menu));
    loadingBlocker.bind(controller.isLoading);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: Hero(
          tag: "search",
          child: AppBar(
            backgroundColor: constants.reverseWhiteColor,
            title: TextField(
              autofocus: true,
              autocorrect: false,
              controller: controller.searchText,
              decoration: InputDecoration(
                hintText: (widget.menu != null) ? 'Search'.tr + ' ' + widget.menu!.name! : 'Search Services and Products'.tr,
                border: InputBorder.none,
              ),
              onChanged: (value) => controller.isLoading(true),
            ),
            iconTheme: IconTheme.of(context).copyWith(color: constants.primaryColor),
            elevation: 1,
          ),
        ),
      ),
      body: Obx(
        () {
          List<Widget> resultWidgets = [];
          resultWidgets.addAll(
            controller.results
                .map(
                  (e) => Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.black12),
                      ),
                    ),
                    child: ExpandablePanel(
                      controller: ExpandableController(initialExpanded: true),
                      header: ListTile(
                        dense: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.title.toUpperCase(),
                              style: TextStyle(
                                color: constants.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Badge.count(count: e.categories.length, backgroundColor: constants.primaryColor,),
                          ],
                        ),
                      ),
                      collapsed: SizedBox(),
                      expanded: Column(
                          children: e.categories.map((e) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 0.5, color: Colors.black12),
                            ),
                          ),
                          child: ExpandablePanel(
                            controller: ExpandableController(initialExpanded: true),
                            header: ListTile(
                              dense: true,
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      e.title.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: constants.primaryColor,
                                        overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                  ),
                                  Badge.count(count: e.items.length, backgroundColor: constants.fiveColor,),
                                ],
                              ),
                            ),
                            collapsed: SizedBox(),
                            expanded: Column(
                              children: e.items.map((e) {
                                return ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Text(e.title),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Text(e.subtitle),
                                  ),
                                  onTap: () {
                                    int billType = e.billTypeId;
                                    if(e.searchType == 'service') {
                                      switch (billType) {
                                        case 1:
                                          Get.to(() => BillDetailsScreen(), arguments: {
                                            "id": e.id,
                                          });
                                          break;
                                        case 2:
                                          Get.to(() => BillDetailsScreen(), arguments: {
                                            "id": e.id,
                                          });
                                          break;
                                        case 3:
                                          Get.to(() => BayaranTanpaBilServiceScreen(), arguments: {
                                            "id": e.id,
                                          });
                                          break;
                                        case 4:
                                          Get.to(() => BayaranTanpaBillDanAmaunServiceScreen(), arguments: {
                                            "id": e.id,
                                          });
                                          break;
                                        case 5:
                                          Get.to(() => BayaranTanpaKadarServiceScreen(), arguments: {
                                            "id": e.id,
                                          });
                                          break;
                                        default:
                                      }
                                    }
                                    if(e.searchType == 'item') {
                                      Get.to(() => BillDetailsScreen(), arguments: {'id': e.id});
                                    }
                                    if(e.searchType == 'product') {
                                      Get.to(() => BayaranTanpaBilServiceScreen(), arguments: {'id': e.serviceId,});
                                    }
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      }).toList()),
                    ),
                  ),
                )
                .toList(),
          );

          return (controller.isLoading.value)
              ? SizedBox()
              : controller.results.isEmpty
                  ? Container(
                    width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/dist/aduan.svg', height: MediaQuery.of(context).size.width / 3),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                            child: Text((
                              controller.controllerText.value == '' ?
                                "Search can be done using keyword or reference number.".tr :
                                "No record found.".tr
                            ), style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
                          ),
                        ],
                      ))
                  : ListView(
                      children: [
                        ...resultWidgets,
                      ],
                    );
        },
      ),
    );
  }
}
