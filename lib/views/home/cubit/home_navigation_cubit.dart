import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_navigation_state.dart';

class HomeNavigationCubit extends Cubit<HomeNavigationState> {
  HomeNavigationCubit() : super(const HomeNavigationInitial(tabIndex: 0));

  void changeTab(int tabIndex) {
    emit(HomeNavigationInitial(tabIndex: tabIndex));
  }
}
