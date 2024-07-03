import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'emergency_page_state.dart';

class EmergencySituationCubit extends Cubit<EmergencySituationState> {
  EmergencySituationCubit() : super(const NotEmergencyState());

  final PageController pageController = PageController();

  void emergencyOccured() {
    emit(const EmergencyState());
    // TODO IMPLEMENT FUNCTIONAL
  }

  void stopEmergency() {
    emit(const NotEmergencyState());
    // TODO:IMPLEMENT FUNCTIONAL
  }
}
