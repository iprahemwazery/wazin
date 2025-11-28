import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wazin/cubit/root_cubit.dart';
import 'package:wazin/cubit/root_state.dart';

import 'package:wazin/features/home/view/home_view.dart';
import 'package:wazin/features/Analysis/view/analysis_view.dart';
import 'package:wazin/features/Transactions/view/transaction_view.dart';
import 'package:wazin/features/Categories/view/gategories_view.dart';
import 'package:wazin/features/Profile/views/profile_view.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RootCubit(),
      child: BlocBuilder<RootCubit, RootState>(
        builder: (context, state) {
          final cubit = context.read<RootCubit>();

          final List<String> icons = [
            'assets/images/svg_navbar/Vector.svg',
            'assets/images/svg_navbar/Vector(1).svg',
            'assets/images/svg_navbar/Transactions.svg',
            'assets/images/svg_navbar/Category.svg',
            'assets/images/svg_navbar/Profile.svg',
          ];

          final List<String> labels = [
            'Home',
            'Analysis',
            'Transaction',
            'Categories',
            'Profile',
          ];

          return Scaffold(
            backgroundColor: Colors.grey[100],
            body: PageView(
              controller: cubit.pageController,
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
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) => cubit.changePage(index),
                selectedItemColor: const Color(0xFF2AE0BC),
                unselectedItemColor: Colors.grey.shade500,
                showUnselectedLabels: true,
                items: List.generate(icons.length, (index) {
                  final bool selected = cubit.currentIndex == index;
                  return BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      icons[index],
                      width: 26,
                      height: 26,
                      colorFilter: ColorFilter.mode(
                        selected
                            ? const Color(0xFF2AE0BC)
                            : Colors.grey.shade600,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: labels[index],
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
