part of 'report_incident_cubit.dart';

sealed class ReportIncidentState extends Equatable {
  const ReportIncidentState();

  @override
  List<Object> get props => [];
}

final class ReportIncidentInitial extends ReportIncidentState {}

final class ReportLoadingState extends ReportIncidentState {}

final class ReportSuccessState extends ReportIncidentState {}

final class ReportFailureState extends ReportIncidentState {
  final String errorMsg;
  const ReportFailureState(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}
