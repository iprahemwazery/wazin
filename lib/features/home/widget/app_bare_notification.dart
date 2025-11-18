import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/Root.dart';
import 'package:wazin/features/natifications/view/natification_app.dart';

class AppBareNotification extends StatelessWidget {
  final String title;
  final bool showBack;

  const AppBareNotification({
    super.key,
    required this.title,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: Row(
        children: [
          if (showBack)
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Root()),
                );
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 26,
                color: Colors.black,
              ),
            ),

          if (showBack) const Spacer(),

          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const NatificationApp();
                  },
                ),
              );
            },
            child: Image.asset(
              'assets/images/Icon-Notification.png',
              width: 30,
              height: 30,
              fit: BoxFit.fill,
            ),
          ),
          Gap(5),
        ],
      ),
    );
  }
}
