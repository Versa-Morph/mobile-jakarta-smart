import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_page_state.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  ProfilePageCubit() : super(ProfilePageInitial());

  Future<void> fetchUserBio() async {}
}
