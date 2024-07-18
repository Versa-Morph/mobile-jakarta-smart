import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_jakarta/services/auth_services.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  Future<void> signIn(String email, String password) async {
    emit(SignInLoading());
    try {
      final result = await AuthServices().login(
        email,
        password,
      );

      if (result == true) {
        emit(SignInSucces());
      } else {
        emit(const SignInError('Username atau Password salah'));
      }
    } catch (e) {
      emit(SignInError(e.toString()));
    }
  }
}
