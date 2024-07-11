import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_jakarta/models/user_contact.dart';
import 'package:smart_jakarta/services/user_data_service.dart';

part 'contact_page_state.dart';

class ContactPageCubit extends Cubit<ContactPageState> {
  ContactPageCubit() : super(ContactPageLoadingState());

  Future<void> fetchUserContact() async {
    try {
      final userContact = await UserDataService().fetchUserContact();

      if (userContact != null) {
        emit(ContactPageLoadedState(userContact));
      } else {
        emit(ContactPageEmptyState());
      }
    } catch (e) {
      emit(ContactPageErrorState(e.toString()));
    }
  }
}
