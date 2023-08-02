import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterbase/api/barrel/barrel.dart';
import 'package:flutterbase/enums/enums.dart';
import 'package:flutterbase/events/event.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/models.dart';
import 'package:flutterbase/screens/content/cart/cart.dart';
import 'package:flutterbase/screens/content/cart/widgets/widgets.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
// import 'package:line_icons/line_icon.dart';
import 'package:rxdart/rxdart.dart';

import '../cart_utils.dart';

const kGreyoutOpacity = 0.2;

class CartRow extends StatefulWidget {
  const CartRow({
    Key? key,
    required this.item,
    required this.onChanged,
    required this.onSelected,
    this.readOnly = true,
  }) : super(key: key);

  final CartItem item;
  final void Function(CartItem item) onChanged;
  final void Function(bool) onSelected;
  final bool readOnly;

  @override
  State<CartRow> createState() => _CartRowState();
}

class _CartRowState extends State<CartRow> {
  late CartItemUtils utils;
  late bool needMatrix;
  late bool editableAmount;
  late Future<List<CartMatrix>> matrixFuture;
  late String cartRowFieldName;
  late String cartRowFieldIdName;
  late String cartRowFieldCheckboxName;
  late String cartRowFieldDisabledCheckboxName;
  late StreamSubscription<dynamic> streamOnChange;

  ValueNotifier amountChangeNotifier = ValueNotifier(0);
  final BehaviorSubject<dynamic> rxOnChange = BehaviorSubject<dynamic>();
  bool invalidCart = false;
  bool payable = true;

  late Widget cartItemHeader;
  late Widget cartItemBody;

  @override
  void initState() {
    super.initState();

    utils = CartItemUtils(widget.item);
    payable = utils.payable();
    needMatrix = utils.needMatrix();
    editableAmount = utils.editableAmount();
    cartRowFieldName = "cart.${utils.item.id}";
    cartRowFieldIdName = "$cartRowFieldName.id";
    cartRowFieldCheckboxName = "$cartRowFieldName._checked";
    cartRowFieldDisabledCheckboxName = "$cartRowFieldName.disabled_checkbox";

    streamOnChange =
        rxOnChange.debounceTime(Duration(milliseconds: 750)).listen(
      (event) {
        widget.onChanged(utils.item);

        makeCartItemHeader();
        makeCartItemBody();
      },
    );

    if (needMatrix) {
      matrixFuture = ApiMatrix().getService(utils.getServiceId());
    }

    makeCartItemHeader();
    makeCartItemBody();
  }

  @override
  void dispose() {
    streamOnChange.cancel();
    rxOnChange.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (invalidCart) return SizedBox.shrink();

    return Opacity(
      opacity: payable ? 1 : kGreyoutOpacity,
      child: AbsorbPointer(
        absorbing: !payable,
        child: widget.readOnly || payable
            ? cartItemBody
            : ExpandablePanel(
                header: cartItemHeader,
                collapsed: SizedBox.shrink(),
                expanded: cartItemBody,
              ),
      ),
    );
  }

  void makeCartItemHeader() {
    cartItemHeader = CartItemHeader(
      cartRowFieldCheckboxName: cartRowFieldCheckboxName,
      cartRowFieldDisabledCheckboxName: cartRowFieldDisabledCheckboxName,
      utils: utils,
      widget: widget,
      readOnly: widget.readOnly,
    );
  }

