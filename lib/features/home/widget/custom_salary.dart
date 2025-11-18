import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/core/custom_colors.dart';

class CustomSalary extends StatelessWidget {
  const CustomSalary({
    super.key,
    required this.salaryTime,
    required this.salaryAmount,
    required this.salaryDate,
    required this.salaryLabel,
    required this.salaryIconPath,
  });

  final String salaryTime;
  final String salaryAmount;
  final String salaryDate;
  final String salaryLabel;
  final String salaryIconPath;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // الأيقونة
          Image.asset(
            salaryIconPath,
            width: screenWidth * 0.12, // 12% من عرض الشاشة
            height: screenWidth * 0.12,
            fit: BoxFit.fill,
          ),
          Gap(screenWidth * 0.02),
          // عمود النصوص
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    salaryLabel,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    salaryTime,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            width: 2,
            height: screenWidth * 0.1,
            color: CustomColors.green,
          ),
          // نص التاريخ
          Expanded(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                salaryDate,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            width: 2,
            height: screenWidth * 0.1,
            color: CustomColors.green,
          ),
          // نص المبلغ
          Expanded(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                salaryAmount,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
