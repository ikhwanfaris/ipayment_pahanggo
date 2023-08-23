
import 'package:flutter/material.dart';
import 'package:flutterbase/components/page_title.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';

class PaymentDetails extends StatelessWidget {
  final Bill bill;
  PaymentDetails(this.bill);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf9f9f9),
        appBar: AppBar(
          backgroundColor: Color(0xFFf9f9f9),
          iconTheme: IconThemeData(
            color: constants.primaryColor,
          ),
          title: Text('Payment Details'.tr, style: styles.heading5,),
          elevation: 0,
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          children: [
            if(bill.billTypeId == 1)
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: PageTitle('Bill Amount'.tr)),
                SizedBox(
                  width: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: Text('RM', textAlign: TextAlign.end, style: TextStyle(color: Colors.black54),),
                  ),
                )
              ],
            ),
            if(bill.billTypeId == 1)
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for(var i = 0; i < bill.chargelineSummaries.length; i++)
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                    child: Text((i + 1).toString() + '.', style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  Text(bill.chargelineSummaries[i].description, style: TextStyle(fontWeight: FontWeight.bold,),),
                                ],
                              ),
                              Text(moneyFormat(bill.chargelineSummaries[i].originalAmount), style: TextStyle(fontWeight: FontWeight.bold,),),
                            ],
                          ),
                          SizedBox(height: 4),
                          for(var change in bill.chargelineSummaries[i].changes)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          child: (change.amount < 0) ? Text('-', textAlign: TextAlign.center,) : Text('+', textAlign: TextAlign.center,),
                                        ),
                                        Text(
                                          change.agencyReferenceNumber,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(moneyFormat(change.amount)),
                                ],
                              ),
                            ),
                          SizedBox(height: 8),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Divider(height: 1),
                    ),
                    if(bill.nettCalculations.rounding != 0) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Amount Before Rounding'.tr, style: TextStyle(fontWeight: FontWeight.bold,),),
                          Text(moneyFormat(bill.amountBeforeRounding), style: TextStyle(fontWeight: FontWeight.bold,))
                        ],
                      ),
                      Divider(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rounding Amount'.tr, style: TextStyle(fontWeight: FontWeight.bold,),),
                          Text(moneyFormat(bill.nettCalculations.rounding), style: TextStyle(fontWeight: FontWeight.bold,))
                        ],
                      ),
                      Divider(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Amount After Rounding'.tr, style: TextStyle(fontWeight: FontWeight.bold,),),
                          Text(moneyFormat(bill.amountAfterRounding), style: TextStyle(fontWeight: FontWeight.bold,))
                        ],
                      ),
                    ],
                    if(bill.nettCalculations.rounding == 0) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total'.tr, style: TextStyle(fontWeight: FontWeight.bold,),),
                          Text(moneyFormat(bill.amountBeforeRounding)),
                        ],
                      ),
                    ]
                  ],
                ),
              ),
            ),
            if(bill.billTypeId == 1)
            SizedBox(height: 16),
            if(bill.payments.isNotEmpty)
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PageTitle('Payment'.tr),
                  SizedBox(
                    width: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 14.0),
                      child: Text('RM', textAlign: TextAlign.end, style: TextStyle(color: Colors.black54),),
                    ),
                  )
                ],
              ),
            if(bill.payments.isNotEmpty)
              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      for(var i = 0; i < bill.payments.length; i++)
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20,
                                  child: Text((i + 1).toString() + '.'),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Receipt Number'.tr + ': ' + (bill.payments[i].receiptNumber ?? '')),
                                      SizedBox(height: 2),
                                      Text(dateFormatterDisplay.format(bill.payments[i].paymentDate), style: TextStyle(color: Colors.black45),),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 110,
                                  child: Align(
                                    child: Text(moneyFormat(bill.payments[i].amount)),
                                    alignment: Alignment.topRight,
                                  ),
                                )
                              ],
                            ),
                            if(i != bill.payments.length - 1)
                              Divider(height: 16),
                          ],
                        ),
                      if(bill.payments.length > 1)
                        Divider(height: 1),
                      if(bill.payments.length > 1)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Align(
                            child: Text('Total'.tr + ': RM ' + moneyFormat(bill.payments.fold<double>(0, (e, p) => e + p.amount)), style: TextStyle(fontWeight: FontWeight.bold),),
                            alignment: Alignment.topRight,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
    );
  }
}
