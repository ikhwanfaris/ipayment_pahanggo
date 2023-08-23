

import 'package:flutter/material.dart';
import 'package:flutterbase/controller/bottom_bar_controller.dart';
import 'package:flutterbase/models/cart/cart.dart';
import 'package:get/get.dart';

class BayaranBagiPihakForm extends StatefulWidget {
  final BottomBarController bottomBarController;

  BayaranBagiPihakForm(this.bottomBarController);

  @override
  State<BayaranBagiPihakForm> createState() => _BayaranBagiPihakFormState();
}

class _BayaranBagiPihakFormState extends State<BayaranBagiPihakForm> {
  final RxBool bagiPihak = false.obs;

  final _formKey = GlobalKey<FormState>();

  // we store here because the customer details in
  // bottom bar is reset when checkbox is unticked
  String name = '';
  String email = '';
  String phone = '';

  @override
  initState() {
    super.initState();
    setValidator();
  }

  void setValidator() {
    widget.bottomBarController.setValidator(() {
      if(bagiPihak.value && (
        name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty
      )) {
        return "Please complete the Payment on Behalf section.".tr;
      }
      return null;
    });
  }

  void unsetValidator() {
    widget.bottomBarController.setValidator(null);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: const Color.fromARGB(14, 0, 0, 0),
          child: Row(
            children: [
              Checkbox(
                value: bagiPihak.value,
                onChanged: (v) {
                  bagiPihak.value = v!;
                  if(!v) {
                    widget.bottomBarController.setCustomer(CartCustomerDetails());
                    unsetValidator();
                  } else {
                    setValidator();
                    widget.bottomBarController.customer.name = name;
                    widget.bottomBarController.customer.email = email;
                    widget.bottomBarController.customer.phone = phone;
                  }
                },
              ),
              Text('Payment on Behalf'.tr, style: TextStyle(fontWeight: FontWeight.bold,),),
            ],
          ),
        ),
        if(bagiPihak.value)
          Container(
            padding: EdgeInsets.all(16),
            color: const Color.fromARGB(14, 0, 0, 0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: name,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      label: Text('Name'.tr),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if(value == null || value.isEmpty) return "The Name field is required".tr;
                      return null;
                    },
                    onChanged: (v) {
                      setState(() {
                        name = v;
                      });
                      widget.bottomBarController.customer.name = v;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    initialValue: email,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      label: Text('E-mail'.tr),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if(value == null || value.isEmpty) return "The E-mail field is required".tr;
                      return null;
                    },
                    onChanged: (v) {
                      setState(() {
                        email = v;
                      });
                      widget.bottomBarController.customer.email = v;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    initialValue: phone,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      label: Text('Phone Number'.tr),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if(value == null || value.isEmpty) return "The Phone Number field is required".tr;
                      return null;
                    },
                    onChanged: (v) {
                      setState(() {
                        phone = v;
                      });
                      widget.bottomBarController.customer.phone = v;
                    },
                  ),
                ],
              ),
            ),
          ),
      ],
    ));
  }
}