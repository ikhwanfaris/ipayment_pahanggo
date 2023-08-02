import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';

class DeleteButton2 extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final bool isLoading;

  const DeleteButton2({
    Key? key,
    this.onPressed,
    required this.text,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: const BorderSide(
            width: 1, // the thickness
            color: Colors.white // the color of the border
            ),
        backgroundColor: constants.primaryColor,
        minimumSize: const Size(300, 60),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const CircularProgressIndicator()
          : SizedBox(
              width: double.infinity,
              child: Text(
                text.toTitleCase(),
                style: styles.raisedButtonTextWhite,
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
