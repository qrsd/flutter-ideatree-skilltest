import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/blocs/login/login_bloc.dart';
import '../domain/blocs/notifications/notifications_bloc.dart';
import './login_page.dart';

/// Presets and routes
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) {
            return LoginBloc();
          },
        ),
        BlocProvider<NotificationsBloc>(
          create: (context) {
            return NotificationsBloc();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xff121212),
        ),
        initialRoute: '/login',
        // ignore: missing_return
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(
                  builder: (_) => LoginPage(), settings: settings);
          }
        },
      ),
    );
  }
}
