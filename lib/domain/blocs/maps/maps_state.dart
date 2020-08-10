part of 'maps_bloc.dart';

/// Abstract of Maps state.
abstract class MapsState extends Equatable {
  /// Constructor
  const MapsState();

  @override
  List<Object> get props => [];
}

/// Initial State.
class MapsInitial extends MapsState {}

/// State containing markers, polyline, and current location.
class MapsLoaded extends MapsState {
  /// Contains map markers.
  final Set<Marker> markers;

  /// Contains polylines between locations.
  final Set<Polyline> polylines;

  /// Contains current location.
  final LatLng currentLocation;

  /// Constructor
  MapsLoaded(this.markers, this.polylines, this.currentLocation);

  @override
  List<Object> get props => [markers, polylines, currentLocation];
}
