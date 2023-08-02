import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';

class SecondarySection extends StatelessWidget {
  const SecondarySection({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppStyles.u4),
      decoration: AppStyles.decoRounded.copyWith(
        color: constants.green1,
      ),
      child: child,
    );
  }
}
