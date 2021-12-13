import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:robo_app/core/error/failures.dart';
import 'package:robo_app/core/services/user_service.dart';
import 'package:robo_app/core/usecases/usecase.dart';
import 'package:robo_app/features/home/domain/usecases/external_login/get_data_facebook.dart';
import 'package:robo_app/features/home/domain/usecases/external_login/get_data_google.dart';
import 'package:robo_app/features/home/presentation/blocs/authentication/bloc.dart';

import '../../../../../injection_container.dart';

part 'login_event.dart';
part 'login_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INTERNET_FAILURE_MESSAGE = 'Internet Failure';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserService userService;
  final AuthenticationBloc authenticationBloc;
  final GetDataFacebook getDataFacebook = sl<GetDataFacebook>();
  final GetDataGoogle getDataGoogle = sl<GetDataGoogle>();
  
  LoginBloc({
    @required this.userService,
    @required this.authenticationBloc,
  })  : assert(userService != null),
        assert(authenticationBloc != null),
        super(null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    print("bloc test");
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      yield* _mapMethodLogin(event);
    } 
  }

  Stream<LoginState> _mapMethodLogin(LoginButtonPressed event) async* {
    String providerKey = "";
    String username = event.username;
    String password = event.password;
    String provider = event.provider;
    String displayName = event.displayName;


    if (event.provider != "Robotendy") {
      final failOrList =  event.provider == "Facebook" ?await getDataFacebook(NoParams()) : await getDataGoogle(NoParams());
      
      yield failOrList.fold(
        (failure) => LoginFailure(message: _mapFailureToMessage(failure)),
        (info) {
          print("Info " +info.toString());
          providerKey = info["providerKey"];
          username = info["email"];
          displayName = info["displayName"];
          return LoginLoading();
        },
      );
    }

    try {
        final token = await userService.authenticate(
          username: username,
          password: password,
          provider: provider,
          providerKey: providerKey,
          displayName: displayName,
        );
    
        yield token.fold(
          (failure) => LoginFailure(message: failure.toString()),
          (token) {
            print("TOKEN : " + token.accessToken);
            authenticationBloc.add(LoggedIn(token: token));
            return LoginInitial();
          },
        );
      } catch (error) {
        yield LoginFailure(message: error.toString());
      }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case InternetFailure:
        return INTERNET_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
