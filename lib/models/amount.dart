import 'package:cloud_firestore/cloud_firestore.dart';

import 'salesman.dart';

class Amount {
  double? comissionAmount = 0;
  double? amount_for_Southern_Region;
  double? amount_for_Coastal_Region;
  double? amount_for_Northern_Region;
  double? amount_for_Eastern_Region;
  double? amount_for_Lebanon;
  String? amountDate;
  SalesMan? user;
  Amount.no();
  Amount(
      {this.comissionAmount,
      this.amount_for_Southern_Region,
      this.amount_for_Coastal_Region,
      this.amount_for_Northern_Region,
      this.amount_for_Eastern_Region,
      this.amount_for_Lebanon,
      this.amountDate,
      this.user});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comissionAmount'] = this.comissionAmount;
    data['amount_for_Southern_Region'] = this.amount_for_Southern_Region;
    data['amount_for_Coastal_Region'] = this.amount_for_Coastal_Region;
    data['amount_for_Northern_Region'] = this.amount_for_Northern_Region;
    data['amount_for_Eastern_Region'] = this.amount_for_Eastern_Region;
    data['amount_for_Lebanon'] = this.amount_for_Lebanon;
    data['amountDate'] = this.amountDate;
    return data;
  }

  Amount toAmount(DocumentSnapshot doc) => Amount(
      comissionAmount: doc.get('comissionAmount'),
      amount_for_Southern_Region: doc.get('amount_for_Southern_Region'),
      amount_for_Coastal_Region: doc.get('amount_for_Coastal_Region'),
      amount_for_Northern_Region: doc.get('amount_for_Northern_Region'),
      amount_for_Eastern_Region: doc.get('amount_for_Eastern_Region'),
      amount_for_Lebanon: doc.get('amount_for_Lebanon'),
      amountDate: doc.get('amountDate'));
}
