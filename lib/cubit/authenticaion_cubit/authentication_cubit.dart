import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_jakarta/services/auth_services.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(Unauthenticated());

  final AuthServices _authServices = AuthServices();

  Future<void> checkAuthStatus() async {
    final result = await _authServices.isAuthenticated();

    if (result == true) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> logout() async {
    await _authServices.logout();
    emit(Unauthenticated());
  }
}
