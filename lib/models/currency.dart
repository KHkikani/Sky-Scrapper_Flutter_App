import 'package:flutter/foundation.dart';

class Currency {
  String from;
  String to;
  num amount;
  num result;

  Currency({
    required this.from,
    required this.to,
    required this.amount,
    required this.result,
  });

  factory Currency.fromJson({required Map data}) {
    Currency currency = Currency(
      from: data['request']['from'],
      to: data['request']['to'],
      amount: data['request']['amount'],
      result: data['result'],
    );

    return currency;
  }
}
