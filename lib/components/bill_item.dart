
import 'package:flutter/material.dart';
import 'package:flutterbase/components/field/rounded_amount_input.dart';
import 'package:flutterbase/controller/bottom_bar_controller.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/screens/services/bill_detail.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:get/get.dart';

class BillItem extends StatefulWidget {
  final BottomBarController bottomBarController;
  final Bill bill;
  BillItem(this.bottomBarController, this.bill);

  @override
  State<BillItem> createState() => _BillItemState();
}

class _BillItemState extends State<BillItem> {

  bool isChecked = false;
  double inputAmount = 0;

  @override
  void initState() {
    debounce<bool>(widget.bottomBarController.allChecked, (value) {
      if(value && !(widget.bill.canView && widget.bill.canPay && widget.bill.nettCalculations.due> 0)) {
        widget.bottomBarController.remove(billId: widget.bill.id);
        setState(() {
          isChecked = false;
        });
        return;
      }

      setState(() {
        isChecked = value;
      });

      if(isChecked) {
        widget.bottomBarController.add(widget.bill.chargedTo!, billId: widget.bill.id, widget.bill.nettCalculations.due);
      } else {
        widget.bottomBarController.remove(billId: widget.bill.id);
      }
    }, time: .1.seconds);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: widget.bill.canView? () {
          Get.to(() => BillDetailsScreen(), arguments: {
            'id': widget.bill.id,
            'amount': inputAmount,
          });
        } : null,
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 12, 16, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 50,
                child: Checkbox(
                  value: isChecked,
                  onChanged: (widget.bill.canView&& widget.bill.canPay && widget.bill.nettCalculations.due> 0) ? (bool? value) {
                    if(value!) {
                      var response = widget.bottomBarController.add(widget.bill.chargedTo!, billId: widget.bill.id, widget.bill.nettCalculations.due);
                      if(response != null) {
                        snack(context, response, level: SnackLevel.Warning);
                        return;
                      }
                    } else {
                      widget.bottomBarController.remove(billId: widget.bill.id);
                    }
                    setState(() {
                      isChecked = value;
                    });
                  } : null,
                  side: BorderSide(
                    color: (
                      (widget.bill.canView&& widget.bill.canPay && widget.bill.nettCalculations.due> 0) ? Colors.amber : Colors.black38
                    ),
                    width: 1.5,
                  ),
                  checkColor: Colors.white,
                  activeColor: Colors.amber,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Text(
                              widget.bill.canView ? widget.bill.detail! : 'You do not have access to this record.'.tr,
                              style: TextStyle(
                                color: constants.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        RightInfo(widget.bill, (amount) {
                          setState(() {
                            inputAmount = amount;
                          });

                          widget.bill.nettCalculations.due = amount;

                          if(isChecked) {
                            widget.bottomBarController.change(billId: widget.bill.id, widget.bill.nettCalculations.due);
                          }
                        }, amount: widget.bill.nettCalculations.due),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Text(widget.bill.summary, style: TextStyle(fontSize: 12, color: Colors.black45)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: .2, color: Colors.black26),
            ),
          ),
        ),
      ),
    );
  }
}

class RightInfo extends StatelessWidget {
  final Bill bill;
  final double amount;
  final Function(double amount) onSetAmount;

  const RightInfo(this.bill, this.onSetAmount, {super.key, this.amount = 0});

  @override
  Widget build(BuildContext context) {
    if((bill.billTypeId == 2 || bill.billTypeId == 4) && bill.canPay) {
      return InkWell(
        onTap: (){
          showBottomSheet(context: context, builder: (_) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              height: 96,
              child: RoundedAmountInput('Please input amount:'.tr, onSetAmount, onDone: () {
                Navigator.of(context).pop();
              }, initialValue: amount, hasAsterisk: true, maxValue: 1000000,),
            );
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  "RM " + moneyFormat(double.parse(amount.toString())),
                  style: TextStyle(color: constants.primaryColor),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Icon(getIcon('pencil'), size: 15, color: constants.primaryColor),
                ),
              ],
            ),
            if(bill.billDate != null)
              Text(
                dateFormatterDisplay.format(bill.billDate!),
                style: TextStyle(color: Colors.black45),
              ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: bill.canView? [
        Text(
          "RM " + moneyFormat(double.parse((amount > 0 ? amount : bill.nettCalculations.due).toString())),
          style: TextStyle(color: constants.primaryColor),
        ),
        if(bill.billDate != null)
          Text(
            dateFormatterDisplay.format(bill.billDate!),
            style: TextStyle(color: Colors.black45),
          ),
      ] : [],
    );
  }
}
