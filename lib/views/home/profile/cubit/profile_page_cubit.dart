import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_jakarta/models/user_bio.dart';
import 'package:smart_jakarta/services/user_data_service.dart';

part 'profile_page_state.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  ProfilePageCubit() : super(ProfilePageLoadingState());

  Future<void> fetchUserBio() async {
    try {
      final userBio = await UserDataService().fetchUserBio();

      if (userBio != null) {
        emit(ProfilePageLoadedState(userBio));
      } else {
        emit(ProfilePageEmptyState());
      }
    } catch (e) {
      emit(ProfilePageErrorState(e.toString()));
    }
  }
}
