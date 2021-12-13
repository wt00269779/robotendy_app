import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robo_app/core/services/user_service.dart';
import 'package:robo_app/features/home/presentation/blocs/authentication/bloc.dart';
import 'package:robo_app/features/home/presentation/blocs/home/bloc.dart';
import 'package:robo_app/features/home/presentation/blocs/initial_app/bloc.dart';
import 'package:robo_app/features/home/presentation/blocs/login/login_bloc.dart';
import 'package:robo_app/features/home/presentation/pages/main/authen/profile_page.dart';
import 'package:robo_app/features/home/presentation/pages/main/favorite/favorite_page.dart';
import 'package:robo_app/features/home/presentation/widgets/loading_indicator.dart';
import 'package:robo_app/injection_container.dart';

import 'authen/login/login_page.dart';
import 'home/home_page.dart';

class InitailPage extends StatefulWidget {
  @override
  _InitailPageState createState() => _InitailPageState();
}

class _InitailPageState extends State<InitailPage> {
  BottomNavigationBloc bloc;
  UserService userService;
  int indexPage;
  AuthenticationBloc authenticationBloc;
  LoginBloc loginBloc;

  @override
  void initState() {

    bloc = BlocProvider.of<BottomNavigationBloc>(context)..add(NavigationInitial());
    indexPage = 0;
    userService = sl<UserService>();
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    loginBloc = LoginBloc(
      userService: userService,
      authenticationBloc: authenticationBloc,
    );
    print("initFirst");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is PageLoading) {
          return LoadingIndicator();
        } else if (state is HomePageLoaded) {
          print("HOME PAGE");
            return HomePage(bloc: bloc);
        } else if (state is FavoritePageLoaded) {
          return FavoritePage(bloc: bloc);
        } else if (state is AuthenPageLoaded) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            bloc: authenticationBloc,
            builder: (BuildContext context, AuthenticationState state) {
              if (state is AuthenticationAuthenticated) {
                return ProfilePage(
                  bloc: bloc,
                );
              }
              if (state is AuthenticationUnauthenticated) {
                return LoginPage(bloc: bloc, loginBloc: loginBloc);
              }
              
              return LoadingIndicator();
            },
          );
        }
        return LoadingIndicator();
      },
    );
  }
}
