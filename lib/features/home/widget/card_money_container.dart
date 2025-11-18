import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/dataCardHome/view/data_cart_view.dart';
import 'package:wazin/transaction_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CarMoneyContainer extends StatelessWidget {
  const CarMoneyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TransactionProvider>();

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: provider.transactionsStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final txs = snapshot.data!;
        final now = DateTime.now();

        final weeklyData = _calculateWeeklyData(txs, now);

        // نسبة المتبقي (remaining / income) بين 0 و 1
        double progress =
            weeklyData.currentWeekIncome == 0
                ? 0
                : weeklyData.currentWeekRemaining /
                    weeklyData.currentWeekIncome;

        if (progress < 0) progress = 0;

        final circleLabel =
            weeklyData.currentWeekRemaining >= 0 ? 'Income' : 'Expense';

        return Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DataCartView()),
              );
            },
            child: Container(
              height: 180,
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: CustomColors.green,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // دائرة مع خط المتبقي
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: CircularProgressIndicator(
                              value: 1, // الدائرة الكاملة تمثل الدخل
                              strokeWidth: 5,
                              backgroundColor: Colors.grey.shade300,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white24,
                              ),
                            ),
                          ),
                          CustomPaint(
                            size: const Size(80, 80),
                            painter: _RemainingArcPainter(
                              progress,
                              weeklyData.currentWeekRemaining >= 0
                                  ? Colors.yellow
                                  : Colors.red,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/images/svg_navbar/Vector(5).svg',
                            width: 40,
                            height: 40,
                            fit: BoxFit.fill,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        circleLabel,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // خط عمودي
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    width: 2,
                    height: 140,
                    color: Colors.white,
                  ),
                  const Gap(1),

                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // الأسبوع الماضي
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/Vectormany.png',
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.fill,
                                ),
                                const Gap(8),
                                const Text(
                                  'Last Week',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(8),
                            Text(
                              weeklyData.lastWeekIncome == 0
                                  ? 'No data'
                                  : '\$${(weeklyData.lastWeekIncome - weeklyData.lastWeekExpense).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              width: 144,
                              height: 2,
                              color: Colors.white,
                            ),
                          ],
                        ),

                        // الأسبوع الحالي
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/Vectormany.png',
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.fill,
                                ),
                                const Gap(8),
                                const Text(
                                  'This Week',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(8),
                            Text(
                              '\$${weeklyData.currentWeekRemaining.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static _WeeklyData _calculateWeeklyData(
    List<Map<String, dynamic>> txs,
    DateTime now,
  ) {
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

      double amount = 0.0;
      final rawAmount = tx["amount"];
      if (rawAmount is num) {
        amount = rawAmount.toDouble();
      } else {
        amount = double.tryParse(rawAmount.toString()) ?? 0.0;
      }

      // الأسبوع الماضي
      if (date.isAfter(lastWeekStart.subtract(const Duration(seconds: 1))) &&
          date.isBefore(lastWeekEnd.add(const Duration(seconds: 1)))) {
        if (amount >= 0)
          lastWeekIncome += amount;
        else
          lastWeekExpense += amount.abs();
      }

      // الأسبوع الحالي
      if (date.isAfter(currentWeekStart.subtract(const Duration(seconds: 1))) &&
          date.isBefore(currentWeekEnd.add(const Duration(seconds: 1)))) {
        if (amount >= 0)
          currentWeekIncome += amount;
        else
          currentWeekExpense += amount.abs();
      }
    }

    return _WeeklyData(
      lastWeekIncome: lastWeekIncome,
      lastWeekExpense: lastWeekExpense,
      currentWeekIncome: currentWeekIncome,
      currentWeekExpense: currentWeekExpense,
    );
  }
}

class _WeeklyData {
  final double lastWeekIncome;
  final double lastWeekExpense;
  final double currentWeekIncome;
  final double currentWeekExpense;

  double get lastWeekRemaining => lastWeekIncome - lastWeekExpense;
  double get currentWeekRemaining => currentWeekIncome - currentWeekExpense;

  _WeeklyData({
    required this.lastWeekIncome,
    required this.lastWeekExpense,
    required this.currentWeekIncome,
    required this.currentWeekExpense,
  });
}

class _RemainingArcPainter extends CustomPainter {
  final double progress; // نسبة المتبقي
  final Color color;

  _RemainingArcPainter(this.progress, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final startAngle = -3.14 / 2;
    final sweepAngle = 2 * 3.14 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _RemainingArcPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
