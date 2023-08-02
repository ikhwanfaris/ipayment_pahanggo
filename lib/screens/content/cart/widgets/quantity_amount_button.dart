import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';

class QuantityAmountButton extends StatelessWidget {
  const QuantityAmountButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  final void Function()? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Constants().tenColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: this.icon,
      ),
    );
  }
}
