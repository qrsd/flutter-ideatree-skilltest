import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './domain/blocs/my_bloc_observer.dart';
import './presentation/app.dart';

/// Run app and setup BLoC delegate
void main() {
  Bloc.observer = MyBlocObserver();
  runApp(App());
}
