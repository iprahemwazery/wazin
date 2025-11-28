import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit() : super(RootInitial());

  int currentIndex = 0;
  final PageController pageController = PageController(initialPage: 0);

  void changePage(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    emit(RootPageChanged(index));
  }
}
