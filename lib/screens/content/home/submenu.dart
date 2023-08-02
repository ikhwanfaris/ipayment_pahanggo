import 'dart:developer' as log;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/controller/submenu_controller.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/contents/menu.dart';
import 'package:flutterbase/models/contents/service.dart';
import 'package:flutterbase/screens/auth/login.dart';
import 'package:flutterbase/screens/content/home/bill/bill.dart';
import 'package:flutterbase/screens/content/home/bill/bayaran_tanpa_bill.dart';
import 'package:flutterbase/screens/content/home/bill/bayaran_tanpa_bill_dan_amaun.dart';
import 'package:flutterbase/screens/content/home/menu.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../../components/appbar_header.dart';

class SubmenuScreen extends StatelessWidget {
  final controller =
      Get.put(SubmenuController(), tag: Random().nextInt(100).toString());

  Size get preferredSize => AppBar().preferredSize;

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
            Stack(
              children: [
                Material(
                  color: constants.primaryColor,
                  shape: MyShapeBorder(-20),
                  child: Container(
                    height: 20,
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 0,
                  child: SizedBox(
                    height: AppBar().preferredSize.height,
                    width: MediaQuery.of(context).size.width,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [],
                    ),
                  ),
                )
              ],
            ),
            MenuTitle(controller: controller),
            MenuSearchBar(),
            Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width / 1.7),
                        child: DefaultLoadingBar(),
                      ),
                    )
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
                ? Divider(indent: 20, endIndent: 20, thickness: 2)
                : Container(),
            Obx(
              () {
                List<Widget> children = [];
                for (var i = 0; i < controller.services.length; i = i + 2) {
                  children.addAll([
                    ServiceWidget(controller: controller, i: i),
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
  const ServiceWidget({
    Key? key,
    required this.controller,
    required this.i,
  }) : super(key: key);

  final SubmenuController controller;
  final int i;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ServiceBox(
            isFavorite: controller.services[i].favorite.obs,
            serviceRefNum: controller.services[i].serviceReferenceNumber,
            serviceName: controller.services[i].name ?? "-",
            agencyName: controller.services[i].agency.name,
            onPressed: () =>
                controller.favourite(controller.services[i].id.toString()),
          ),
          (i + 1 < controller.services.length)
              ? ServiceBox(
                  isFavorite: controller.services[i + 1].favorite.obs,
                  onPressed: () => controller
                      .favourite(controller.services[i + 1].id.toString()),
                  serviceRefNum:
                      controller.services[i + 1].serviceReferenceNumber,
                  serviceName: controller.services[i + 1].name ?? "-",
                  agencyName: controller.services[i + 1].agency.name,
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
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => Get.to(() => SubmenuScreen(),
          arguments: item, preventDuplicates: false),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/dist/submenu_icon.png',
              width: 65,
              height: 65,
            ),
            const SizedBox(height: 8),
            Text(
              item.name ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff333333),
                  overflow: TextOverflow.ellipsis),
                  maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class MenuSearchBar extends StatelessWidget {
  const MenuSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Row(
          children: [
            Expanded(
              flex: 11,
              child: SizedBox(
                height: 30,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  decoration: styles.inputDecoration.copyWith(
                    labelText: 'Search...'.tr,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                    decoration: BoxDecoration(
                      color: constants.fiveColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(getIcon('magnifying-glass'),
                          color: Colors.white, size: 20),
                    )),
              ),
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
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Obx(
                () => Text(
                  controller.title.value,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "List of @service"
                    .trParams({"service": controller.title.value}),
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceBox extends StatelessWidget {
  const ServiceBox({
    Key? key,
    required this.serviceName,
    required this.agencyName,
    required this.serviceRefNum,
    required this.onPressed,
    required this.isFavorite,
  }) : super(key: key);

  final String serviceRefNum;
  final String serviceName;
  final String agencyName;
  final RxBool isFavorite;
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
            ErrorResponse response = await api.getServiceDetail(serviceRefNum);
            ServiceModel data = ServiceModel.fromJson(response.data);
            log.log("Bill Type ID: ${data.billTypeId}", name: "Submenu");
            switch (data.billTypeId) {
              case 1:
                Get.to(() => Bill(), arguments: {
                  "serviceRefNum": serviceRefNum,
                  "amountRequired": false
                });
                break;
              case 2:
                Get.to(() => Bill(), arguments: {
                  "serviceRefNum": serviceRefNum,
                  "amountRequired": true
                });
                break;
              case 3:
                Get.to(() => BayaranTanpaBill(), arguments: {
                  "serviceRefNum": serviceRefNum,
                  "serviceId": data.id,
                  "billType": data.billTypeId,
                });
                break;
              case 4:
                Get.to(() => TanpaBillAmount(), arguments: {
                  "serviceRefNum": serviceRefNum,
                  "agencyName": agencyName,
                });
                break;
              case 5:
                Get.to(() => BayaranTanpaBill(), arguments: {
                  "serviceRefNum": serviceRefNum,
                  "serviceId": data.id,
                  "billType": data.billTypeId,
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
                              isFavorite.value = !isFavorite.value;
                              onPressed();
                            } else {
                              Get.to(() => LoginScreen());
                            }
                          },
                          icon: Icon(
                            (isFavorite.value)
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: constants.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    serviceName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: constants.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(bottom: 10)),
                  Text(
                    agencyName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: constants.primaryColor,
                    ),
                  )
                ],
              ),
          ),
          ),
        ),
      );
    }
  }
