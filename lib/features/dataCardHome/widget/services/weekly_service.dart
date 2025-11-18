import 'package:cloud_firestore/cloud_firestore.dart';

class WeeklyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, double>>> getWeeklyData() async {
    QuerySnapshot snapshot = await _firestore.collection("transactions").get();

    /// weeks = 4 weeks
    List<Map<String, double>> weeks = List.generate(
      4,
      (_) => {"income": 0.0, "expense": 0.0},
    );

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;

      double amount = (data["amount"] ?? 0).toDouble();
      DateTime date = (data["date"] as Timestamp).toDate();

      int weekIndex = _getWeekInMonth(date) - 1;

      if (weekIndex >= 0 && weekIndex < 4) {
        if (amount >= 0) {
          weeks[weekIndex]["income"] = weeks[weekIndex]["income"]! + amount;
        } else {
          weeks[weekIndex]["expense"] =
              weeks[weekIndex]["expense"]! + amount.abs();
        }
      }
    }

    return weeks;
  }

  int _getWeekInMonth(DateTime date) {
    int day = date.day;
    return ((day - 1) ~/ 7) + 1;
  }
}
