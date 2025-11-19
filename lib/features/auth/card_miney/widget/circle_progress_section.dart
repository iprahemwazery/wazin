import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'remaining_arc_painter.dart';

class CircleProgressSection extends StatelessWidget {
  final double progress;
  final String circleLabel;
  final double remaining;

  const CircleProgressSection({
    super.key,
    required this.progress,
    required this.circleLabel,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: 1,
                strokeWidth: 5,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white24),
              ),
            ),
            CustomPaint(
              size: const Size(80, 80),
              painter: RemainingArcPainter(
                progress,
                remaining >= 0 ? Colors.blueAccent : Colors.red,
              ),
            ),
            SvgPicture.asset(
              'assets/images/svg_navbar/Vector(5).svg',
              width: 40,
              height: 40,
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
    );
  }
}
