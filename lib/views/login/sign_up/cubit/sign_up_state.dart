part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSucces extends SignUpState {}

final class SignUpError extends SignUpState {
  final String errorMsg;
  const SignUpError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
