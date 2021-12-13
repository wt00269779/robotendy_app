import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:robo_app/features/home/domain/entities/token.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationUnintitialized extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUninitialized';
}

class AuthenticationAuthenticated extends AuthenticationState {
  final Token token;

  AuthenticationAuthenticated({@required this.token});
  @override
  String toString() => 'AuthenticationAuthenticated';
}

class AuthenticationUnauthenticated extends AuthenticationState {
  final bool firstStartApp;

  AuthenticationUnauthenticated({this.firstStartApp = false});

  @override
  String toString() => 'AuthenticationUnauthenticated';
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoading';
} 
