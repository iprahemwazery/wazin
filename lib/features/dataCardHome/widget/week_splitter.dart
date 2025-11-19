import 'package:cloud_firestore/cloud_firestore.dart';

List<Map<String, double>> splitWeeks(
  List<Map<String, dynamic>> txs,
  DateTime month,
) {
  List<Map<String, double>> weeks = [
    {"income": 0.0, "expense": 0.0},
    {"income": 0.0, "expense": 0.0},
    {"income": 0.0, "expense": 0.0},
    {"income": 0.0, "expense": 0.0},
  ];

  for (var tx in txs) {
    DateTime date;
    if (tx['date'] is Timestamp) {
      date = (tx['date'] as Timestamp).toDate();
    } else {
      date = DateTime.tryParse(tx['date'].toString()) ?? DateTime.now();
    }

    if (date.month != month.month || date.year != month.year) continue;

    int weekIndex = (date.day - 1) ~/ 7;
    if (weekIndex < 0 || weekIndex > 3) continue;

    double amount =
        (tx["amount"] is num)
            ? (tx["amount"] as num).toDouble()
            : double.tryParse(tx["amount"].toString()) ?? 0.0;

    if (amount >= 0) {
      weeks[weekIndex]["income"] = weeks[weekIndex]["income"]! + amount;
    } else {
      weeks[weekIndex]["expense"] = weeks[weekIndex]["expense"]! + amount.abs();
    }
  }

  return weeks;
}
