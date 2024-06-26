part of 'emergency_page_cubit.dart';

@immutable
sealed class EmergencyPageState {
  final int index;
  const EmergencyPageState({required this.index});
}

final class NotEmergencyState extends EmergencyPageState {
  const NotEmergencyState({required super.index});
}

final class EmergencyState extends EmergencyPageState {
  const EmergencyState({required super.index});
}
