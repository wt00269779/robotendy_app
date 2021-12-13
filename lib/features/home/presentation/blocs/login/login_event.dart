part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;
  final String provider;
  final String displayName;

  LoginButtonPressed({
    @required this.username,
    @required this.password,
    @required this.provider,
    @required this.displayName,
  });

  @override
  List<Object> get props => [username, password,provider,displayName];
}
