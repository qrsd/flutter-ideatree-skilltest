import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:local_auth/local_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

/// Login BLoC that checks Touch ID and Facebook authentication.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LocalAuthentication _auth;
  FacebookLogin _fb;

  /// Constructor and initializes local auth package.
  LoginBloc() : super(LoginNotAuthenticated()) {
    _auth = LocalAuthentication();
    _fb = FacebookLogin();
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginBackEvent) {
      yield* _mapLoginBackEventToState();
    } else if (event is LoginFaceBookEvent) {
      yield* _mapLoginFaceBookEvent();
    } else if (event is LoginTouchEvent) {
      yield* _mapLoginTouchEventToState();
    }
  }

  /// Yields LoginNotAuthenticated when the back button is pressed
  Stream<LoginState> _mapLoginBackEventToState() async* {
    yield LoginNotAuthenticated();
  }

  /// Yields LoginAuthenticated after user successfully logs in through
  /// Facebook.
  Stream<LoginState> _mapLoginFaceBookEvent() async* {
    var result = await _fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (result.status) {
      case FacebookLoginStatus.Success:
        final accessToken = result.accessToken;
        yield LoginAuthenticated();
        break;
      case FacebookLoginStatus.Cancel:
        break;
      case FacebookLoginStatus.Error:
        break;
    }
  }

  /// Yields LoginAuthenticated after user successfully logs in through
  /// Touch ID.
  Stream<LoginState> _mapLoginTouchEventToState() async* {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (canCheckBiometrics) {
      var authenticated =
          await _auth.authenticateWithBiometrics(localizedReason: 'Login');

      if (authenticated) {
        yield LoginAuthenticated();
      }
    }
  }
}
