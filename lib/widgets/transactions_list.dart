import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTxn;

  const TransactionList(this.transactions, this.deleteTxn, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints) {
                return Column(
                  children: [
                    Text(
                      'No transactions yet!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // ignore: sized_box_for_whitespace
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: const Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/waiting.png'),
                      ),
                    ),
                  ],
                );
              })
            : ListView.builder(
                itemBuilder: (context, index) {
                  return TransactionItem(
                      transaction: transactions[index], deleteTxn: deleteTxn);
                },
                itemCount: transactions.length,
              ),
      ),
    );
  }
}
