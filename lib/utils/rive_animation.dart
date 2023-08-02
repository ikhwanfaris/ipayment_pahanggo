import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class DefaultLoadingBar extends StatelessWidget {
  const DefaultLoadingBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: RiveAnimation.asset('assets/dist/animate_logo_loop.riv'),
    );
  }
}
