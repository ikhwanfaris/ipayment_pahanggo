// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/components/bill_item.dart';
import 'package:flutterbase/components/bottom_bar.dart';
import 'package:flutterbase/components/form/bayaran_bagi_pihak.dart';
import 'package:flutterbase/components/icon_search_input.dart';
import 'package:flutterbase/components/loading_blocker.dart';
import 'package:flutterbase/controller/bill/bayaran_tanpa_kadar_controller.dart';
import 'package:flutterbase/controller/bottom_bar_controller.dart';
import 'package:flutterbase/controller/favorite_controller.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import '../../components/page_title.dart';

class BayaranTanpaKadarServiceScreen extends StatefulWidget {
  @override
  State<BayaranTanpaKadarServiceScreen> createState() => _BayaranTanpaKadarServiceScreenState();
}

class _BayaranTanpaKadarServiceScreenState extends State<BayaranTanpaKadarServiceScreen> {
  final controller = Get.put(BayaranTanpaKadarController());

  final BottomBarController bottomBarController = BottomBarController(false);

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
            Obx(() => controller.isLoading.value ? SizedBox() : IconButton(
              onPressed: () async {
                controller.service!.isFavorite.value = !controller.service!.isFavorite.value;
                if(controller.service!.isFavorite.value) {
                  await favorites.addFavorite(serviceId: controller.service!.id, context: context);
                } else {
                  await favorites.removeFavorite(serviceId: controller.service!.id, context: context);
                }
              },
              icon: controller.service!.isFavorite.value ? Icon(Icons.favorite) : Icon(LineIcons.heart),
            )),
        ],
        shape: const MyShapeBorder(-10.0),
        toolbarHeight: 95,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Obx(() => controller.isLoading.value ? SizedBox() : ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: PageTitle(controller.service?.name ?? ''),
                    ),
                    IconSearchInput((term) {
                      controller.filter(term);
                    })
                  ],
                ),
              ),
              if(controller.bills.isNotEmpty)
                BayaranBagiPihakForm(bottomBarController),
              for (var bill in controller.bills)
                BillItem(bottomBarController, bill),
            ],
          ),
        )),
      ),
      bottomNavigationBar: BottomBar(bottomBarController),
    );
  }
}