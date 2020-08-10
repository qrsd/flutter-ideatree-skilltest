import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../domain/blocs/login/login_bloc.dart';
import '../domain/blocs/maps/maps_bloc.dart';

/// Injects Map BLoC for Map Page
class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapsBloc>(
      create: (context) {
        return MapsBloc()..add(MapsGetCurrentLocationEvent());
      },
      child: _MapPageInjected(),
    );
  }
}

class _MapPageInjected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            BlocProvider.of<LoginBloc>(context).add(LoginBackEvent());
            Navigator.pop(context);
          },
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<MapsBloc, MapsState>(
        builder: (context, state) {
          if (state is MapsLoaded) {
            return GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              tiltGesturesEnabled: false,
              markers: state.markers,
              polylines: state.polylines,
              initialCameraPosition: CameraPosition(
                target: state.currentLocation,
                zoom: 11,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
