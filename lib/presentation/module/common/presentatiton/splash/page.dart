import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../helper/flushbar.dart';
import '../../../../../presentation/bloc/firebase_message_bloc.dart';
import '../../../../../presentation/bloc/language_bloc.dart';
import '../../../../../config/style_config.dart';
import '../../../../core/app.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    context.read<FirebaseMessageBloc>().configureFirebaseMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<FirebaseMessageBloc, FirebaseMessageState>(
            listener: (BuildContext context, FirebaseMessageState state) async {
              if (state is FirebaseMessageGetTokenState) {
                await Future.delayed(Duration(milliseconds: 500));
                try {
                  App.main.firebaseToken = state.token;
                  Modular.to.navigate('/auth/login');
                } catch (e) {
                  showFlushbar(
                      context, 'ERROR WHILE GETTING FIREBASE TOKEN -> $e');
                }
                try {
                  context.read<LanguageBloc>()..loadLocal();
                } catch (e) {
                  showFlushbar(context, 'ERROR WHILE LOAD LANGUAGE -> $e');
                }
              }
            },
          ),
        ],
        child: Center(
          child: Text(
            "ERPLAN",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
