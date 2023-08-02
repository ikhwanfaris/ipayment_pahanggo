import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/controller/service_controller.dart';
import 'package:flutterbase/models/contents/service.dart';
import 'package:flutterbase/screens/content/home/bill/bill.dart';

import 'package:flutterbase/screens/content/home/bill/bayaran_tanpa_bill.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import 'bill/bayaran_tanpa_bill_dan_amaun.dart';
import 'menu.dart';

class ServicePage extends StatelessWidget {
  final controller = Get.put(ServiceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: AppBar(
        backgroundColor: Color(0xFFf9f9f9),
        iconTheme: IconThemeData(
          color: constants.primaryColor,
        ),
        title: Center(
            child: Text(
          "Senarai Servis",
          style: styles.heading5,
        )),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => MenuScreen()),
            icon: Icon(LineIcons.times),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Obx(
                () => Text(
                  controller.subMenuTitle.value,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Senarai Servis",
                style: styles.heading14sub,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              height: 50,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: styles.inputDecoration.copyWith(
                  labelText: 'Carian',
                  prefixIcon: LineIcon(Icons.search),
                ),
              ),
            ),
            Obx(
              () {
                if (!controller.isLoading.value) {
                  List<Widget> children = [];
                  for (var i = 0; i < controller.services.length; i = i + 2) {
                    children.add(
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            ServiceBox(
                              isFavorite: controller.services[i].favorite.obs,
                              serviceRefNum: controller
                                  .services[i].serviceReferenceNumber,
                              serviceName: controller.services[i].name!,
                              agencyName: controller.services[i].agency.name,
                              onPressed: () => controller.favourite(
                                  controller.services[i].id.toString()),
                            ),
                            (i + 1 < controller.services.length)
                                ? ServiceBox(
                                    isFavorite:
                                        controller.services[i + 1].favorite.obs,
                                    onPressed: () => controller.favourite(
                                        controller.services[i + 1].id
                                            .toString()),
                                    serviceRefNum: controller.services[i + 1]
                                        .serviceReferenceNumber,
                                    serviceName:
                                        controller.services[i + 1].name!,
                                    agencyName:
                                        controller.services[i + 1].agency.name,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    );
                    children
                        .add(Divider(color: Colors.transparent, height: 30));
                  }

                  return Column(
                    children: children,
                  );
                } else {
                  return Center(
                      child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 1.7),
                    child: DefaultLoadingBar(),
                  ));
                }
              },
            )
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
    return GestureDetector(
      onTap: () async {
        ErrorResponse response = await api.getServiceDetail(serviceRefNum);
        ServiceModel data = ServiceModel.fromJson(response.data);
        log(jsonEncode(data));
        log(data.billTypeId.toString());
        log(data.billType!.type);
        switch (data.billTypeId) {
          case 1:
            Get.to(() => Bill(), arguments: serviceRefNum);
            break;
          case 2:
            Get.to(() => TanpaBillAmount(), arguments: serviceRefNum);
            break;
          case 3:
            Get.to(() => BayaranTanpaBill(), arguments: serviceRefNum);
            break;
          case 4:
            break;
          case 5:
            break;
          default:
        }
      },
      child: Container(
        width: Get.width * 0.42,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.person_outline),
                Obx(
                  () => IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      isFavorite.value = !isFavorite.value;
                      onPressed();
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
    );
  }
}

class ServiceTile extends StatelessWidget {
  const ServiceTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.43,
      height: Get.height * 0.15,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          boxShadow: kElevationToShadow[4],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Positioned(
            right: 10,
            top: 10,
            child: Image.asset(
              'assets/dist/question-mark.png',
              scale: 20,
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: CircleAvatar(
              backgroundColor: constants.secondaryColor,
              child: Text("CJ"),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ipoh",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Padding(padding: const EdgeInsets.only(bottom: 5)),
                Text(
                  "Yuran pembayaran",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
