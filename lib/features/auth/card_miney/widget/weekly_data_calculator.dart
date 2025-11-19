import 'package:cloud_firestore/cloud_firestore.dart';

class WeeklyData {
  final double lastWeekIncome;
  final double lastWeekExpense;
  final double currentWeekIncome;
  final double currentWeekExpense;

  WeeklyData({
    required this.lastWeekIncome,
    required this.lastWeekExpense,
    required this.currentWeekIncome,
    required this.currentWeekExpense,
  });

  double get lastWeekRemaining => lastWeekIncome - lastWeekExpense;
  double get currentWeekRemaining => currentWeekIncome - currentWeekExpense;
}

class WeeklyDataCalculator {
  static WeeklyData calculate(List<Map<String, dynamic>> txs) {
    final now = DateTime.now();

    double lastWeekIncome = 0, lastWeekExpense = 0;
    double currentWeekIncome = 0, currentWeekExpense = 0;

    DateTime startOfWeek(DateTime date) =>
        date.subtract(Duration(days: date.weekday - 1));
    DateTime endOfWeek(DateTime date) =>
        date.add(Duration(days: DateTime.daysPerWeek - date.weekday));

    final lastWeekStart = startOfWeek(now.subtract(const Duration(days: 7)));
    final lastWeekEnd = endOfWeek(now.subtract(const Duration(days: 7)));
    final currentWeekStart = startOfWeek(now);
    final currentWeekEnd = endOfWeek(now);

    for (var tx in txs) {
      DateTime date;

      if (tx['date'] is Timestamp) {
        date = (tx['date'] as Timestamp).toDate();
      } else {
        date = DateTime.tryParse(tx['date'].toString()) ?? DateTime.now();
      }

      double amount =
          tx['amount'] is num
              ? (tx['amount'] as num).toDouble()
              : double.tryParse(tx['amount'].toString()) ?? 0.0;

      if (date.isAfter(lastWeekStart) && date.isBefore(lastWeekEnd)) {
        if (amount >= 0)
          lastWeekIncome += amount;
        else
          lastWeekExpense += amount.abs();
      }

      if (date.isAfter(currentWeekStart) && date.isBefore(currentWeekEnd)) {
        if (amount >= 0)
          currentWeekIncome += amount;
        else
          currentWeekExpense += amount.abs();
      }
    }

    return WeeklyData(
      lastWeekIncome: lastWeekIncome,
      lastWeekExpense: lastWeekExpense,
      currentWeekIncome: currentWeekIncome,
      currentWeekExpense: currentWeekExpense,
    );
  }
}
