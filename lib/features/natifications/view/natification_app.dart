import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/home/widget/app_bare_notification.dart';
import 'package:wazin/features/natifications/widget/detels_natification.dart';

class NatificationApp extends StatelessWidget {
  const NatificationApp({super.key});

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
            AppBareNotification(title: 'Notifications', showBack: true),
            const Gap(20),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(20),
                        DetelsNatification(
                          text: 'Reminder!',
                          des: 'Set up your automatic savings to',
                          dess: 'meet your savings goal...',
                          time: '17:00 - April 5, ',
                          icon: Icons.notifications_none,
                        ),
                        Gap(10),
                        Container(
                          height: 2, // سمك الخط
                          width: double.infinity, // طول الخط يغطي كامل العرض
                          color: CustomColors.green, // لون الخط
                        ),
                        const Gap(20),
                        DetelsNatification(
                          text: 'New update',
                          des: 'Set up your automatic savings to',
                          dess: 'meet your savings goal...',
                          time: '17:00 - April 5, ',
                          icon: Icons.star_border,
                        ),
                        Gap(10),
                        Container(
                          height: 2, // سمك الخط
                          width: double.infinity, // طول الخط يغطي كامل العرض
                          color: CustomColors.green, // لون الخط
                        ),
                        const Gap(20),
                        const Text(
                          'Yesterday',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DetelsNatification(
                          text: 'Transaction ',
                          des: 'transaction has been registered',
                          dess: r'Groceries |  pantry  |  -$100,00',
                          time: '17:00 - April 4, ',
                          icon: Icons.attach_money,
                        ),
                        Gap(10),
                        Container(
                          height: 2, // سمك الخط
                          width: double.infinity, // طول الخط يغطي كامل العرض
                          color: CustomColors.green, // لون الخط
                        ),
                        const Gap(20),
                        DetelsNatification(
                          text: 'Reminder!',
                          des: 'Set up your automatic savings to',
                          dess: 'meet your savings goal...',
                          time: '17:00 - April 5, ',
                          icon: Icons.notifications_none,
                        ),
                        Gap(10),
                        Container(
                          height: 2, // سمك الخط
                          width: double.infinity, // طول الخط يغطي كامل العرض
                          color: CustomColors.green, // لون الخط
                        ),
                        const Gap(20),

                        Text(
                          'This Weekendconst ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DetelsNatification(
                          text: 'Expense record',
                          des: 'We recommend that you be more ',
                          dess: 'attentive to your finances.',
                          time: '17:00 - April 5, ',
                          icon: Icons.arrow_downward,
                        ),
                        Gap(10),
                        Container(
                          height: 2, // سمك الخط
                          width: double.infinity, // طول الخط يغطي كامل العرض
                          color: CustomColors.green, // لون الخط
                        ),
                        DetelsNatification(
                          text: 'Reminder!',
                          des: 'Set up your automatic savings to',
                          dess: 'meet your savings goal...',
                          time: '17:00 - April 5, ',
                          icon: Icons.notifications_none,
                        ),
                        Gap(10),
                        Container(
                          height: 2, // سمك الخط
                          width: double.infinity, // طول الخط يغطي كامل العرض
                          color: CustomColors.green, // لون الخط
                        ),
                        DetelsNatification(
                          text: 'Transaction ',
                          des: 'transaction has been registered',
                          dess: r'Groceries |  pantry  |  -$100,00',
                          time: '17:00 - April 4, ',
                          icon: Icons.attach_money,
                        ),
                        Gap(10),
                        Container(
                          height: 2, // سمك الخط
                          width: double.infinity, // طول الخط يغطي كامل العرض
                          color: CustomColors.green, // لون الخط
                        ),
                      ],
                    ),
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
