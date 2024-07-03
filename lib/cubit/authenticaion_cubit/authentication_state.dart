part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class Authenticated extends AuthenticationState {}

final class Unauthenticated extends AuthenticationState {}
