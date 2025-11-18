import 'package:flutter/material.dart';
import 'package:wazin/core/custom_colors.dart';

class SlideDay extends StatefulWidget {
  const SlideDay({super.key});

  @override
  State<SlideDay> createState() => _SlideDayState();
}

class _SlideDayState extends State<SlideDay> {
  int selectedIndex = 0; // الزر النشط

  @override
  Widget build(BuildContext context) {
    final List<String> labels = ['Daily', 'Weekly', 'Monthly'];

    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: List.generate(labels.length, (index) {
          bool isSelected = selectedIndex == index;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: isSelected ? CustomColors.green : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    labels[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
