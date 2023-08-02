import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';

class AddToCartButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final bool isLoading;
  final bool isEnabled;

  const AddToCartButton({
    Key? key,
    this.onPressed,
    required this.icon,
    this.isEnabled = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Constants().sixColor,
        minimumSize: const Size(300, 60),
        elevation: 0,
        shape: RoundedRectangleBorder(),
      ),
      onPressed: (!isEnabled || isLoading) ? null : onPressed,
      child: isLoading
          ? const CircularProgressIndicator()
          : SizedBox(
              child: Icon(icon, size: 40),
            ),
    );
  }
}
