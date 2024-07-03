import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/utility/lauch_call.dart';

part 'emergency_situation_state.dart';

class EmergencySituationCubit extends Cubit<EmergencySituationState> {
  EmergencySituationCubit() : super(const NotEmergencyState());

  final LaunchCall _launchCall = LaunchCall();

  /// Automaticly Change State after some duration
  // void autoTurnOff() {
  //   Future.delayed(
  //     const Duration(seconds: 5),
  //     () => emit(
  //       const NotEmergencyState(),
  //     ),
  //   );
  // }

  void emergencyOccured() {
    emit(const EmergencyState());
    _launchCall.makeCall('112');
  }

  void stopEmergency() {
    emit(const NotEmergencyState());
    // TODO:IMPLEMENT FUNCTIONAL
  }
}
