import 'package:robo_app/features/home/domain/entities/token.dart';

class TokenModel extends Token {
  TokenModel({
    accessToken,
    refreshToken,
    expires,
  }) : super(
          accessToken: accessToken,
          refreshToken: refreshToken,
          expires: expires,
        );

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      expires: json['.expires'],
    );
  }
}
