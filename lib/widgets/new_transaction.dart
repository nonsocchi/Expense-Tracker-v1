import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  NewTransaction({Key? key}) : super(key: key);

  final titleController = TextEditingController();
  final amountController = TextEditingController();

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
                onPressed: () {
                  print(titleController.text);
                  print(amountController.text);
                },
                child: const Text('Add transaction'))
          ],
        ),
      ),
    );
  }
}
