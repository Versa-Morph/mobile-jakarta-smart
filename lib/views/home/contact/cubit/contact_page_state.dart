part of 'contact_page_cubit.dart';

sealed class ContactPageState extends Equatable {
  const ContactPageState();

  @override
  List<Object> get props => [];
}

final class ContactPageLoadingState extends ContactPageState {}

final class ContactPageLoadedState extends ContactPageState {}

final class ContactPageEmptyState extends ContactPageState {}

final class ContactPageErrorState extends ContactPageState {
  const ContactPageErrorState(this.errorMsg);
  final String errorMsg;
}
