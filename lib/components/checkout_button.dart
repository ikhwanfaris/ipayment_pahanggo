import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';

class CheckoutButton extends StatefulWidget {
  final Future Function()? onPressed;
  final String text;
  final String? subText;
  final bool isEnabled;

  const CheckoutButton({
    Key? key,
    this.onPressed,
    this.subText,
    required this.text,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  State<CheckoutButton> createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {

  bool isLoading = false;

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
      onPressed: (!widget.isEnabled || isLoading) ? null : () async {
        setState(() {
          isLoading = true;
        });
        if(widget.onPressed != null) {
          await widget.onPressed!();
        }
        setState(() {
          isLoading = false;
        });
      },
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
                      widget.text,
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
