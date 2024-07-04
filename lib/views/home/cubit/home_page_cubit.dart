import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/models/user_model.dart';
import 'package:smart_jakarta/services/auth_services.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(const HomePageState());

  Future<void> fetchUserCredential() async {
    try {
      final userCredential = await AuthServices().fetchUserCredential();

      if (userCredential != null) {
        emit(HomePageLoaded(userCredential));
      } else {
        emit(const HomePageError('No user detected'));
      }
    } catch (e) {
      emit(HomePageError(e.toString()));
    }
  }
}
