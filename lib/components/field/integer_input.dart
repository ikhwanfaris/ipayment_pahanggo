
import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import '../../utils/phosphor.dart';

class IntegerInput extends StatefulWidget {
  final Function(int) onSubmit;
  final Function()? onDone;
  final String title;
  final int initialValue;
  final int maxValue;
  final bool autoFocus;

  IntegerInput(this.title, this.onSubmit, { this.onDone, this.autoFocus = true, this.initialValue = 0, this.maxValue = -1 });

  @override
  State<IntegerInput> createState() => _IntegerInputState();
}

class _IntegerInputState extends State<IntegerInput> {
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
          child: Text(
              widget.title,
              style: styles.heading10bold,
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
                if(int.tryParse(amountController.text) == null) {
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
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              textInputAction: TextInputAction.next,
              decoration: styles.inputDecoration.copyWith(
                filled: true,
                suffixIcon: (hasFocus) ? IconButton(onPressed: () async {
                  var value = int.tryParse(amountController.text) ?? 0;
                  if(widget.maxValue > -1 && value > widget.maxValue) {
                    value = widget.maxValue;
                  }
                  amountController.text = value.toString();
                  widget.onSubmit(value);
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
                if(int.tryParse(val) == null) {
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
