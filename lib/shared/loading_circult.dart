import 'package:flutter/material.dart';
import 'package:wazin/core/custom_colors.dart';

class LoadingCircult extends StatelessWidget {
  const LoadingCircult({
    super.key,
    required this.progress,
    required this.label,
  });
  final double progress;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      width: 135,
      decoration: BoxDecoration(
        color: CustomColors.blue,
        borderRadius: BorderRadius.circular(40),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 75,
                height: 75,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 5,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              Text(
                progress >= 1
                    ? '100%'
                    : '${(progress * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
