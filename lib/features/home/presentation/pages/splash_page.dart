import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robo_app/features/home/presentation/blocs/authentication/bloc.dart';
import 'package:robo_app/features/home/presentation/pages/main/initial_page.dart';
import 'package:robo_app/features/home/presentation/pages/tutorial_page.dart';
import 'package:robo_app/features/home/presentation/widgets/loading_indicator.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final authenBloc = BlocProvider.of<AuthenticationBloc>(context);

    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: BlocProvider(
        create: (context) => authenBloc,
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: authenBloc,
          builder: (context, state) {
            if (state is AuthenticationUnauthenticated) {
              if (state.firstStartApp) {
                
                return TutorialPage();
              } else {
                return InitailPage();
              }
            }
            if (state is AuthenticationAuthenticated) {
              return InitailPage();
            }
            return LoadingIndicator();
          },
        ),
      ),
      title: Text(
        'Robotendy',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      backgroundColor: Colors.white,
      useLoader: false,
    );
  }
}
