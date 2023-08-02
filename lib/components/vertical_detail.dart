

import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';

class VerticalDetail extends StatelessWidget {
  const VerticalDetail({
    Key? key,
    required this.title,
    required this.detail,
  }) : super(key: key);

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: constants.primaryColor, fontSize: 16),
          ),
          Text(
            detail,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}