import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTxn;

  TransactionList(this.transactions, this.deleteTxn);
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
                  return Card(
                    elevation: 5.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 5.0,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30.0,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: SizedBox(
                            height: 20.0, // padding at top of the chart card
                            child: FittedBox(
                              child: Text(
                                '₦${transactions[index].amount.toStringAsFixed(0)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                      ),
                      trailing: MediaQuery.of(context).size.width > 460
                          ? TextButton.icon(
                              onPressed: () =>
                                  deleteTxn(transactions[index].id),
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).errorColor,
                              ),
                              label: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Theme.of(context).errorColor,
                                ),
                              ),
                            )
                          : IconButton(
                              onPressed: () =>
                                  deleteTxn(transactions[index].id),
                              icon: const Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                            ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ),
      ),
    );
  }
}
