part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object?> get props => [];
}

class HomePageLoading extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final UserModel user;
  const HomePageLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class HomePageError extends HomePageState {
  final String errorMsg;
  const HomePageError(this.errorMsg);
}
