part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure({@required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'LoginFailure { error: $message }';
}
