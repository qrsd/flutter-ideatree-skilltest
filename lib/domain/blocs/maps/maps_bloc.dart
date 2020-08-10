import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

part 'maps_event.dart';
part 'maps_state.dart';

/// Maps BLoC responsible for finding current location, destination, creaing
/// markers and polylines.
class MapsBloc extends Bloc<MapsEvent, MapsState> {
  /// Contains current and destination markers.
  Set<Marker> markers;

  /// Contains polylines from current to destination.
  Set<Polyline> polylines;

  /// Contains latitude and longitude coordinates.
  List<LatLng> polyCoords;

  /// Contains current location.
  LatLng currentLocation;

  /// Polyline points.
  PolylinePoints polylinePoints;

  /// Constructor
  MapsBloc() : super(MapsInitial()) {
    markers = {};
    polylines = {};
    polyCoords = [];
    polylinePoints = PolylinePoints();
  }

  @override
  Stream<MapsState> mapEventToState(
    MapsEvent event,
  ) async* {
    if (event is MapsGetCurrentLocationEvent) {
      yield* _mapMapsGetCurrentLocationEventToState();
    }
  }

  /// Yields MapsLoaded state after generating markers and polylines between
  /// the locations.
  Stream<MapsState> _mapMapsGetCurrentLocationEventToState() async* {
    /// Get current location and create marker
    var _getCurrentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentLocation =
        LatLng(_getCurrentLocation.latitude, _getCurrentLocation.longitude);
    markers.add(
      Marker(
          markerId: MarkerId('source'),
          position: currentLocation,
          infoWindow: InfoWindow(title: 'Your Location')),
    );

    /// Generate a random location nearby and add marker
    var random = Random();
    var min = .01;
    var max = .02;
    var r = min + random.nextDouble() * (max - min);
    var destinationLocation = LatLng(
        _getCurrentLocation.latitude - r, _getCurrentLocation.longitude + r);
    markers.add(
      Marker(
          markerId: MarkerId('dest'),
          position: destinationLocation,
          infoWindow: InfoWindow(title: 'Destination')),
    );

    /// Create polyline between the two locations
    var result = await polylinePoints.getRouteBetweenCoordinates(
      'ENTER GOOGLE API KEY HERE',
      PointLatLng(currentLocation.latitude, currentLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((point) {
        polyCoords.add(LatLng(point.latitude, point.longitude));
      });
    }

    var polyline = Polyline(
        polylineId: PolylineId('poly'),
        color: Color.fromARGB(255, 40, 122, 198),
        points: polyCoords);

    polylines.add(polyline);

    yield MapsLoaded(
      markers,
      polylines,
      currentLocation,
    );
  }
}
