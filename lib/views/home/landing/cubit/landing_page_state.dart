part of 'landing_page_cubit.dart';

abstract class LandingPageState extends Equatable {
  const LandingPageState();

  @override
  List<Object> get props => [];
}

final class LandingPageLoadingState extends LandingPageState {}

final class LandingPageLoadedState extends LandingPageState {
  final List<Agency> agencyList;
  const LandingPageLoadedState(this.agencyList);
  @override
  List<Object> get props => [agencyList];
}

final class LandingPageErrorState extends LandingPageState {
  final String errorMsg;
  const LandingPageErrorState(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}
