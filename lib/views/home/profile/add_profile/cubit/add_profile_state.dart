part of 'add_profile_cubit.dart';

abstract class AddProfileState extends Equatable {
  const AddProfileState();

  @override
  List<Object?> get props => [];
}

final class AddProfileInitial extends AddProfileState {}

final class AddProfileLoading extends AddProfileState {}

final class AddProfileSuccess extends AddProfileState {}

final class AddProfileError extends AddProfileState {
  final String errorMsg;
  const AddProfileError(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}
