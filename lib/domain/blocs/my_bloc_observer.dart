import 'package:bloc/bloc.dart';

/// Bloc delegate used to test by printing events/transitions/errors.
class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Cubit cubit, Object event) {
    super.onEvent(cubit, event);
    //print('$event   ${DateTime.now()}');
  }

  @override
  void onTransition(Cubit cubit, Transition transition) {
    super.onTransition(cubit, transition);
    //print(transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stacktrace) {
    super.onError(cubit, error, stacktrace);
    print(cubit);
    print(error);
    print(stacktrace);
  }
}
