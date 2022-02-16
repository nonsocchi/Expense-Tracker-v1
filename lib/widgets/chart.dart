import 'package:flutter/material.dart';
import './chart_bar.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTxns;

  const Chart(this.recentTxns, {Key? key}) : super(key: key);

  List<Map<String, Object>> get groupedTxnValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double sumOfTxns = 0.0;

      for (var i = 0; i < recentTxns.length; i++) {
        if (recentTxns[i].date.day == weekDay.day &&
            recentTxns[i].date.month == weekDay.month &&
            recentTxns[i].date.year == weekDay.year) {
          sumOfTxns += recentTxns[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay) /* .substring(0, 1) */,
        'amount': sumOfTxns
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTxnValues.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      margin: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTxnValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'] as String,
                  data['amount'] as double,
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
