import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Map<String, dynamic>> _transactions = [];
  List<Map<String, dynamic>> get transactions => _transactions;

  double get totalIncome => _transactions
      .where((tx) => tx['amount'] >= 0)
      .fold(0.0, (sum, tx) => sum + (tx['amount'] as num).toDouble());

  double get totalExpense => _transactions
      .where((tx) => tx['amount'] < 0)
      .fold(0.0, (sum, tx) => sum + -(tx['amount'] as num).toDouble());

  double get totalBalance => totalIncome - totalExpense;

  double get incomePercent {
    double total = totalIncome + totalExpense;
    return total > 0 ? (totalIncome / total).clamp(0.0, 1.0) : 0.0;
  }

  double get expensePercent {
    double total = totalIncome + totalExpense;
    return total > 0 ? (totalExpense / total).clamp(0.0, 1.0) : 0.0;
  }

  /// Stream للمعاملات من Firestore
  Stream<List<Map<String, dynamic>>> transactionsStream() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    return _firestore
        .collection('transactions')
        .doc(uid)
        .collection('user_transactions')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          final list =
              snapshot.docs
                  .map((doc) => {...doc.data(), 'id': doc.id})
                  .toList();

          // تحديث القائمة المحلية بدون استدعاء notifyListeners هنا
          _transactions = list;

          return list;
        });
  }

  /// إضافة معاملة جديدة
  Future<void> addTransaction(Map<String, dynamic> tx) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    try {
      final docRef = await _firestore
          .collection('transactions')
          .doc(uid)
          .collection('user_transactions')
          .add(tx);

      // تحديث محلي فورًا بعد إضافة Firestore
      _transactions.insert(0, {...tx, 'id': docRef.id});
      notifyListeners();
    } catch (e) {
      debugPrint("Error adding transaction: $e");
    }
  }

  /// حذف معاملة
  Future<void> deleteTransaction(String id) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    try {
      await _firestore
          .collection('transactions')
          .doc(uid)
          .collection('user_transactions')
          .doc(id)
          .delete();

      // تحديث محلي فورًا
      _transactions.removeWhere((tx) => tx['id'] == id);
      notifyListeners();
    } catch (e) {
      debugPrint("Error deleting transaction: $e");
    }
  }
}
