import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/components/bill_item.dart';
import 'package:flutterbase/components/bottom_bar.dart';
import 'package:flutterbase/components/loading_blocker.dart';
import 'package:flutterbase/components/page_title.dart';
import 'package:flutterbase/controller/bottom_bar_controller.dart';
import 'package:flutterbase/language/pull_to_refresh.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../utils/constants.dart';

class BillsScreen extends StatefulWidget {
  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  final BillScreenController controller = BillScreenController();
  final RefreshController refreshController = RefreshController();
  final BottomBarController bottomBarController = BottomBarController(true);

  initState() {
    loadingBlocker.bind(controller.isLoading);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconTheme.of(context).copyWith(
            color: Colors.white,
          ),
          shape: const MyShapeBorder(-20),
        ),
        body: Obx(() => Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: PageTitle('List of Bills'.tr),
                    ),
                    InkWell(
                      onTap: (){
                        controller.searchShown.value = !controller.searchShown.value;
                      },
                      child: Icon(controller.searchShown.value ? getIcon('x') : getIcon('magnifying-glass'), color: controller.searchShown.value ? Colors.black : Colors.black26,),
                    ),
                  ],
                ),
              ),
              if(controller.searchShown.value) Column(
                children: [
                  SearchField((search) {
                    controller.searchValue.value = search;
                  }),
                  Row(
                    children: [
                      Checkbox(value: controller.searchType.value, onChanged: (v) {
                        if(v!) {
                          controller.searchType.value = true;
                        } else {
                          controller.searchType.value = false;
                        }
                      }),
                      Text('Individual'.tr + ' (${controller.individualCount.toString()})'),
                      Checkbox(value: !controller.searchType.value, onChanged: (v) {
                        if(v!) {
                          controller.searchType.value = false;
                        } else {
                          controller.searchType.value = true;
                        }
                      }),
                      Text('Organization'.tr + ' (${controller.organizationCount.toString()})'),
                    ],
                  )
                ],
              ),
              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: controller.page < controller.lastPage,
                  onRefresh: () async {
                    await controller.searchBills();
                    refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    await controller.nextPage();
                    refreshController.loadComplete();
                  },
                  header: MyWaterDropHeader(),
                  footer: MyClassicFooter(),
                  controller: refreshController,
                  child: ListView(
                    children: [
                      for(var bill in controller.bills)
                        BillItem(bottomBarController, bill),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
        bottomNavigationBar: BottomBar(bottomBarController),
      );
  }
}
class SearchField extends StatefulWidget {
  final Function(String search) onChanged;

  SearchField(this.onChanged);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  String _value = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: TextFormField(
        initialValue: _value,
        autocorrect: false,
        decoration: styles.inputDecoration.copyWith(
          labelText: 'Search'.tr,
          suffixIcon: IconButton(
            onPressed: null,
            icon: Icon(Icons.search, color: Colors.grey),
          ),
        ),
        onChanged: (v) {
          this.widget.onChanged(v);
          setState(() {
            _value = v;
          });
        },
      ),
    );
  }
}

class BillScreenController extends RxController {
  RxBool searchShown = RxBool(false);
  RxBool searchType = RxBool(true);
  RxString searchValue = RxString('');
  RxList<Bill> bills = RxList();
  RxBool isLoading = RxBool(false);
  int page = 1;
  int lastPage = 1;
  RxInt individualCount = 0.obs;
  RxInt organizationCount = 0.obs;

  BillScreenController() {
    searchBills();
    getCounts();

    debounce(searchValue, (callback) {
      searchBills();
    }, time: .5.seconds);
    debounce(searchType, (bool value) {
      searchBills();
    }, time: .5.seconds);
    debounce(searchShown, (callback) {
      if(!searchShown.value) {
        searchValue.value = '';
      }
    }, time: .5.seconds);
  }

  Future<void> nextPage() async {
    if(page >= lastPage) {
      return;
    }

    page = page + 1;

    var response = await api.getBills(
      page,
      searchValue.value,
      individuals: searchType.value,
      organizations: !searchType.value
    );

    if(response.isSuccessful) {
      onReceiveBills(response);
    }
  }

  Future<void> searchBills() async {
    isLoading.value = true;
    page = 1;
    lastPage = 1;
    bills.value = [];

    var response = await api.getBills(
      page,
      searchValue.value,
      individuals: searchType.value,
      organizations: !searchType.value
    );

    isLoading.value = false;
    bills.value = [];
    if(!response.isSuccessful) {
      return;
    }

    onReceiveBills(response);
  }

  void onReceiveBills(ErrorResponse response) {
    lastPage = response.data['last_page'];

    for(var item in response.data['data']) {
      bills.add(Bill.fromJson(item));
    }
  }

  Future getCounts() async {
    var response = await api.widgetMenu();

    individualCount.value = int.tryParse(response['bill_individual_count'].toString()) ?? 0;
    organizationCount.value = int.tryParse(response['bill_organisation_count'].toString()) ?? 0;
  }
}