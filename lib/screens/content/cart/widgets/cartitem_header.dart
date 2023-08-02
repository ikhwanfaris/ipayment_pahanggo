import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterbase/screens/content/cart/cart_utils.dart';
import 'package:flutterbase/screens/content/cart/widgets/widgets.dart';
import 'package:flutterbase/utils/constants.dart';

import '../cart.dart';

class CartItemHeader extends StatelessWidget {
  const CartItemHeader({
    super.key,
    required this.cartRowFieldCheckboxName,
    required this.cartRowFieldDisabledCheckboxName,
    required this.utils,
    required this.widget,
    this.readOnly = false,
  });

  final String cartRowFieldCheckboxName;
  final String cartRowFieldDisabledCheckboxName;
  final CartItemUtils utils;
  final CartRow widget;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    var title = Text(
      utils.getTitle(),
      style: styles.heading19,
      textAlign: TextAlign.start,
      softWrap: true,
    );

    if (readOnly) {
      return SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        if (utils.getSubTotal() == 0) {
          return;
        }

        //
        cartFormKey.currentState!.fields.forEach((key, field) {
          if (key.contains(cartRowFieldCheckboxName)) {
            bool currentValue = (field.value ?? false);

            field.didChange(!currentValue);
          }
        });
      },
      child: AbsorbPointer(
        child: FormBuilderCheckbox(
          side: BorderSide(
            color: utils.getSubTotal() == 0 ? constants.secondaryColor : constants.primaryColor,
          ),
          
          contentPadding: EdgeInsets.zero,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
          ),
          name: utils.selectable()
              ? cartRowFieldCheckboxName
              : cartRowFieldDisabledCheckboxName,
          title: title,
          onChanged: (value) => widget.onSelected(value ?? false),
        ),
      ),
    );
  }
}
