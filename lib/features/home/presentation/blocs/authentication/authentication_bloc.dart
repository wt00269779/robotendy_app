import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:robo_app/core/services/local_storage_service.dart';
import 'package:robo_app/core/services/user_service.dart';
import 'package:robo_app/features/home/presentation/blocs/authentication/bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserService userService;

  AuthenticationBloc({@required this.userService})
      : assert(userService != null),
        super(null);

  AuthenticationState get initialState => AuthenticationUnintitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    print("TESTtest");
    if (event is AppStarted) {

      final bool firstStartApp =
          LocalStorageService.getString("firstStartApp") == '';

      print("FIRST : " + firstStartApp.toString());
      if (firstStartApp) {
        yield AuthenticationUnauthenticated(firstStartApp: true);
        print("CHEKC");
      } else {
        final bool hasToken = await userService.hasToken();
        print("TOKEN : "+ hasToken.toString());
        if (hasToken) {
          print("1111111");
          yield AuthenticationAuthenticated(token: await userService.getToken());
        } else {
          yield AuthenticationUnauthenticated();
        }
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userService.persistToken(event.token);
      yield AuthenticationAuthenticated(token: event.token);
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userService.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
