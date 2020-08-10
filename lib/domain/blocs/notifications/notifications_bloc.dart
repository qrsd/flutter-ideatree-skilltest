import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

/// Notification BLoC setups Firebase messaging to receive push notifications
/// from Firebase cloud messaging.
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging _firebaseMessaging;

  /// Constructor and initializes Firebase messaging
  NotificationsBloc() : super(NotificationsInitial()) {
    _firebaseMessaging = FirebaseMessaging();
  }

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    if (event is NotificationsPrintTokenEvent) {
      yield* _mapNotificationsPrintTokenEventToState();
    }
  }

  /// Prints token for testing push notifications.
  Stream<NotificationsState> _mapNotificationsPrintTokenEventToState() async* {
    var token = await _firebaseMessaging.getToken();
    print("FirebaseMessaging token: $token");
  }
}
