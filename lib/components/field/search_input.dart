import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:get/get.dart';

class SearchInput extends StatelessWidget {
  final VoidCallback onTap;
  final ValueChanged<String>? onChanged;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  const SearchInput({
    required this.onTap,
    this.onChanged,
    required this.backgroundColor,
    this.padding = const EdgeInsets.fromLTRB(8, 8, 8, 8),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding:EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: SizedBox(
                height: 35,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  decoration: styles.inputDecoration.copyWith(
                    fillColor: constants.paleWhite,
                    filled: true,
                    hintText: 'Keyword...'.tr,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: constants.primaryColor),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: constants.primaryColor),
                      borderRadius: BorderRadius.circular(4)                      
                    ),
                    
                    ),
                  onChanged: onChanged,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: padding,
                  child: Container(
                      decoration: BoxDecoration(
                        color: constants.fiveColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(getIcon('magnifying-glass'),
                            color: Colors.white, size: 25),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
