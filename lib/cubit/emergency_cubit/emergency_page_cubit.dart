import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'emergency_page_state.dart';

class EmergencySituationCubit extends Cubit<EmergencySituationState> {
  EmergencySituationCubit() : super(const NotEmergencyState(index: 0));

  final PageController pageController = PageController();

  void emergencyOccured(int index) {
    emit(EmergencyState(index: index));
    // TODO IMPLEMENT FUNCTIONAL
    switch (index) {
      case 0:
      case 1:
        print('1');
      case 2:
        print('2');

      default:
        print('Default');
    }
  }

  void stopEmergency(int index) {
    emit(NotEmergencyState(index: index));
    // TODO:IMPLEMENT FUNCTIONAL
  }
}
