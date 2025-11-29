import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazin/transaction_provider.dart';

class AddTransactionDialog extends StatefulWidget {
  final String category; // الكاتيجوري اللي جاي من TransactionView
  const AddTransactionDialog({super.key, required this.category});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController labelController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String type = 'Income';

  @override
  void initState() {
    super.initState();
    // خلي Label جاهز باسم الكاتيجوري
    labelController.text = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context, listen: false);

    return AlertDialog(
      title: const Text('Add Transaction'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButton<String>(
              value: type,
              items:
                  ['Income', 'Expense']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
              onChanged: (val) {
                if (val != null) setState(() => type = val);
              },
            ),
            TextField(
              controller: labelController,
              decoration: const InputDecoration(labelText: 'Label'),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            TextButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (date != null) selectedDate = date;
              },
              child: const Text('Select Date'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (labelController.text.isEmpty || amountController.text.isEmpty)
              return;

            Navigator.pop(context);
            provider.addTransaction({
              'label': labelController.text,
              'amount':
                  double.parse(amountController.text) *
                  (type == 'Income' ? 1 : -1),
              'date': selectedDate,
              'type': type,
            });
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
