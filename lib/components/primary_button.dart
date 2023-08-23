import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final String? subText;
  final bool isLoading;

  const PrimaryButton({
    Key? key,
    this.onPressed,
    this.subText,
    required this.text,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed == null ? Colors.grey : Constants().sixColor,
        minimumSize: const Size(300, 60),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const CircularProgressIndicator()
          : Container(
              width: double.infinity,
              constraints: BoxConstraints(maxHeight: 100),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      text.toTitleCase(),
                      style: styles.raisedButtonTextWhite,
                      textAlign: TextAlign.center,
                    ),
                    ...(subText != null
                        ? [
                            Text(
                              (subText ?? '').toTitleCase(),
                              style: styles.raisedButtonTextWhite,
                              textAlign: TextAlign.center,
                              textScaleFactor: 0.8,
                            )
                          ]
                        : [SizedBox.shrink()])
                  ],
                ),
              ),
            ),
    );
  }
}
