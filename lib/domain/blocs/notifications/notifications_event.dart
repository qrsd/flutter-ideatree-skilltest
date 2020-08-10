part of 'notifications_bloc.dart';

/// Abstract of Notification Events
abstract class NotificationsEvent extends Equatable {
  /// Constructor
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

/// Event fires to find device token, for testing purposes.
class NotificationsPrintTokenEvent extends NotificationsEvent {}
