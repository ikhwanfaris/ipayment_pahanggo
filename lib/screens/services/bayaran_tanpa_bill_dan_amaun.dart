// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/components/bill_item.dart';
import 'package:flutterbase/components/bottom_bar.dart';
import 'package:flutterbase/components/icon_search_input.dart';
import 'package:flutterbase/components/loading_blocker.dart';
import 'package:flutterbase/components/page_title.dart';
import 'package:flutterbase/controller/bill/tanpa_bill_amount_controller.dart';
import 'package:flutterbase/controller/bottom_bar_controller.dart';
import 'package:flutterbase/controller/favorite_controller.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class BayaranTanpaBillDanAmaunServiceScreen extends StatefulWidget {
  @override
  State<BayaranTanpaBillDanAmaunServiceScreen> createState() => _BayaranTanpaBillDanAmaunServiceScreenState();
}

class _BayaranTanpaBillDanAmaunServiceScreenState extends State<BayaranTanpaBillDanAmaunServiceScreen> {
  final controller = Get.put(TanpaBillAmountController());

  final bottomBarController = BottomBarController(false);

  @override
  initState() {
    loadingBlocker.bind(controller.isLoading);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Obx(() => controller.isLoading.value ? SizedBox() : Column(
          children: [
            Text(
              controller.service?.agency.name ?? '',
              maxLines: 2,
            ),
          ],
        )),
        actions: [
          IconSearchInput(
            (term) {
              controller.filter(term);
            },
            noSearchColor: Colors.white38,
            hasSearchColor: Colors.white,
          ),
        ],
        shape: const MyShapeBorder(-10.0),
        toolbarHeight: 95,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Obx(() => controller.isLoading.value ? SizedBox() : ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: PageTitle(controller.service?.name ?? ''),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      controller.service!.isFavorite.value = !controller.service!.isFavorite.value;
                      if(controller.service!.isFavorite.value) {
                        await favorites.addFavorite(serviceId: controller.service!.id, context: context);
                      } else {
                        await favorites.removeFavorite(serviceId: controller.service!.id, context: context);
                      }
                    },
                    icon: controller.service!.isFavorite.value ? Icon(Icons.favorite) : Icon(LineIcons.heart),
                  ),
                ],
              ),
              for(var bill in controller.bills)
                BillItem(bottomBarController, bill)
            ],
          ),
        )),
      ),
      bottomNavigationBar: BottomBar(bottomBarController),
    );
  }
}
