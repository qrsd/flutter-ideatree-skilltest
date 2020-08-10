part of 'login_bloc.dart';

/// Abstract of Login events.
abstract class LoginEvent extends Equatable {
  /// Constructor
  const LoginEvent();

  @override
  List<Object> get props => [];
}

/// Event fires when the Touch ID button is pressed
/// to check biometrics.
class LoginTouchEvent extends LoginEvent {}

/// Event fires when trying to login with facebook.
class LoginFaceBookEvent extends LoginEvent {}

/// Event fires when the back button is pressed
/// on the map page.
class LoginBackEvent extends LoginEvent {}
