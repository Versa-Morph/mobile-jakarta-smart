import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_jakarta/services/auth_services.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp(
    String username,
    String email,
    String password,
    String rePassword,
  ) async {
    emit(SignUpLoading());
    try {
      final result = await AuthServices().register(
        username,
        email,
        password,
        rePassword,
      );
      if (result == true) {
        emit(SignUpSucces());
      } else {
        emit(const SignUpError('Register Failed'));
      }
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }
}
