import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/controller/bottom_bar_controller.dart';
import 'package:flutterbase/models/cart/cart.dart';
import 'package:get/get.dart';

import '../../models/bills/bills.dart';
// import '../home_controller.dart';

class BayaranTanpaBillController extends GetxController {
  RxBool isLoading = true.obs;

  // ragu
  RxList<List<MatrixFilter>> filters = <List<MatrixFilter>>[].obs;
  RxList<String> items = <String>[].obs;

  late Services service;
  final BottomBarController barController;
  RxList<Product> products = <Product>[].obs;
  RxList<Matrix> matrixes = <Matrix>[].obs;
  Map<int, ProductController> productControllers = {};
  Map<int, DailyQuotaController> quotaControllers = {};
  BayaranTanpaBillController(this.barController);
  RxBool isEditingExtraField = true.obs;

  // kalau tak isi penuh takleh + - product
  RxBool isValid = true.obs;

  onInit() async {
    ErrorResponse response = await api.getServiceDetail(Get.arguments['id'].toString());
    service = Services.fromJson(response.data);
    await setupMatrix(service.id);

    super.onInit();
    isLoading.value = false;
  }

  setupMatrix(int id) async {
    ErrorResponse response = await api.getServiceMatrix(serviceId: id.toString());
    // print(response.message);
    // print("Matrix: ${jsonEncode(response.data)}");
    Map raw = response.data ?? {};
    if (raw.isEmpty) {
      return;
    }
    products.value = service.matrix!.products;
    List<List<MatrixFilter>> regularList = service.matrix!.filters;
    RxList<List<MatrixFilter>> reactiveList = regularList.obs;
    filters.value = reactiveList;

    CartEntry? entry = Get.arguments['cartEntry'];
    if(entry != null) {
      for(var field in entry.extraFields) {
        for(var serviceField in service.extraFields) {
          if(serviceField.source == field.source) {
            if(field.type == 'date') {
              var value = field.value.value;
              if(value.contains('/')) {
                value = value.split('/').reversed.join('-');
              }
              serviceField.value = Rx(DateTime.tryParse(value) ?? DateTime.now());
            } else {
              serviceField.value = RxString(field.value.value);
            }
          }
        }
      }
    }

    barController.add('', 0, serviceId: service.id, items: cartStructure());
    checkValidity();

    Future.delayed(Duration(milliseconds: 500)).then((_) {
      if(entry != null) {
        for(var item in entry.items) {
          if(productControllers[item.id] != null) {
            productControllers[item.id]!.setQuantity(item.quantity.value);
          }
        }
        this.isEditingExtraField.value = false;
        barController.setUpdatingCartId(entry.id);
      }
    });
  }

  void filterCheckboxProducts(param0) {}

  void applyFilter(String value) {}

  void removeItem(int index) {}

  void setDate(DateTime date) {
    for(var item in quotaControllers.keys) {
      quotaControllers[item]!.setDate(date);
    }
  }

  void quantityChanged() {
    checkValidity();
    var data = cartStructure();
    double amount = 0;
    for(var item in data['items']) {
      amount = amount + (item['amount'] as double);
    }
    if(isValid.value) {
      barController.change(amount, serviceId: service.id, newItems: data);
    }
  }

  void checkValidity() {
    bool isValid = true;
    var data = cartStructure();
    for(var item in data['extra_fields']) {
      if((item['value'] as String).isEmpty) {
        isValid = false;
      }
    }
    this.isValid.value = isValid;
  }

  Map<String, dynamic> cartStructure() {
    Map<String, dynamic> structure = {
      "items": <Map<String, dynamic>>[],
      "extra_fields": <Map<String, dynamic>>[],
    };

    for(var key in productControllers.keys) {
      var _controller = productControllers[key]!;
      if(_controller.quantity > 0) {
        structure['items'].add({
          'id': _controller.product.id,
          'quantity': _controller.quantity,
          'ppu': _controller.product.price,
          'unit': _controller.product.unit,
          'amount': _controller.product.price * _controller.quantity,
        });
      }
    }

    for(var item in service.extraFields) {
      structure['extra_fields'].add({
        'source': item.source,
        'placeholder': item.placeholder,
        'type': item.type,
        'value': item.dbValue,
      });
    }

    return structure;
  }
}

class DailyQuotaController {
  int quotaGroup = 0;
  RxInt quota = 0.obs;
  Map<int, RxInt> quantities = <int, RxInt>{}.obs;
  int get remainaing => quota.value - quantities.values.fold<int>(0, (prev, elem) => prev + elem.value);

  setDate(DateTime date) async {
    var response = await api.getDailyQuota(quotaGroup.toString(), date);
    if(response.isSuccessful && response.data.runtimeType != bool) {
      quota.value = response.data['remaining'];
    }
  }
}

class ProductController extends GetxController {
  final Product product;
  late DailyQuotaController quotaController;
  late BayaranTanpaBillController btbController;
  int remainingStock = 0;
  int get quantity => quotaController.quantities[product.id]!.value;

  ProductController(this.product, this.btbController) {
    quotaController = Get.put(DailyQuotaController(), tag: product.quotaGroup.toString());
    quotaController.quantities[product.id] = RxInt(0);
    quotaController.quotaGroup = product.quotaGroup;
    quotaController.quota.value = product.dailyQuota;
    remainingStock = product.stock;
  }

  void add() {
    if(!quotaController.quantities.containsKey(product.id)) {
      quotaController.quantities[product.id] = 0.obs;
    }
    quotaController.quantities[product.id]!.value = quotaController.quantities[product.id]!.value + 1;
    btbController.quantityChanged();
  }

  void deduct() {
    if(!quotaController.quantities.containsKey(product.id)) {
      quotaController.quantities[product.id] = 0.obs;
    }
    quotaController.quantities[product.id]!.value = quotaController.quantities[product.id]!.value - 1;
    btbController.quantityChanged();
  }

  void setQuantity(int qty) {
    if(!quotaController.quantities.containsKey(product.id)) {
      quotaController.quantities[product.id] = 0.obs;
    }
    if(quotaController.remainaing < qty) {
      qty = quotaController.remainaing;
    }
    quotaController.quantities[product.id]!.value = qty;
    btbController.quantityChanged();
  }

  bool get canDeduct => quantity > 0;

  bool get canAdd {
    if(product.checkStock && quantity == remainingStock) {
      return false;
    }

    if(product.checkQuota && quotaController.remainaing == 0) {
      return false;
    }

    return true;
  }
}