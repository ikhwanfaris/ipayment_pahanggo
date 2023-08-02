import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';

class CheckoutButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final String? subText;
  final bool isLoading;
  final bool isEnabled;

  const CheckoutButton({
    Key? key,
    this.onPressed,
    this.subText,
    required this.text,
    this.isEnabled = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: constants.primaryColor,
        minimumSize: const Size(300, 60),
        padding: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
        ),
      ),
      onPressed: (!isEnabled || isLoading) ? null : onPressed,
      child: isLoading
          ? const CircularProgressIndicator()
          : SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      style: styles.checkoutButtonTextWhite,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
