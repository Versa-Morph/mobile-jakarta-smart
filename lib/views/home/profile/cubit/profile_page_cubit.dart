import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_jakarta/models/user_bio.dart';
import 'package:smart_jakarta/services/user_data_service.dart';

part 'profile_page_state.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  ProfilePageCubit() : super(ProfilePageInitial());

  Future<void> fetchUserBio() async {
    emit(ProfilePageLoading());
    try {
      final userBio = await UserDataService().fetchUserBio();

      if (userBio != null) {
        emit(ProfilePageLoaded(userBio));
      } else {
        emit(ProfilePageEmpty());
      }
    } catch (e) {
      emit(ProfilePageError(e.toString()));
    }
  }
}
