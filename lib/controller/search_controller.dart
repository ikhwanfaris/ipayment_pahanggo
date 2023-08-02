import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/contents/service.dart';
import 'package:get/get.dart';


class SearchType {
  String title;
  List<SearchCategory> categories;
  SearchType(this.title, this.categories);
}

class SearchCategory {
  String searchType;
  String title;
  List<SearchItem> items;
  SearchCategory(this.searchType, this.title, this.items);
}

class SearchItem {
  int id;
  String searchType;
  String searchCategory;
  String title;
  String subtitle;
  String icon;
  int billTypeId;
  int serviceId;
  String serviceCode;
  String? trailing;

  SearchItem(this.searchType, this.searchCategory, this.id, this.title, this.serviceId, this.serviceCode, this.subtitle, this.icon, this.billTypeId, {this.trailing});
}


class SearchController extends GetxController {
  final TextEditingController searchText = TextEditingController();

  // RxList<SearchService> results = <SearchService>[].obs;
  // RxList<SearchService> showResults = <SearchService>[].obs;
  // RxList<ServiceModel> results = <ServiceModel>[].obs;
  RxList<ServiceModel> showResults = <ServiceModel>[].obs;
  RxList<SearchType> results = <SearchType>[].obs;
  // RxList<Menu> types = <Menu>[].obs;
  RxString controllerText = ''.obs;
  RxBool isLoading = false.obs;
  // RxList<DropdownMenuItem<Menu>> menus = <DropdownMenuItem<Menu>>[].obs;
  // Rx<Menu> selectedMenu = Menu(id: 0, menuTitle: "menuTitle").obs;
  RxList<DropdownMenuItem<String>> menus = <DropdownMenuItem<String>>[].obs;
  RxString selectedMenu = "".obs;

  @override
  void onInit() async {
    super.onInit();
    // initSearch();
    searchService();
  }

  onServiceChange(String? menu) {
    selectedMenu.value = menu!;
    // showResults.value = results.where((p0) => p0.menu!.name == menu).toList();
  }

  searchService() {
    searchText.addListener(() {
      controllerText.value = searchText.text;
    });

    debounce(controllerText, (value) async {
      if(searchText.text.length > 3) {
        doSearch();
      } else {
        results.value = [];
        isLoading(false);
      }
    }, time: .5.seconds);
  }

  doSearch() async {
      ErrorResponse response = await api.searchService(controllerText.value);
      isLoading(false);
      if(!response.isSuccessful) return;

      results.value = [];
      if (response.isSuccessful) {
        if (response.data.runtimeType != List) {
          var data = response.data as Map<String, dynamic>;
          List<SearchType> _results = [];
          if(data.containsKey('services') && !(data['services'] is List)) {
            var searchType = SearchType('Services'.tr, []);
            for(var category in data['services'].keys) {
              var searchCategory = SearchCategory('service', category, []);
              for(var service in data['services'][category]) {
                searchCategory.items.add(SearchItem(
                  'service',
                  category,
                  service['id'],
                  service['name'],
                  service['id'],
                  service['service_reference_number'],
                  service['agency']['name'],
                  'icon',
                  int.parse(service['bill_type_id'].toString()),
                ));
              }
              searchType.categories.add(searchCategory);
            }
            _results.add(searchType);
          }
          if(data.containsKey('products') && !(data['products'] is List)) {
            var searchType = SearchType('Products'.tr, []);
            for(var category in data['products'].keys) {
              var searchCategory = SearchCategory('product', category, []);
              for(var product in data['products'][category]) {
                searchCategory.items.add(SearchItem(
                  'product',
                  category,
                  product['id'],
                  product['details'],
                  int.parse(product['service_id'].toString()),
                  product['service_reference_number'],
                  product['service'],
                  'icon',
                  int.parse(product['bill_type_id'].toString()),
                  trailing: product['agency'],
                ));
              }
              searchType.categories.add(searchCategory);
            }
            _results.add(searchType);
          }
          if(data.containsKey('payables') && !(data['payables'] is List)) {
            var searchType = SearchType('Items'.tr, []);
            for(var category in data['payables'].keys) {
              var searchCategory = SearchCategory('item', category, []);
              for(var payable in data['payables'][category]) {
                searchCategory.items.add(SearchItem(
                  'item',
                  category,
                  payable['id'],
                  payable['details'],
                  int.parse(payable['service_id'].toString()),
                  payable['service_reference_number'],
                  payable['agency'],
                  'icon',
                  int.parse(payable['bill_type_id'].toString()),
                  trailing: payable['ip_ref'],
                ));
              }
              searchType.categories.add(searchCategory);
            }
            _results.add(searchType);
          }

          results.value = _results;
          // headers.value = _headers;
          // (response.data as Map<String, dynamic>).entries.forEach(
          //   (element) {
          //     print(element);
          //     results.value = (element.value as List<dynamic>)
          //         .map((e) => ServiceModel.fromJson(e))
          //         .toList();
          //     showResults.value = (element.value as List<dynamic>)
          //         .map((e) => ServiceModel.fromJson(e))
          //         .toList();
          //   },
          // );
          // menus.value = (response.data as Map<String, dynamic>)
          //     .entries
          //     .map((e) => DropdownMenuItem<String>(
          //           child: Text(e.key),
          //           value: e.key,
          //         ))
          //     .toList();
        }

        // List<dynamic> parsed = response.data as List<dynamic>;
        // results.value = parsed.map((e) => SearchService.fromJson(e)).toList();
        // showResults.value =
        //     parsed.map((e) => SearchService.fromJson(e)).toList();
        // List<Menu> _menus = results.map((element) => element.menu).toList();
        // Map<String, Menu> mp = {};
        // for (var item in _menus) {
        //   mp[item.menuTitle] = item;
        // }
        // menus.value = mp.values
        //     .toList()
        //     .map((e) =>
        //         DropdownMenuItem<Menu>(child: Text(e.menuTitle), value: e))
        //     .toList();
        // selectedMenu.value = Menu(id: 0, menuTitle: "menuTitle");
      } else {
        print(response.message);
      }
  }
}
