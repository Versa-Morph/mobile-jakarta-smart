import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_jakarta/exception/auth_exception.dart';
import 'package:smart_jakarta/services/auth_services.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState());

  void emailChanged(String email) {
    emit(state.copyWith(email: email, isError: false, errorMsg: ''));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password, isError: false, errorMsg: ''));
  }

  void resetError() {
    emit(state.copyWith(isError: false, errorMsg: ''));
  }

  Future<void> signIn() async {
    try {
      final result = await AuthServices().login(
        state.email!,
        state.password!,
      );

      if (result) {
        emit(state.copyWith(isSuccess: true));
      } else {
        throw const AuthException('Login Failed');
      }
    } catch (e) {
      emit(state.copyWith(isError: true, errorMsg: e.toString()));
    }
  }
}
