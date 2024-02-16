import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthIntialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthTakeOtp extends AuthState {}

class AuthVerificationState extends AuthState {}

class AuthErrorState extends AuthState {
  String error;
  AuthErrorState(this.error);
}

class AuthCodeSendState extends AuthState {}

class AuthLoggedInState extends AuthState {
  final User firebaseUser;
  AuthLoggedInState(this.firebaseUser);
}

class AuthLoggedOutState extends AuthState {}
