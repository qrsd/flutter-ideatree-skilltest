part of 'maps_bloc.dart';

/// Abstract of Maps events.
abstract class MapsEvent extends Equatable {
  /// Constructor
  const MapsEvent();

  @override
  List<Object> get props => [];
}

/// Event fires when getting current location.
class MapsGetCurrentLocationEvent extends MapsEvent {}
