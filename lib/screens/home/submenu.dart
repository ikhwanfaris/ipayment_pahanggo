import 'dart:developer' as log;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterbase/components/loading_blocker.dart';
import 'package:flutterbase/controller/submenu_controller.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/screens/auth/login.dart';
import 'package:flutterbase/screens/services/bayaran_tanpa_bill.dart';
import 'package:flutterbase/screens/services/bayaran_tanpa_bill_dan_amaun.dart';
import 'package:flutterbase/screens/home/menu.dart';
import 'package:flutterbase/screens/search/search.dart';
import 'package:flutterbase/screens/services/bayaran_tanpa_kadar.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../../components/appbar_header.dart';

class SubmenuScreen extends StatefulWidget {
  @override
  State<SubmenuScreen> createState() => _SubmenuScreenState();
}

class _SubmenuScreenState extends State<SubmenuScreen> {
  final controller =
      Get.put(SubmenuController(), tag: Random().nextInt(100).toString());

  Size get preferredSize => AppBar().preferredSize;

  initState() {
    loadingBlocker.bind(controller.isLoading);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Service".tr, style: styles.heading1sub)),
        leading: IconButton(
            icon: const Icon(
              LineIcons.angleLeft,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              var homeRoute = MaterialPageRoute(builder: (_) => MenuScreen());
              Navigator.of(context)
                  .pushAndRemoveUntil(homeRoute, (route) => false);
            },
            icon: Icon(LineIcons.times),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Material(
              color: constants.primaryColor,
              shape: MyShapeBorder(-20),
              child: Container(
                height: 20,
              ),
            ),
            MenuTitle(controller: controller),
            SizedBox(height: 10),
            Obx(
              () => controller.isLoading.value
                  ? SizedBox()
                  : (controller.submenus.isNotEmpty)
                      ? GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(12),
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          mainAxisSpacing: 9,
                          crossAxisSpacing: 10,
                          children: [
                            for (var item in controller.submenus)
                              SubMenuWidget(item: item),
                          ],
                        )
                      : Container(),
            ),
            (controller.submenus.isNotEmpty)
                ? Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Divider(indent: 20, endIndent: 20, thickness: 1),
                )
                : Container(),
            Obx(
              () {
                List<Widget> children = [];
                for (var i = 0; i < controller.services.length; i = i + 2) {
                  children.addAll([
                    ServiceWidget(controller, controller.services[i], (i + 1 < controller.services.length) ? controller.services[i + 1] : null),
                    Divider(color: Colors.transparent, height: 30)
                  ]);
                }
                return Column(
                  children: children,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class ServiceWidget extends StatelessWidget {
  final SubmenuController controller;
  final Services firstService;
  final Services? secondService;
  const ServiceWidget(this.controller, this.firstService, this.secondService);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ServiceBox(
            firstService,
            onPressed: () =>
                controller.favourite(firstService.id.toString()),
          ),
          (secondService != null)
              ? ServiceBox(
                secondService!,
                onPressed: () => controller
                    .favourite(secondService!.id.toString()),
                )
              : Container(),
        ],
      ),
    );
  }
}

class SubMenuWidget extends StatelessWidget {
  const SubMenuWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Menu item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () => Get.to(() => SubmenuScreen(),
            arguments: item, preventDuplicates: false),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              getIcon(item.iconClass ?? 'info'),
              size: 48,
            ),
            const SizedBox(height: 8),
            Text(
              item.name ?? "",
              maxLines: 3,
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff333333),
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
class MenuTitle extends StatelessWidget {
  const MenuTitle({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SubmenuController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
          alignment: Alignment.centerLeft,
          child: Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.title.value,
                        style: TextStyle(fontSize: 18),
                      ),
                      Divider(
                        color: constants.sixColor,
                        thickness: 5,
                        endIndent: 250,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    Get.to(Search(menu: controller.menu));
                  },
                  child: Icon(getIcon('magnifying-glass'), color: Colors.black26,),
                ),
              ],
            ),
          ))],
        );
        // Container(
        //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        //   alignment: Alignment.centerLeft,
        //   child: Text(
        //     "List of @service".trParams({"service": controller.title.value}),
        //     style: TextStyle(fontSize: 14, color: Colors.grey),
        //   ),
        // ),
  }
}

class ServiceBox extends StatelessWidget {
  final Services service;
  const ServiceBox(this.service, {
    Key? key,
    required this.onPressed,
  });
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.42,
      constraints: BoxConstraints(minHeight: 150),
      margin: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: constants.reverseWhiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () async {
            log.log("Bill Type ID: ${service.billTypeId}", name: "Submenu");
            switch (service.billTypeId) {
              // case 1:
              //   Get.to(() => BillsScreen(), arguments: {
              //     "id": serviceRefNum,
              //     "amountRequired": false
              //   });
              //   break;
              // case 2:
              //   Get.to(() => BillsScreen(), arguments: {
              //     "serviceRefNum": serviceRefNum,
              //     "amountRequired": true
              //   });
              //   break;
              case 3:
                Get.to(() => BayaranTanpaBilServiceScreen(), arguments: {
                  "id": service.id,
                });
                break;
              case 4:
                Get.to(() => BayaranTanpaBillDanAmaunServiceScreen(), arguments: {
                  "id": service.id,
                });
                break;
              case 5:
                Get.to(() => BayaranTanpaKadarServiceScreen(), arguments: {
                  "id": service.id,
                });
                break;
              default:
            }
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(
                        () => IconButton(
                          splashColor: Colors.transparent,
                          onPressed: () {
                            if (isLoggedIn()) {
                              service.isFavorite.value = !service.isFavorite.value;
                              onPressed();
                            } else {
                              Get.to(() => LoginScreen());
                            }
                          },
                          icon: Icon(
                            (service.isFavorite.value)
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: constants.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    service.name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: constants.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    service.agency.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: constants.primaryColor,
                    ),
                  ),
                  Visibility(
                    visible: service.agency.ministry.ministryName != null ? true : false,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        service.agency.ministry.ministryName ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: constants.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    service.agency.department.departmentName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: constants.primaryColor,
                    ),
                  ),
                ],
              ),
          ),
          ),
        ),
      );
    }
  }
