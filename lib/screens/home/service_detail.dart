import 'package:flutter/material.dart';
import 'package:flutterbase/controller/service_detail_controller.dart';
import 'package:flutterbase/screens/home/menu.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ServiceDetail extends StatelessWidget {
  final controller = Get.put(ServiceDetailController());
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
            "Perinician Perkhidmatan",
            style: styles.heading5,
          ),
        ),
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
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              // elevation: 10,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                side: BorderSide(width: 1, color: Colors.black26),
              ),
              color: constants.paleWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return ListTile(
                      title: Text(
                        "Kod Agensi",
                        style: styles.heading12bold,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                        child: Text(
                          controller.codeAgency.value,
                          style: styles.heading12sub,
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return ListTile(
                      title: Text(
                        "Kod Perkhidmatan",
                        style: styles.heading12bold,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                        child: Text(
                          controller.codeService.value,
                          style: styles.heading12sub,
                        ),
                      ),
                    );
                  }),
                  // ListTile(
                  //   title: Text(
                  //     "Produk Servis",
                  //     style: styles.heading12bold,
                  //   ),
                  //   subtitle: Padding(
                  //     padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                  //     child: Text(
                  //       "",
                  //       style: styles.heading12sub,
                  //     ),
                  //   ),
                  // ),
                  // ListTile(
                  //   title: Text(
                  //     "Kadar Perkhidmatan (mengikut ketetapan di MSP)",
                  //     style: styles.heading12bold,
                  //   ),
                  //   subtitle: Padding(
                  //     padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                  //     child: Text(
                  //       controller.service?.serviceChargeData ?? "",
                  //       style: styles.heading12sub,
                  //     ),
                  //   ),
                  // ),
                  Obx(() {
                    return ListTile(
                      title: Text(
                        "Nama Perkhidmatan",
                        style: styles.heading12bold,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                        child: Text(
                          controller.nameService.value,
                          style: styles.heading12sub,
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return ListTile(
                      title: Text(
                        "Jenis Perkhidmatan",
                        style: styles.heading12bold,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                        child: Text(
                          controller.typeService.value,
                          style: styles.heading12sub,
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return ListTile(
                      title: Text(
                        "No Rujukan Perkhidmatan ",
                        style: styles.heading12bold,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                        child: Text(
                          controller.refNoService.value,
                          style: styles.heading12sub,
                        ),
                      ),
                    );
                  }),
                  // ListTile(
                  //   title: Text(
                  //     "Kumpulan PTJ dan PTJ Menyedia",
                  //     style: styles.heading12bold,
                  //   ),
                  //   subtitle: Padding(
                  //     padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                  //     child: Text(
                  //       "controller/",
                  //       style: styles.heading12sub,
                  //     ),
                  //   ),
                  // ),
                  // ListTile(
                  //   title: Text(
                  //     "Pihak Tanggung Caj",
                  //     style: styles.heading12bold,
                  //   ),
                  //   subtitle: Padding(
                  //     padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                  //     child: Text(
                  //       controller.bill?.service.chargedTo ?? "-",
                  //       style: styles.heading12sub,
                  //     ),
                  //   ),
                  // ),
                  // controller.bill?.service.chargedTo == "Pelanggan"
                  //     ? ListTile(
                  //         leading: Icon(Icons.info),
                  //         title: Text(
                  //           "Bayaran ini dikenakan caj transaksi yang perlu ditanggung oleh pelanggan.",
                  //           style: styles.heading12bold,
                  //         ),
                  //       )
                  //     : Container(),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
