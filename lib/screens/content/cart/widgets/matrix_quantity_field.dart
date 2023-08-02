import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/models.dart';
import 'package:flutterbase/screens/content/cart/cart.dart';
import 'package:flutterbase/screens/content/cart/cart_utils.dart';
import 'package:flutterbase/screens/content/cart/widgets/widgets.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MatrixQuantityField extends StatelessWidget {
  MatrixQuantityField({
    Key? key,
    required this.utils,
    required this.rootFieldName,
    required this.matrixQuantity,
    required this.initialValue,
    required this.onChanged,
    this.onRateChanged,
    this.enabled = true,
  }) : super(key: key) {
    amountFieldName = "$rootFieldName.amount";
    rateValueFieldName = "$rootFieldName.rate.value";
  }

  final CartItemUtils utils;
  final MatrixQuantity matrixQuantity;
  final String rootFieldName;
  final int initialValue;
  final bool enabled;
  final Function(int value) onChanged;
  final Function(String value)? onRateChanged;
  late String amountFieldName;
  late String rateValueFieldName;

  @override
  Widget build(BuildContext context) {
    var showStockTracking = matrixQuantity.hasStockTracking ?? false;
    var unitTitle = matrixQuantity.unit.getValue('');

    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment:
          enabled ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        /// Left Side
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Title
              Text(
                matrixQuantity.rate.getTitle(''),
                style: AppStyles().heading20,
              ),

              if (unitTitle.isNotEmpty || !enabled)
                SizedBox(height: AppStyles.u3),

              /// Subtitle
              if (unitTitle.isNotEmpty)
                SizedBox(
                  height: !utils.editableMatrixRate()
                      ? 36 -
                          ((matrixQuantity.hasStockTracking ?? false) ? 20 : 0)
                      : null,
                  child: Text(
                    unitTitle,
                    style: AppStyles().heading21,
                  ),
                ),

              if (showStockTracking && enabled)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: AppStyles.u2,
                    left: AppStyles.u1,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Stock balance: @stock'.trParams({
                          'stock':
                              (matrixQuantity.remainingStock ?? 0).toString(),
                        }),
                        style: AppStyles().heading21,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),

        /// Right Side
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Rate Value (RM)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    matrixQuantity.rate.getValue('', prefix: 'RM') +
                        (!enabled && !utils.editableMatrixRate()
                            ? ' x ' + matrixQuantity.amount.toString()
                            : ''),
                    style: AppStyles().heading20,
                  ),
                  if (utils.editableMatrixRate() && enabled)
                    EditAmountButton(
                      onChanged: (value) {
                        print("EditAmountButton");
                        submitRateValueChange(value);
                      },
                      initialValue:
                          double.parse(matrixQuantity.rate.value ?? '0'),
                    ),
                  if (!(utils.editableMatrixRate() && enabled))
                    SizedBox(
                      width: AppStyles.u4,
                    ),
                ],
              ),

              // Amount +/-
              if (enabled && !utils.editableMatrixRate())
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    QuantityAmountButton(
                      onPressed: increaseValue,
                      icon: Icon(Icons.add, color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: editAmount,
                      child: AbsorbPointer(
                        child: Container(
                          width: 40,
                          color: Colors.white,
                          child: FormBuilderTextField(
                            enabled: enabled,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            readOnly: true,
                            style: AppStyles().heading21,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                            ),
                            name: amountFieldName,
                            initialValue: "$initialValue",
                          ),
                        ),
                      ),
                    ),
                    QuantityAmountButton(
                      onPressed: decreaseValue,
                      icon: Icon(Icons.remove, color: Colors.white),
                    ),
                    SizedBox(
                      width: AppStyles.u4,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  void editAmount() {
    var oldValue = getOldValue();
    var tempValue = oldValue;

    showAppBottomsheet(
        ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: EdgeInsets.all(AppStyles.u2),
              child: TextFormField(
                initialValue: oldValue.toInt().toString(),
                autofocus: true,
                keyboardType: TextInputType.number,
                decoration: AppStyles.decoInputText,
                onChanged: (value) => tempValue = int.parse(value),
                onFieldSubmitted: (String value) {
                  onChanged(int.parse(value));
                  Navigator.of(getContext()).pop();
                },
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              submitChange(tempValue);
              FocusScope.of(getContext()).unfocus();
              Navigator.of(getContext()).pop();
            },
            child: Text('Save'.tr),
          ),
        ]);
  }

  int getOldValue() {
    if (cartFormKey.currentState == null) return 0;
    if (cartFormKey.currentState!.fields[amountFieldName] == null) return 0;

    return int.parse(cartFormKey.currentState!.fields[amountFieldName]!.value);
  }

  void increaseValue() {
    int oldValue = getOldValue();
    int newValue = oldValue + 1;

    submitChange(newValue);
  }

  void decreaseValue() {
    int oldValue = getOldValue();

    // Cannot decrease from zero
    if (oldValue == 0) {
      return;
    }

    int newValue = oldValue - 1;

    submitChange(newValue);
  }

  void submitRateValueChange(String newValue) {
    print("submitRateValueChange");
    cartFormKey.currentState!.patchValue({
      "$rateValueFieldName": newValue,
    });

    onRateChanged?.call(newValue);
  }

  void submitChange(int newValue) {
    var hasStockTracking = matrixQuantity.hasStockTracking ?? false;
    var remainingStock = matrixQuantity.remainingStock ?? 0;

    if (hasStockTracking && newValue > remainingStock) {
      toast(
        utils.hasExtraFieldTypeDate()
            ? 'The quota on selected date has reached the maximum limit.'.tr
            : 'The quota for quantity has reached the maximum limit.'.tr,
        level: SnackLevel.Error,
      );

      newValue = remainingStock;
    }

    cartFormKey.currentState!.patchValue({
      "$amountFieldName": newValue.toString(),
    });

    onChanged(newValue);
  }
}
