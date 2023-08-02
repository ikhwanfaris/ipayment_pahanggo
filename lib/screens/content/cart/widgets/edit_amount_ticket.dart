import 'package:flutter/material.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';

import '../../../../utils/helpers.dart';

class EditAmountButtonTicket extends StatelessWidget {
  const EditAmountButtonTicket({
    super.key,
    required this.onChanged,
  });

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
                child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: AppStyles.decoInputText,
                    onChanged: (value) async {
                      print("onChanged");
                      _value = value.replaceAll(",", "");
                    },
                    onEditingComplete: () {},
                    onSubmitted: (String value) {
                      print("value");
                      print(value);
                      if (value == "" || value.isEmpty) {
                        snack(context, 'Please enter amount.'.tr,
                            level: SnackLevel.Error);
                      } 
                      else {
                        // onChanged(value.replaceAll(",", ""));
                        Navigator.of(context).pop();
                      }
                    }),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (_value != null) {
                  onChanged(_value!);
                }
                print("_value");
                print(_value);
                if (_value == "" || _value!.isEmpty) {
                  snack(context, 'Please enter amount.'.tr,
                      level: SnackLevel.Error);
                } 
                else {
                  // onChanged(_value!);
                  Navigator.of(context).pop();
                }
                // FocusScope.of(getContext()).unfocus();
                // Navigator.of(getContext()).pop();
              },
              child: Text('Save'.tr),
            ),
          ],
        );
      },
    );
  }
}
