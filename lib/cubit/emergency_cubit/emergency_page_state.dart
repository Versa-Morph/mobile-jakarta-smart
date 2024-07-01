part of 'emergency_page_cubit.dart';

@immutable
sealed class EmergencySituationState {
  final int index;
  const EmergencySituationState({required this.index});
}

final class NotEmergencyState extends EmergencySituationState {
  const NotEmergencyState({required super.index});
}

final class EmergencyState extends EmergencySituationState {
  const EmergencyState({required super.index});
}
