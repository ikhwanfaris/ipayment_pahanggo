import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';

import '../../../../utils/helpers.dart';

class EditAmountButton extends StatelessWidget {
  const EditAmountButton({
    super.key,
    required this.onChanged,
    required this.initialValue,
  });

  final double initialValue;
  final void Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    String? _value;

    return IconButton(
      icon: LineIcon.edit(),
      onPressed: () {
        showAppBottomsheet(
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: EdgeInsets.all(AppStyles.u2),
                child: TextFormField(
                    initialValue: initialValue.toStringAsFixed(2),
                    autofocus: true,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: AppStyles.decoInputText,
                    inputFormatters: <TextInputFormatter>[
                      CurrencyTextInputFormatter(
                        decimalDigits: 2,
                        symbol: '',
                      ),
                    ],
                    onChanged: (value) async {
                      print("onChanged");
                      _value = value.replaceAll(",", "");
                    },
                    onFieldSubmitted: (String value) {
                      if (value == "" || value.isEmpty) {
                        snack(context, 'Please enter amount.'.tr,
                            level: SnackLevel.Error);
                      } else {
                        onChanged(value.replaceAll(",", ""));
                        Navigator.of(context).pop();
                      }
                    }),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppStyles.u2,
                ).add(
                  EdgeInsets.only(
                    bottom: AppStyles.u4,
                  ),
                ),
                child: Row(
                  children: [
                    LineIcon.exclamationCircle(),
                    SizedBox(width: AppStyles.u2),
                    Expanded(
                      child: Text(
                        "The amount is adjusted based on the Malaysia Treasury Circular."
                            .tr,
                        style: AppStyles.f3w400,
                        softWrap: true,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (_value != null) {
                  onChanged(_value!.replaceAll(",", ""));
                }

                FocusScope.of(getContext()).unfocus();
                Navigator.of(getContext()).pop();
              },
              child: Text('Save'.tr),
            ),
          ],
        );
      },
    );
  }
}
