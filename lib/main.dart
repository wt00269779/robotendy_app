import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robo_app/core/services/local_storage_service.dart';
import 'package:robo_app/features/home/presentation/blocs/home/home_bloc.dart';
import 'package:robo_app/features/home/presentation/blocs/initial_app/initail_app_bloc.dart';
import 'package:robo_app/features/home/presentation/blocs/login/login_bloc.dart';
import 'package:robo_app/features/home/presentation/pages/splash_page.dart';
import 'features/home/presentation/blocs/authentication/authentication_bloc.dart';
import 'features/home/presentation/blocs/authentication/bloc.dart';
import 'features/home/presentation/blocs/home/bloc.dart';
import 'features/home/presentation/blocs/initial_app/bloc.dart';
import 'flow_bloc_observer.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.getInstance();
  await di.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<HomeBloc>(
        create: (context) => sl<HomeBloc>()..add(GetListPopularCocktail()),
      ),
      BlocProvider<BottomNavigationBloc>(
        create: (context) => sl<BottomNavigationBloc>(),
      ),
      BlocProvider<LoginBloc>(
        create: (context) => sl<LoginBloc>(),
      ),
      BlocProvider<AuthenticationBloc>(
        create: (context) => sl<AuthenticationBloc>()..add(AppStarted()),
      ),
    ],
    child: RoboApp(),
  ));
}

class RoboApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Robotendy App',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(163, 106, 224, 1),
        accentColor: Colors.purple.shade600,
      ),
      home: SplashPage(),
    );
  }
}
