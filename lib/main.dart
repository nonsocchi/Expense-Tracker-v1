import 'package:flutter/material.dart';
import 'package:personal_expense_v1/transactions.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'Bought shoes',
      amount: 89.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly groceries',
      amount: 34.50,
      date: DateTime.now(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: const Card(
                child: Text('# CHART'),
                color: Colors.purpleAccent,
                elevation: 5,
              ),
            ),
            Column(
              children: transactions
                  .map((tx) => Card(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.purple, width: 1.8),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '₦${tx.amount}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.black),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tx.title,
                                style: const TextStyle(
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                DateFormat.yMMMd().format(tx.date),
                                style: const TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ],
                      )))
                  .toList(),
            )
          ],
        ));
  }
}
