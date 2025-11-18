import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/core/custom_colors.dart';

class DetelsNatification extends StatelessWidget {
  const DetelsNatification({
    super.key,
    required this.text,
    required this.des,
    required this.dess,
    required this.time,
    required this.icon,
  });
  final String text;
  final String des;
  final String dess;

  final String time;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: CustomColors.green,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, size: 30, color: Colors.black),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(des, style: TextStyle(fontSize: 14, color: Colors.grey)),
            Text(dess, style: TextStyle(fontSize: 14, color: Colors.grey)),
            Row(
              children: [
                Gap(100),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
