import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/cubit/location_cubit/location_cubit.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit({required this.locationCubit}) : super(HomePageState.initial());
  final LocationCubit locationCubit;
  LocationState get locationState => locationCubit.state;

  final PageController pageController = PageController();

  /// Navigating the page
  void changeTab(int tabIndex) {
    emit(state.copyWith(tabIndex: tabIndex));
  }
}
