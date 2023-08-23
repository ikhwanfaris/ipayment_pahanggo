import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:get/get.dart';

class BayaranTanpaKadarController extends GetxController {
  List<Bill> _bills = <Bill>[];
  RxList<Bill> bills = <Bill>[].obs;
  Services? service;
  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    String id = Get.arguments['id'].toString();
    ErrorResponse response = await api.getServiceDetail(id);
    service = Services.fromJson(response.data);
    _bills = await api.getBillByService(serviceId: service!.id.toString());
    filter('');
    isLoading.value = false;
    super.onInit();
  }

  filter(String term) {
    bills.clear();
    for(var item in _bills) {
      if(term.isEmpty) {
        bills.add(item);
      } else if(item.contains(term)) {
        bills.add(item);
      }
    }
  }
}