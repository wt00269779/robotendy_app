import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Token extends Equatable {
  final String accessToken;
  final String refreshToken;
  final String expires;

  Token({
    @required this.accessToken,
    @required this.refreshToken,
    @required this.expires,
  });

  @override
  List<Object> get props => [
    this.accessToken,
    this.refreshToken,
    this.expires,
  ];
}
