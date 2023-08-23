
import 'package:flutter/material.dart';
import 'package:flutterbase/components/icon_search_input.dart';
import 'package:flutterbase/components/loading_blocker.dart';
import 'package:flutterbase/controller/favorite_controller.dart';
import 'package:flutterbase/screens/services/bayaran_tanpa_bill.dart';
import 'package:flutterbase/screens/services/bayaran_tanpa_kadar.dart';
import 'package:flutterbase/screens/services/bill_detail.dart';
import 'package:flutterbase/screens/services/bayaran_tanpa_bill_dan_amaun.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatefulWidget {
  final String type;
  FavoritesScreen(this.type);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  final FavoriteController controller = favorites;

  @override
  initState() {
    controller.fetch(widget.type);
    super.initState();

    loadingBlocker.bind(controller.isLoading);
  }

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
            "Favorites Management".tr,
            style: styles.heading5,
          ),
        ),
        elevation: 0,
        actions: [
          IconSearchInput((term) {
            controller.filter(term);
          }),
        ],
      ),
      body:  Obx(() => controller.isLoading.value ? SizedBox() :
        ListView(
          children: [
            for(var item in controller.favorites)
              InkWell(child: Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black12))
                ),
                child: ListTile(
                  onTap: (){
                    if(item.bill != null) {
                      Get.to(() => BillDetailsScreen(), arguments: { 'id': item.bill!.id });
                    } else if (item.service != null) {
                      switch(item.service!.billTypeId) {
                        case 1:
                        case 2:
                          break;
                        case 3:
                          Get.to(() => BayaranTanpaBilServiceScreen(), arguments: {'id': item.serviceId });
                          break;
                        case 4:
                          Get.to(() => BayaranTanpaBillDanAmaunServiceScreen(), arguments: {'id': item.serviceId });
                          break;
                        case 5:
                          Get.to(() => BayaranTanpaKadarServiceScreen(), arguments: {'id': item.serviceId });
                          break;
                      }
                      // Get.to(() => BillDetailsScreen(), arguments: { 'id': item.bill!.id });
                    }
                  },
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(item.service?.name ?? item.bill?.detail ?? '', overflow: TextOverflow.ellipsis, maxLines: 2,),
                  ),
                  subtitle: Text(item.secondaryLine, overflow: TextOverflow.ellipsis, maxLines: 1,),
                  trailing: IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: (){
                      controller.removeFavorite(billId : item.billId, serviceId: item.serviceId, context: context);
                    },
                    color: constants.primaryColor,
                    icon: Icon(Icons.favorite),
                  ),
                ),
              )),
            Container(
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
            )
          ],
        ),
      ),
    );
  }
}