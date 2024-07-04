part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSucces extends SignInState {}

class SignInError extends SignInState {
  final String errorMsg;
  const SignInError(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}
