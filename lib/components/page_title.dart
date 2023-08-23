

import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';

class PageTitle extends StatelessWidget {
  final String title;
  const PageTitle(this.title, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: styles.heading8,
        ),
        SizedBox(
          width: 120,
          child: Divider(
            color: constants.sixColor,
            thickness: 5,
          ),
        ),
      ],
    );
  }
}