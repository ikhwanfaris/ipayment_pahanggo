import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:line_icons/line_icons.dart';

class AddToCartButton extends StatefulWidget {
  final Future Function()? onPressed;
  final bool isEnabled;

  const AddToCartButton({
    Key? key,
    this.onPressed,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Constants().sixColor,
        disabledBackgroundColor: Colors.black12,
        minimumSize: const Size(60, 60),
        elevation: 0,
        shape: RoundedRectangleBorder(),
      ),
      onPressed: (!widget.isEnabled || isLoading) ? null : () async {
        setState(() {
          isLoading = true;
        });
        await widget.onPressed!();
        setState(() {
          isLoading = false;
        });
      },
      child: isLoading
          ? const DefaultLoadingBar()
          : SizedBox(
              child: Icon(LineIcons.addToShoppingCart, size: 40),
            ),
    );
  }
}
