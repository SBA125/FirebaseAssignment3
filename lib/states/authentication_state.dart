import 'package:firebase_assignment/models/user_model.dart';

class AuthenticationState {
  final MyUser? user;
  final bool isLoading;
  final String? error;

  AuthenticationState._({this.user, this.isLoading = false, this.error});

  factory AuthenticationState.initial() => AuthenticationState._();

  factory AuthenticationState.loading() => AuthenticationState._(isLoading: true);

  factory AuthenticationState.authenticated(MyUser user) => AuthenticationState._(user: user);

  factory AuthenticationState.unauthenticated() => AuthenticationState._();

  factory AuthenticationState.error(String error) => AuthenticationState._(error: error);
}
