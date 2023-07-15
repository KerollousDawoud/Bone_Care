import 'package:dopproject/doctor_screen/doctor_screen.dart';
import 'package:dopproject/history_screen/history_screen.dart';
import 'package:dopproject/home_page/home_page.dart';
import 'package:dopproject/pharmacy_screen/pharmacy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitial());
  static HomeLayoutCubit get(context) => BlocProvider.of(context);
  List<Widget> body = [
    HomePage(),
    History(),
    Doctor(),
    Pharmacy(),
  ];
  int index = 0;
  void changeIndex(index) {
    this.index = index;
    emit(ChangeIndex());
  }
}
