import 'package:flutter/material.dart';
import './user_transactions.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTx);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
                decoration: const InputDecoration(labelText: 'Expense Title'),
                controller: titleController),
            TextField(
              decoration: const InputDecoration(labelText: 'Expense Amount'),
              controller: amountController,
            ),
            ElevatedButton(
                onPressed: () => addTx(
                      titleController.text,
                      double.parse(amountController.text),
                    ),
                child: const Text('Add transaction'))
          ],
        ),
      ),
    );
  }
}
