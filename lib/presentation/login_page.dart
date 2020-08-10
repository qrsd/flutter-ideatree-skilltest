import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:local_auth/local_auth.dart';

import '../domain/blocs/login/login_bloc.dart';
import 'map_page.dart';

/// Responsible for logging users in with Touch ID or Facebook
class LoginPage extends StatelessWidget {
  /// Initializes local auth
  final LocalAuthentication localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1440, height: 2960, allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () async {
              BlocProvider.of<LoginBloc>(context).add(LoginTouchEvent());
            },
            child: Icon(
              Icons.fingerprint,
              size: ScreenUtil().setHeight(300),
            ),
          ),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginAuthenticated) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapPage(),
                  ),
                );
              }
            },
            child: Container(),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(100),
          ),
          InkWell(
            onTap: () {
              BlocProvider.of<LoginBloc>(context).add(LoginFaceBookEvent());
            },
            child: Image(
              image: AssetImage('assets/facebook.png'),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(100),
          ),
        ],
      ),
    );
  }
}
