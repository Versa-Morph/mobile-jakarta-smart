part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
    this.email,
    this.password,
    this.isSuccess = false,
    this.isError = false,
    this.errorMsg = '',
  });
  final String? email;
  final String? password;
  final bool isSuccess;
  final bool isError;
  final String errorMsg;

  SignInState copyWith({
    String? email,
    String? password,
    bool? isSuccess,
    bool? isError,
    String? errorMsg,
  }) {
    return SignInState(
        email: email ?? this.email,
        password: password ?? this.password,
        isSuccess: isSuccess ?? this.isSuccess,
        isError: isError ?? this.isError,
        errorMsg: errorMsg ?? this.errorMsg);
  }

  @override
  List<Object?> get props => [email, password, isSuccess, isError, errorMsg];
}
