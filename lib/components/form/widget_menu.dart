import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';

class CustomWidgetMenu extends StatelessWidget {
  final String counter;
  final String title;
  final VoidCallback onTap;
  final Color backgroundColor;
  final TextStyle counterTextStyle;

  const CustomWidgetMenu({
    required this.counter,
    required this.title,
    required this.onTap,
    required this.backgroundColor,
    required this.counterTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    counter,
                    style: counterTextStyle,
                  ),
                  Text(
                    title,
                    style: styles.widgetMenuTitle, textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
