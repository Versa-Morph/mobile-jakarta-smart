import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_jakarta/models/user_bio.dart';
import 'package:smart_jakarta/services/user_data_service.dart';

part 'add_profile_state.dart';

class AddProfileCubit extends Cubit<AddProfileState> {
  AddProfileCubit() : super(AddProfileLoading());

  Future<void> fetchUserBio() async {
    try {
      final userBio = await UserDataService().fetchUserBio();

      if (userBio != null) {
        emit(UpdateProfileState(userBio));
      } else {
        emit(CreateProfileState());
      }
    } catch (e) {
      emit(AddProfileError(e.toString()));
    }
  }

  Future<void> saveProfile({
    required String phoneNumber,
    required String nik,
    XFile? profilePict,
    required String fullName,
    required String nickname,
    required String city,
    required int age,
    required String bloodtype,
    required int height,
    required int weight,
    required String address,
  }) async {
    emit(AddProfileLoading());

    try {
      if (profilePict != null) {
        final result = await UserDataService().storeUserBio(
          profilePict: profilePict,
          phoneNumber: phoneNumber,
          nik: nik,
          fullName: fullName,
          nickname: nickname,
          city: city,
          age: age,
          bloodtype: bloodtype,
          height: height,
          weight: weight,
          address: address,
        );

        if (result == true) {
          emit(AddProfileSuccess());
        } else {
          emit(const AddProfileError('Error Saving Data'));
        }
      } else {
        emit(const AddProfileError('Picture Cannot Empty'));
      }
    } catch (e) {
      emit(AddProfileError(e.toString()));
    }
  }
}
