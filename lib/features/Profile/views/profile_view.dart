import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/Profile/widget/Security/security_view.dart';
import 'package:wazin/features/Profile/widget/profile_avatar.dart';
import 'package:wazin/features/Profile/widget/file_profile_item.dart';
import 'package:wazin/features/Profile/widget/logout_dialog.dart';
import 'package:wazin/features/Profile/widget/Editprofle/view/edit_profle.dart';
import 'package:wazin/features/home/widget/app_bare_notification.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: CustomColors.green,
        body: Column(
          children: [
            const Gap(50),
            const AppBareNotification(title: 'Profile', showBack: true),
            const Gap(20),
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned.fill(
                    top: 70,
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
                          top: 70,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Eprahem wazery',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text('ID: 5481584'),
                            const Gap(40),
                            Column(
                              children: [
                                FileProfileItem(
                                  title: 'Edit Profile',
                                  imagePath:
                                      'assets/images/profile/Icon Profile.png',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => EditProfileView(),
                                      ),
                                    );
                                  },
                                ),
                                const Gap(20),
                                FileProfileItem(
                                  title: 'Security',
                                  imagePath:
                                      'assets/images/profile/Icon Security.png',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => SecurityView(),
                                      ),
                                    );
                                  },
                                ),
                                const Gap(20),
                                FileProfileItem(
                                  title: 'Setting',
                                  imagePath:
                                      'assets/images/profile/Icon Setting.png',
                                ),
                                const Gap(20),
                                FileProfileItem(
                                  title: 'Help',
                                  imagePath:
                                      'assets/images/profile/Icon help.png',
                                ),
                                const Gap(20),
                                FileProfileItem(
                                  title: 'Logout',
                                  imagePath:
                                      'assets/images/profile/Icon Logout.png',

                                  onTap:
                                      () => showDialog(
                                        context: context,
                                        builder: (_) => const LogoutDialog(),
                                      ),
                                ),
                                const Gap(20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Positioned(
                    top: 0,
                    child: ProfileAvatar(
                      imagePath: 'assets/images/profile/Ellipse 192.png',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
