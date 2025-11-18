import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wazin/features/Analysis/view/analysis_view.dart';
import 'package:wazin/features/Categories/view/gategories_view.dart';
import 'package:wazin/features/Profile/views/profile_view.dart';
import 'package:wazin/features/Transactions/view/transaction_view.dart';
import 'package:wazin/features/home/view/home_view.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late PageController _pageController;
  int currentState = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: currentState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> icons = [
      'assets/images/svg_navbar/Vector.svg',
      'assets/images/svg_navbar/Vector(1).svg',
      'assets/images/svg_navbar/Transactions.svg',
      'assets/images/svg_navbar/Category.svg',
      'assets/images/svg_navbar/Profile.svg',
    ];

    final List<String> labels = [
      'الرئيسية',
      'Analysis',
      'المعاملات',
      'التصنيفات',
      'الملف الشخصي',
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeView(),
          AnalysisView(),
          TransactionView(),
          CategoriesView(),
          ProfileView(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: currentState,
            selectedItemColor: const Color(0xFF2AE0BC),
            unselectedItemColor: Colors.grey.shade500,
            showUnselectedLabels: true,
            onTap: (index) {
              setState(() {
                currentState = index;
                _pageController.jumpToPage(index);
              });
            },
            items: List.generate(icons.length, (index) {
              final bool isSelected = currentState == index;
              return BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.asset(
                    icons[index],
                    width: 26,
                    height: 26,
                    colorFilter: ColorFilter.mode(
                      isSelected
                          ? const Color(0xFF2AE0BC)
                          : Colors.grey.shade600,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                label: labels[index],
              );
            }),
          ),
        ),
      ),
    );
  }
}
