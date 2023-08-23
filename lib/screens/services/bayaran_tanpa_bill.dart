import 'package:flutter/material.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/components/bayaran_tanpa_bil/tile.dart';
import 'package:flutterbase/components/bottom_bar.dart';
import 'package:flutterbase/components/loading_blocker.dart';
import 'package:flutterbase/controller/bill/bayaran_tanpa_bill_controller.dart';
import 'package:flutterbase/controller/bottom_bar_controller.dart';
import 'package:flutterbase/controller/favorite_controller.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

// ignore: must_be_immutable
class BayaranTanpaBilServiceScreen extends StatefulWidget {
  late final BayaranTanpaBillController controller;

  BayaranTanpaBilServiceScreen() {
    controller = Get.put(BayaranTanpaBillController(BottomBarController(false)));
  }

  @override
  State<BayaranTanpaBilServiceScreen> createState() => _BayaranTanpaBilServiceScreenState();
}

class _BayaranTanpaBilServiceScreenState extends State<BayaranTanpaBilServiceScreen> {

  @override
  initState() {
    loadingBlocker.bind(widget.controller.isLoading);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Center(
          child: Center(
            child: Obx(() => widget.controller.isLoading.value
                ? SizedBox()
                : Text(
                    widget.controller.service.name!,
                    style: styles.heading4,
                    maxLines: 2,
                  )),
          ),
        ),
        actions: [
          Obx(() => widget.controller.isLoading.value
              ? SizedBox(width: 48)
              : IconButton(
                  onPressed: () async {
                    widget.controller.service.isFavorite.value = !widget.controller.service.isFavorite.value;
                    if (widget.controller.service.isFavorite.value) {
                      await favorites.addFavorite(serviceId: widget.controller.service.id, context: context);
                    } else {
                      await favorites.removeFavorite(serviceId: widget.controller.service.id, context: context);
                    }
                  },
                  icon: widget.controller.service.isFavorite.value ? Icon(Icons.favorite) : Icon(LineIcons.heart),
                )),
        ],
        shape: const MyShapeBorder(-10.0),
        toolbarHeight: 95,
      ),
      // endDrawer: Obx(() => controller.isLoading.value ? SizedBox() : BTBFilter(controller: controller)),
      body: Obx(() => widget.controller.isLoading.value
          ? SizedBox()
          : Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: SafeArea(
                child: ListView(
                  children: [
                    if(widget.controller.service.extraFields.isNotEmpty)
                      ExtraFieldsForm(widget.controller),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(16),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemCount: widget.controller.products.length,
                      itemBuilder: (_, index) => ProductTile(
                        widget.controller,
                        widget.controller.products[index],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      bottomNavigationBar: BottomBar(widget.controller.barController),
    );
  }
}

class ExtraFieldsForm extends StatefulWidget {
  final BayaranTanpaBillController controller;
  ExtraFieldsForm(this.controller);

  @override
  State<ExtraFieldsForm> createState() => _ExtraFieldsFormState();
}

class _ExtraFieldsFormState extends State<ExtraFieldsForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, TextEditingController> editingControllers = {};

  @override
  void initState() {
    for(var item in widget.controller.service.extraFields) {
      if(item.type == 'date') {
        editingControllers[item.source!] = TextEditingController(text: item.display);
      }
    }
    super.initState();

    debounce(widget.controller.isEditingExtraField, (callback) {
      widget.controller.quantityChanged();
    });

    Future.delayed(Duration(milliseconds: 1)).then((_) {
      setState(() {});
      _formKey.currentState?.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var item in widget.controller.service.extraFields)
                        Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(item.source ?? '-', style: TextStyle(color: constants.primaryColor, fontWeight: FontWeight.bold),),
                                Text(' *', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                              ],
                            ),
                            SizedBox(height: 6),
                            if(!widget.controller.isEditingExtraField.value)
                              Text(item.display),
                            if(widget.controller.isEditingExtraField.value && item.value.runtimeType == RxString)
                              TextFormField(
                                initialValue: (item.value as RxString).value,
                                autocorrect: false,
                                enableSuggestions: false,
                                minLines: 1,
                                maxLines: item.type == 'textarea' ? 4 : 1,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                                validator: (value) {
                                  if(value == null || value.isEmpty) return item.placeholder ?? 'This field is required'.tr;
                                  return null;
                                },
                                onChanged: (v) {
                                  (item.value as RxString).value = v;
                                  setState(() {});
                                },
                              ),
                            if(widget.controller.isEditingExtraField.value && item.value.runtimeType == Rx<DateTime>)
                              InkWell(
                                onTap: () async {
                                  var date = await showDatePicker(
                                    context: context,
                                    initialDate: (item.value as Rx<DateTime>).value,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(Duration(days: 365)),
                                    locale: Get.locale?.languageCode == 'en'
                                        ? Locale("en")
                                        : Locale("ms"),
                                  );

                                  if(date != null) {
                                    (item.value as Rx<DateTime>).value = date;
                                  }

                                  editingControllers[item.source]!.text = item.display;

                                  if(editingControllers.keys.first == item.source && date != null) {
                                    widget.controller.setDate(date);
                                  }
                                },
                                child: TextFormField(
                                  enabled: false,
                                  controller: editingControllers[item.source],
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black45)),
                                    suffixIcon: Icon(getIcon('calendar')),
                                  ),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            SizedBox(height: 8),
                          ],
                        )),
                        if(widget.controller.isEditingExtraField.value)
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              color: constants.primaryColor,
                              onPressed: _formKey.currentState?.validate() ?? false ? () {
                                widget.controller.isEditingExtraField.value = !widget.controller.isEditingExtraField.value;
                              } : null, icon: Icon(LineIcons.check,)
                            ),
                          ),
                    ],
                  ),
                ),
              ),
              if(!widget.controller.isEditingExtraField.value)
                IconButton(
                  color: constants.primaryColor,
                  onPressed: () {
                    widget.controller.isEditingExtraField.value = !widget.controller.isEditingExtraField.value;
                    Future.delayed(Duration(milliseconds: 1)).then((_) {
                      setState(() {});
                      _formKey.currentState?.validate();
                    });
                  }, icon: Icon(LineIcons.edit,)
                ),
            ],
          ),
        ),
      ),
    ));
  }
}
