
import 'package:flutter/material.dart';
import 'package:flutterbase/components/field/text_input.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';


class IconSearchInput extends StatefulWidget {
  final Color noSearchColor;
  final Color hasSearchColor;
  final Function(String term) onChange;

  const IconSearchInput(this.onChange, {
    super.key,
    this.noSearchColor = Colors.black38,
    this.hasSearchColor = const Color(0XFFF045B62),
  });

  @override
  State<IconSearchInput> createState() => _IconSearchInputState();
}

class _IconSearchInputState extends State<IconSearchInput> {
  String term = '';

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        PersistentBottomSheetController? bottomSheet;

        bottomSheet = showBottomSheet(context: context, builder: (context) {
          return Focus(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              height: 96,
              child: TextInput('Search'.tr, initialValue: term, (v){
                  Navigator.of(context).pop();
                },
                onDone: () {
                  bottomSheet!.close();
                },
                onChange: (value){
                  setState(() {
                    term = value;
                  });
                  widget.onChange(value);
                },
              ),
            ),
            onFocusChange: (v) {
              if(!v) {
                bottomSheet!.close();
              }
            },
          );
        });
      },
      icon: Icon(LineIcons.search, color: term.isNotEmpty ? widget.hasSearchColor : widget.noSearchColor,),
    );
  }
}