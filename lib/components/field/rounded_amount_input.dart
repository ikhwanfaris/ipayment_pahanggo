
import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';

import '../../api/api.dart';
import '../../utils/phosphor.dart';

class RoundedAmountInput extends StatefulWidget {
  final Function(double) onSubmit;
  final Function()? onDone;
  final String title;
  final double initialValue;
  final double? maxValue;
  final bool autoFocus;
  final bool hasAsterisk;

  RoundedAmountInput(
    this.title,
    this.onSubmit, {
      this.maxValue,
      this.onDone,
      this.autoFocus = true,
      this.initialValue = 0,
      this.hasAsterisk = false
    });

  @override
  State<RoundedAmountInput> createState() => _RoundedAmountInputState();
}

class _RoundedAmountInputState extends State<RoundedAmountInput> {
  final TextEditingController amountController = TextEditingController(text: '0');
  final inputFocus = FocusNode();
  bool hasFocus = false;

  @override
  void initState() {
    amountController.value = TextEditingValue(text: widget.initialValue.toString());
    inputFocus.addListener(() {
      setState(() {
        hasFocus = inputFocus.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: [
              Text(
                  widget.title,
                  style: styles.heading10bold,
              ),
              if(widget.hasAsterisk)
                Text('*', style: TextStyle(color: Colors.red),)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 0),
          child: Focus(
            focusNode: inputFocus,
            onFocusChange: (value) {
              if(value) {
                amountController.selection = TextSelection(
                  baseOffset: amountController.text.length,
                  extentOffset: amountController.text.length
                );
              } else {
                if(double.tryParse(amountController.text) == null) {
                  amountController.text = '0';
                  amountController.selection = TextSelection(
                    baseOffset: amountController.text.length,
                    extentOffset: amountController.text.length
                  );
                }
              }
            },
            child: TextFormField(
              autofocus: widget.autoFocus,
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
              decoration: styles.inputDecoration.copyWith(
                filled: true,
                prefix: Text('RM'),
                suffixIcon: (hasFocus) ? IconButton(onPressed: () async {
                  if(amountController.text != '0') {
                    var round = await api.roundingAdjustment((double.tryParse(amountController.text) ?? 0.0).toStringAsFixed(2));
                    var value = (double.tryParse(amountController.text) ?? 0.0) + (double.tryParse(round.data['value'].toString()) ?? 0.00);
                    amountController.text = value.toStringAsFixed(2);
                    if(value > 0) {
                      if(widget.maxValue != null && value > widget.maxValue!) {
                        value = widget.maxValue!;
                      }
                      widget.onSubmit(value);
                    }
                  }
                  inputFocus.unfocus();
                  if(widget.onDone != null) {
                    widget.onDone!();
                  }
                }, icon: Icon(getIcon('check'))) : null,
              ),
              textAlign: TextAlign.end,
              validator: (value) {
                if (value == null || value.isEmpty || double.tryParse(value)! <= 0) {
                  return 'This field cannot be left blank.'.tr;
                }
                return null;
              },
              onChanged: (val) {
                if(double.tryParse(val) == null) {
                  amountController.text = '0';
                  amountController.selection = TextSelection(
                    baseOffset: amountController.text.length,
                    extentOffset: amountController.text.length
                  );
                  return;
                }
                if(val[0] == '0' && val.length > 1) {
                  amountController.text = val.substring(1);
                  amountController.selection = TextSelection(
                    baseOffset: amountController.text.length,
                    extentOffset: amountController.text.length
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
