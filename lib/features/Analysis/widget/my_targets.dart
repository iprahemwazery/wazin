import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/shared/loading_circult.dart';

class MyTargets extends StatelessWidget {
  const MyTargets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(10),
        Text(
          'My Targets',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            LoadingCircult(progress: 0.3, label: 'Travel'),
            LoadingCircult(progress: 0.5, label: 'Car'),
          ],
        ),
      ],
    );
  }
}
