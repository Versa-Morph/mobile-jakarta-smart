part of 'profile_page_cubit.dart';

sealed class ProfilePageState extends Equatable {
  const ProfilePageState();

  @override
  List<Object> get props => [];
}

final class ProfilePageInitial extends ProfilePageState {}

final class ProfilePageLoading extends ProfilePageState {}

final class ProfilePageLoaded extends ProfilePageState {
  final UserBio userBio;
  const ProfilePageLoaded(this.userBio);

  @override
  List<Object> get props => [userBio];
}

final class ProfilePageEmpty extends ProfilePageState {}

final class ProfilePageError extends ProfilePageState {
  const ProfilePageError(this.errorMsg);
  final String errorMsg;
}
