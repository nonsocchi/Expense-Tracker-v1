import 'package:flutter/material.dart';
import 'package:personal_expense_v1/widgets/chart.dart';
import './widgets/transactions_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transactions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
            button: const TextStyle(
                fontFamily: 'OpenSans', fontWeight: FontWeight.bold)),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
      ).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(secondary: Colors.amber),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTxns {
    return _userTransactions
        .where((tx) =>
            tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate);
    setState(() => _userTransactions.add(newTx));
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final myAppBar = AppBar(
      title: const Text('Expense Tracker'),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: const Icon(Icons.add),
        )
      ],
    );
    final txnList = SizedBox(
        height: (MediaQuery.of(context).size.height -
                myAppBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: myAppBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                // if landscape, show [_showChart] toggle
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Show Chart'),
                  Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      })
                ],
              ),
            // two main widgets on homePage
            if (!isLandscape) // if portrait mode?
              SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          myAppBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.25,
                  child: Chart(_recentTxns)),
            if (!isLandscape) txnList,
            if (isLandscape)
              _showChart
                  ? SizedBox(
                      height: (MediaQuery.of(context).size.height -
                              myAppBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(_recentTxns))
                  : txnList
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
