import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterbase/controller/search_controller.dart' as search_controller;
import 'package:flutterbase/screens/content/home/bill/bill.dart';
import 'package:flutterbase/screens/content/home/bill/bayaran_tanpa_bill.dart';
import 'package:flutterbase/screens/content/home/bill/bill_detail.dart';
import 'package:flutterbase/screens/content/home/bill/bayaran_tanpa_bill_dan_amaun.dart';
import 'package:flutterbase/screens/content/home/bill/bayaran_tanpa_kadar.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';

class Search extends StatelessWidget {
  final controller = Get.put(search_controller.SearchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: Hero(
          tag: "search",
          child: AppBar(
            backgroundColor: Colors.white,
            title: TextField(
              autocorrect: false,
              controller: controller.searchText,
              decoration: InputDecoration(
                hintText: "Search Services".tr,
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
                                  Text(
                                    e.title.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: constants.primaryColor,
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
                                          Get.to(() => Bill(), arguments: {
                                            "id": e.id,
                                          });
                                          break;
                                        case 2:
                                          Get.to(() => Bill(), arguments: {
                                            "id": e.id,
                                          });
                                          break;
                                        case 3:
                                          Get.to(() => BayaranTanpaBill(), arguments: {
                                            "id": e.id,
                                          });
                                          break;
                                        case 4:
                                          Get.to(() => TanpaBillAmount(), arguments: {
                                            "id": e.id,
                                          });
                                          break;
                                        case 5:
                                          Get.to(() => TanpaKadar(), arguments: {
                                            "id": e.id,
                                          });
                                          break;
                                        default:
                                      }
                                    }
                                    if(e.searchType == 'item') {
                                      Get.to(() => BillDetail(), arguments: {'id': e.id});
                                    }
                                    if(e.searchType == 'product') {
                                      Get.to(() => BayaranTanpaBill(), arguments: {'id': e.serviceId,});
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
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: DefaultLoadingBar(),
                      ),
                    ],
                  ),
                )
              : controller.results.isEmpty
                  ? SingleChildScrollView(
                      child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 200.0),
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/dist/aduan.svg', height: MediaQuery.of(context).size.width / 3),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Text("No record found.".tr, style: TextStyle(fontSize: 18)),
                            ),
                            SizedBox(height: Get.height * 0.2)
                          ],
                        ),
                      ),
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
