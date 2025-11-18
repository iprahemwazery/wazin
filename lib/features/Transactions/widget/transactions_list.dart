import 'package:flutter/material.dart';
import 'package:wazin/features/Transactions/widget/transaction_item.dart';

class TransactionsList extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const TransactionsList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty)
      return const Center(child: Text("No transactions yet"));

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(28),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tx = transactions[index];
          return TransactionItem(transaction: tx);
        },
      ),
    );
  }
}
