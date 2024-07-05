part of 'profile_page_cubit.dart';

sealed class ProfilePageState extends Equatable {
  const ProfilePageState();

  @override
  List<Object> get props => [];
}

final class ProfilePageLoadingState extends ProfilePageState {}

final class ProfilePageLoadedState extends ProfilePageState {
  final UserBio userBio;
  const ProfilePageLoadedState(this.userBio);

  @override
  List<Object> get props => [userBio];
}

final class ProfilePageEmptyState extends ProfilePageState {}

final class ProfilePageErrorState extends ProfilePageState {
  const ProfilePageErrorState(this.errorMsg);
  final String errorMsg;
}