  void makeCartItemBody() {
    cartItemBody = Column(
      children: [
        /// [Hidden] Field: id
        SizedBox(
          width: 0,
          height: 0,
          child: FormBuilderTextField(
            name: cartRowFieldIdName,
            initialValue: (utils.item.id ?? 0).toString(),
            readOnly: true,
          ),
        ),

        /// Checkbox + Title
        if (widget.readOnly || payable) cartItemHeader,

        // Body
        Container(
          padding: EdgeInsets.fromLTRB(
            AppStyles.u4,
            AppStyles.u4,
            0,
            AppStyles.u4,
          ),
          decoration: AppStyles.decoRounded.copyWith(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.readOnly)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: AppStyles.u3),
                  child: Text(
                    utils.getTitle(),
                    style: styles.heading19,
                    softWrap: true,
                  ),
                ),

              /// Cart Item Sub Title
              !needMatrix || editableAmount
                  ? Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                /// Title
                                Text(
                                  utils.getItemTitle(),
                                  style: styles.heading21,
                                  softWrap: true,
                                ),
                                // SizedBox(
                                //   height: 8,
                                // ),
                                /// Subtitle
                                // Text(
                                //   utils.getItemSubTitle(),
                                //   style: styles.heading21,
                                //   softWrap: true,
                                // ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                /// [quantities] cart.*.amount
                                Text(
                                  utils.amountWithPrefix(
                                    prefix: 'RM',
                                  ),
                                  style: utils.amount == 0.00 ? styles.defaultInactiveTextStyle : styles.defaultTextStyle,
                                  textAlign: TextAlign.end,
                                ),

                                /// [Hidden] Field Amount
                                editableAmount
                                    ? SizedBox(
                                        width: 0,
                                        height: 0,
                                        child: FormBuilderTextField(
                                          name: "$cartRowFieldName.amount",
                                          initialValue:
                                              utils.amountWithPrefix(),
                                          readOnly: true,
                                        ),
                                      )
                                    : SizedBox.shrink(),

                                /// Cart Item Icon
                                editableAmount && !widget.readOnly
                                    ? EditAmountButton(
                                        initialValue: utils.getAmount(),
                                        onChanged: (value) {
                                          print("value onChanged");
                                          print(value.replaceAll(",", ""));
                                          utils.setAmount(
                                            double.parse(
                                                value..replaceAll(",", "")),
                                          );

                                          cartFormKey.currentState!.patchValue({
                                            "$cartRowFieldName.amount": value
                                          });

                                          rxOnChange.add(value);
                                        },
                                      )
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: AppStyles.u3,
                                        ),
                                        child: Container(),
                                        // child: LineIcon.pdfFile(),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),

              /// Cart Item Details from Matrix
              needMatrix
                  ? FutureBuilder<List<CartMatrix>>(
                      future: matrixFuture,
                      builder: (context, future) {
                        if (future.connectionState != ConnectionState.done) {
                          return DefaultLoadingBar();
                        }

                        if (future.data == null) {
                          return SizedBox.shrink();
                        }

                        utils.syncRemoteDetails(future.data!);

                        // need matrix but details is empty. cart item bug
                        // so delete.
                        if (utils.emptyDetails()) {
                          flagForceDeleteCartItem();

                          // fail to sync. cart item changes
                          // so update.
                        } else if (utils.flagCartItemError) {
                          flagForceUpdateDetails();
                        }

                        List<CartMatrix> details = utils.item.details ?? [];

                        /// Build Matrix List
                        List<Widget> widgets = [];

                        /// Load Extra Fields
                        var extraFields = makeExtraFields(details);
                        widgets.addAll(extraFields);

                        /// Separate between extrafields and category
                        if (extraFields.isNotEmpty)
                          widgets.add(
                            SizedBox(
                              height: AppStyles.u2,
                            ),
                          );

                        // Load Matrix
                        widgets.addAll(
                          makeMatrix(details),
                        );

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widgets,
                        );
                      },
                    )
                  : SizedBox.shrink(),

              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: AppStyles.u3, bottom: AppStyles.u2),
                    // child: _SeparatorLine(),
                  ),
                  if (widget.readOnly && needMatrix)
                    Container(
                      padding: EdgeInsets.only(bottom: AppStyles.u2),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("SubTotal:"),
                          ),
                          Expanded(
                            child: Text(
                              utils.amountWithPrefix(prefix: 'RM'),
                              style: utils.amount == 0.00 ? styles.defaultInactiveTextStyle : styles.defaultTextStyle,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          SizedBox(
                            width: AppStyles.u4,
                          ),
                        ],
                      ),
                    ),
                  // if (utils.getChargeTo().isNotEmpty )
                  //   Container(
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       children: [
                  //         Text(
                  //           ['Service Charge Type'.tr, ':'].join(' '),
                  //           style: AppStyles.f3w400,
                  //         ),
                  //         Text(
                  //           utils.getChargeTo(),
                  //           style: AppStyles.f3w400,
                  //         ),
                  //         SizedBox(
                  //           width: AppStyles.u4,
                  //         ),
                  //       ],
                  //     ),
                  //   )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  void flagForceUpdateDetails() {
    if (utils.item.id == null) return;

    xlog('flagForceUpdateDetails');

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.onChanged(utils.item);
    });
  }

  void flagForceDeleteCartItem() {
    if (invalidCart) return;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        invalidCart = true;
      });

      if (utils.item.id == null) return;

      ApiCart()
          .delete(utils.item.id!)
          .then((value) => eventBus.fire(CartUpdatedEvent()));
    });
  }

  List<Widget> makeExtraFields(
    List<CartMatrix> details,
  ) {
    List<Widget> widgets = [];

    for (int im = 0; im < details.length; im++) {
      // Filter out matrix
      if (details[im].extraFields == null) {
        continue;
      }

      var extraFields = details[im].extraFields ?? [];

      var fieldCount = 0;
      for (var field in extraFields) {
        var fieldName =
            "$cartRowFieldName.details.$im.extra_fields.$fieldCount.value";

        // Extra Field Label [field.source]
        widgets.add(
          Padding(
            padding: EdgeInsets.only(bottom: AppStyles.u2),
            child: Text("${field.source}"),
          ),
        );

        if (widget.readOnly) {
          widgets.add(
            Text("${field.value}"),
          );
        } else {
          switch (field.type) {
            case ExtraFieldType.date:
              widgets.add(
                /// Extra Field Date
                ExtraFieldDate(
                  fieldName: fieldName,
                  field: field,
                  onChange: (value) => onExtraFieldSubmitted(field, value),
                ),
              );
              break;
            case ExtraFieldType.textarea:
              widgets.add(
                /// Extra Field Text
                FormBuilderTextField(
                  name: fieldName,
                  initialValue: "${field.value}",
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  minLines: 2,
                  decoration: AppStyles.decoInputTextarea,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => onExtraFieldSubmitted(field, value),
                  onSubmitted: (value) => onExtraFieldSubmitted(field, value),
                ),
              );
              break;
            case ExtraFieldType.number:
              widgets.add(
                /// Extra Field Text
                FormBuilderTextField(
                  name: fieldName,
                  initialValue: field.value ?? '',
                  keyboardType: TextInputType.number,
                  decoration: AppStyles.decoInputText.copyWith(
                    suffixIcon: _InputSufficeDone(field: field),
                  ),
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => onExtraFieldSubmitted(field, value),
                  onSubmitted: (value) => onExtraFieldSubmitted(field, value),
                ),
              );
              break;
            case ExtraFieldType.currency:
              widgets.add(
                /// Extra Field Text
                FormBuilderTextField(
                  name: fieldName,
                  initialValue: "${field.value}",
                  keyboardType: TextInputType.number,
                  decoration: AppStyles.decoInputText.copyWith(
                    suffixIcon: _InputSufficeDone(field: field),
                  ),
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => onExtraFieldSubmitted(field, value),
                  onSubmitted: (value) => onExtraFieldSubmitted(field, value),
                ),
              );
              break;
            default:
              widgets.add(
                /// Extra Field Text
                FormBuilderTextField(
                  name: fieldName,
                  initialValue: "${field.value}",
                  decoration: AppStyles.decoInputText,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => onExtraFieldSubmitted(field, value),
                  onSubmitted: (value) => onExtraFieldSubmitted(field, value),
                ),
              );
              break;
          }
        }

        fieldCount++;
      }
    }

    return widgets;
  }

  List<Widget> makeMatrix(
    List<CartMatrix> details,
  ) {
    List<Widget> widgets = <Widget>[];

    for (int im = 0; im < details.length; im++) {
      CartMatrix cartMatrix = details[im];

      // Filter out extra_fields
      if (cartMatrix.isExtraFields) {
        continue;
      }

      List<MatrixItemGroup> itemGroups = (cartMatrix.items ?? []);

      // Loop group
      for (var ig = 0; ig < itemGroups.length; ig++) {
        var group = itemGroups[ig];
        var subitems = group.subitems;

        var hasDailyQuota = (group.hasDailyQuota ?? false);
        var gotQuotaForToday = ((group.remainingDailyQuota ?? 0) > 0);
        var canUpdateQuantities = !(hasDailyQuota && !gotQuotaForToday);

        List<Widget> groupDetails = <Widget>[];

        if (!canUpdateQuantities) {
          groupDetails.add(
            Padding(
              padding: EdgeInsets.only(bottom: AppStyles.u2),
              child: Text(
                utils.hasExtraFieldTypeDate()
                    ? "The quota on selected date has reached the maximum limit."
                        .tr
                    : "The quota for quantity has reached the maximum limit."
                        .tr,
                style: AppStyles().heading21,
              ),
            ),
          );
        }

        // Loop subitems
        for (int isi = 0; isi < itemGroups[ig].subitems.length; isi++) {
          // subitem
          var subitem = subitems[isi];

          // Loop Headers
          var headers = subitem.headers ?? [];

          if (headers.length > 0) {
            for (int isih = 0; isih < headers.length; isih++) {
              var header = headers[isih];

              // Render Header when
              // 1) need show quota
              var needShowQuota = (hasDailyQuota && isih == 0 && isi == 0);
              // 2) don't have daily quota
              var dontHaveDailyQuota = (isih == 0 && !hasDailyQuota);
              // 3) other than 1st header
              var otherThan1stHeader = (isih > 0);

              if (needShowQuota || dontHaveDailyQuota || otherThan1stHeader)
                groupDetails.add(
                  Padding(
                    padding: widget.readOnly
                        ? EdgeInsets.only(bottom: AppStyles.u4)
                        : EdgeInsets.zero,
                    child: Text(
                      header.name,
                      style: styles.heading20,
                    ),
                  ),
                );

              if (needShowQuota && !widget.readOnly) {
                var _quotaBalance = group.remainingDailyQuota ?? 0;
                var _quotaDaily = group.dailyQuota ?? 0;

                groupDetails.add(
                  Padding(
                    padding: EdgeInsets.only(bottom: AppStyles.u2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daily quota: @quota'.trParams({
                            'quota': _quotaDaily.toString(),
                          }),
                          style: styles.heading21,
                        ),
                        Text(
                          'Quota balance: @quota'.trParams({
                            'quota': _quotaBalance.toString(),
                          }),
                          style: styles.heading21,
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
          }

          /// Matrix - Quantities
          List<MatrixQuantity> quantities = subitem.quantities;
          for (int iq = 0; iq < quantities.length; iq++) {
            var mq = quantities[iq];
            var mqfFieldName =
                "$cartRowFieldName.details.$im.items.$ig.subitems.$isi.quantities.$iq";
            var mqfValue = quantities[iq].amount;

            groupDetails.add(
              Opacity(
                opacity: canUpdateQuantities ? 1 : kGreyoutOpacity,
                child: MatrixQuantityField(
                  utils: utils,
                  matrixQuantity: mq,
                  rootFieldName: mqfFieldName,
                  initialValue: mqfValue,
                  enabled: !widget.readOnly,
                  onChanged: (newValue) {
                    setState(() {
                      quantities[iq].amount = newValue;
                    });

                    rxOnChange.add(newValue);
                  },
                  onRateChanged: utils.editableMatrixRate()
                      ? (newValue) {
                          setState(() {
                            quantities[iq].rate.value = newValue;
                          });

                          rxOnChange.add(quantities[iq].amount);
                        }
                      : null,
                ),
              ),
            );

            if (mq == quantities.last) {
              break;
            }

            /// separator
            groupDetails.add(
              Padding(
                padding: EdgeInsets.only(bottom: AppStyles.u4),
                child: Container(
                  height: 1,
                  width: MediaQuery.of(getContext()).size.width,
                  color: Colors.grey.shade200,
                ),
              ),
            );
          }
        } // end loop subitems

        // Quota Control
        // not allow user interact if the items[n]
        // has quota control & no available quota
        widgets.add(
          AbsorbPointer(
            absorbing: !canUpdateQuantities,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: groupDetails,
            ),
          ),
        );
      } // end loop items
    }

    return widgets;
  }

  void onExtraFieldSubmitted(MatrixExtraField field, value) {
    if (value == null) {
      return;
    }

    field.value = value;

    rxOnChange.add(field.value);
  }
}

class _InputSufficeDone extends StatelessWidget {
  // ignore: unused_element
  const _InputSufficeDone({super.key, required this.field});

  final MatrixExtraField field;

  @override
  Widget build(BuildContext context) {
    return (field.value ?? '').isNotEmpty
        ? Padding(
            padding: EdgeInsets.only(right: AppStyles.u2),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(getContext()).unfocus();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Save'.tr),
                ],
              ),
            ),
          )
        : SizedBox.shrink();
  }
}

// class _SeparatorLine extends StatelessWidget {
//   const _SeparatorLine({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: AppStyles.u2),
//       child: Container(color: Colors.grey[200], height: 1),
//     );
//   }
// }

class CartRowWrapper extends StatelessWidget {
  const CartRowWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppStyles.u1).add(
        EdgeInsets.only(
          bottom: AppStyles.u2,
        ),
      ),
      child: child,
    );
  }
}
