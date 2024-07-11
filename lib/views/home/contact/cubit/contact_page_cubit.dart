import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'contact_page_state.dart';

class ContactPageCubit extends Cubit<ContactPageState> {
  ContactPageCubit() : super(ContactPageLoadingState());
}
