import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/home/widget/app_bare_notification.dart';

class SecurityView extends StatelessWidget {
  const SecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.green,
      body: Column(
        children: [
          const Gap(50),
          AppBareNotification(title: 'Security', showBack: true),
          const Gap(40),

          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 27,
                  right: 27,
                  top: 50,
                  bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Security Settings',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(20),

                    // خيار تغيير الـ PIN
                    _buildSecurityOption(
                      title: 'Change PIN',
                      onTap: () {
                        // TODO: انت هنا ضيف التوجيه لصفحة تغيير الـ PIN
                      },
                    ),
                    const Divider(),

                    // خيار تغيير الباسورد
                    _buildSecurityOption(
                      title: 'Change Password',
                      onTap: () {
                        // TODO: صفحة تغيير الباسورد
                      },
                    ),
                    const Divider(),

                    // خيار تفعيل التحقق الثنائي
                    _buildSecurityOption(
                      title: 'Two-Factor Authentication',
                      onTap: () {
                        // TODO: تفعيل التحقق الثنائي
                      },
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityOption({
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 18),
          ],
        ),
      ),
    );
  }
}
