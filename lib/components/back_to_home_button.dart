import 'package:flutter/material.dart';
import 'package:flutterbase/screens/content/home/menu.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class AppBackToHomeButton extends StatelessWidget {
  const AppBackToHomeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        var homeRoute = MaterialPageRoute(builder: (_) => MenuScreen());
        Navigator.of(context).pushAndRemoveUntil(homeRoute, (route) => false);
      },
      icon: Icon(
        LineIcons.times,
        color: constants.primaryColor,
        size: 28,
      ),
    );
  }
}
