part of 'login_bloc.dart';

/// Abstract of Login state.
abstract class LoginState extends Equatable {
  /// Constructor
  const LoginState();

  @override
  List<Object> get props => [];
}

/// Initial state.
class LoginNotAuthenticated extends LoginState {}

/// State yielded after successful authentication of fingerprint.
class LoginAuthenticated extends LoginState {}
