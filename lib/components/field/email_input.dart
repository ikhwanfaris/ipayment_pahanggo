
import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';
import '../../utils/phosphor.dart';

class EmailInput extends StatefulWidget {
  final Function(String) onSubmit;
  final Function()? onDone;
  final String title;
  final String initialValue;
  final bool autoFocus;

  EmailInput(this.title, this.onSubmit, { this.onDone, this.autoFocus = true, this.initialValue = '' });

  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  final TextEditingController amountController = TextEditingController();
  final inputFocus = FocusNode();
  bool hasFocus = false;

  @override
  void initState() {
    amountController.value = TextEditingValue(text: widget.initialValue);
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
            child: TextFormField(
              autocorrect: false,
              autofocus: widget.autoFocus,
              controller: amountController,
              minLines: 1,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              decoration: styles.inputDecoration.copyWith(
                contentPadding: EdgeInsets.all(8),
                filled: true,
                isDense: true,
                suffixIcon: (hasFocus) ? IconButton(onPressed: () async {
                  widget.onSubmit(amountController.text);
                  inputFocus.unfocus();
                  if(widget.onDone != null) {
                    widget.onDone!();
                  }
                }, icon: Icon(getIcon('check'))) : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
