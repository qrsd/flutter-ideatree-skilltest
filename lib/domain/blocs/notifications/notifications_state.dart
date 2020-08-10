part of 'notifications_bloc.dart';

/// Abstract of Notification state.
abstract class NotificationsState extends Equatable {
  /// Constructor
  const NotificationsState();

  @override
  List<Object> get props => [];
}

/// Initial state.
class NotificationsInitial extends NotificationsState {}
