// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:wazin/core/custom_colors.dart';
// import 'package:wazin/features/Transactions/widget/custom_porgress_bar_over_lay.dart';
// import 'package:wazin/features/dataCardHome/widget/week_crach.dart';
// import 'package:wazin/features/home/widget/app_bare_notification.dart';
// import 'package:wazin/features/home/widget/simple_check_box.dart';
// import 'package:wazin/features/home/widget/slied_day.dart';
// import 'package:wazin/shared/loading_circult.dart';

// class AnalysisView extends StatelessWidget {
//   const AnalysisView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: CustomColors.green,
//         body: Column(
//           children: [
//             const Gap(60),
//             AppBareNotification(title: 'Analysis', showBack: true),
//             const Gap(20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // النصوص على الشمال
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Row(
//                       children: [
//                         Image.asset(
//                           'assets/images/Income.png',
//                           width: 20,
//                           height: 20,
//                           fit: BoxFit.fill,
//                         ),
//                         const SizedBox(width: 4),
//                         const Text(
//                           'Total Balance',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                     const Text(
//                       r'$7,783.00',
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(width: 20),

//                 Container(width: 2, height: 60, color: Colors.white),
//                 const SizedBox(width: 20),

//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Image.asset(
//                           'assets/images/Expense.png',
//                           width: 20,
//                           height: 20,
//                           fit: BoxFit.fill,
//                         ),
//                         const SizedBox(width: 4),
//                         const Text(
//                           'Total Expense',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                     const Text(
//                       r'-$1.187.40',
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             GlobalProgressBar(),
//             const Gap(8),
//             SimpleCheckboxExample(),
//             const Gap(20),

//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(60),
//                     topRight: Radius.circular(60),
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 28.0,
//                     vertical: 30,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SlideDay(),
//                       const Gap(20),
//                       const SizedBox(height: 250, child: WeeklyBarChart()),
//                       Gap(25),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Image.asset(
//                             'assets/images/Income.png',
//                             width: 20,
//                             height: 20,
//                             fit: BoxFit.fill,
//                             color: CustomColors.green,
//                           ),
//                           Image.asset(
//                             'assets/images/Expense.png',
//                             width: 20,
//                             height: 20,
//                             fit: BoxFit.fill,
//                             color: CustomColors.blue,
//                           ),
//                         ],
//                       ),

//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: const [
//                           Text(
//                             'Income',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             'Expense',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: const [
//                           Text(
//                             r'$4,783.00',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: CustomColors.green,
//                             ),
//                           ),
//                           Text(
//                             r'$1.187.40',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: CustomColors.blue,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Gap(10),
//                       Text(
//                         'My Targets',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[800],
//                         ),
//                       ),
//                       Gap(10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           LoadingCircult(progress: 0.3, label: 'Travel'),
//                           LoadingCircult(progress: 0.5, label: 'car'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/Analysis/widget/balance_card.dart';
import 'package:wazin/features/Analysis/widget/income_expense_chart.dart';
import 'package:wazin/features/Analysis/widget/my_targets.dart';
import 'package:wazin/features/Analysis/widget/checkboxes_section.dart';
import 'package:wazin/features/home/widget/app_bare_notification.dart';
import 'package:wazin/features/Transactions/widget/custom_porgress_bar_over_lay.dart';
import 'package:wazin/features/home/widget/slied_day.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: CustomColors.green,
        body: Column(
          children: [
            const Gap(60),
            const AppBareNotification(title: 'Analysis', showBack: true),
            const Gap(20),

            // Total Balance & Expense
            const BalanceCard(),
            const GlobalProgressBar(),
            const Gap(8),
            const CheckboxesSection(),
            const Gap(20),

            // Chart & My Targets
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28.0,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SlideDay(),
                      SizedBox(height: 20),
                      IncomeExpenseChart(),
                      SizedBox(height: 25),
                      MyTargets(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
