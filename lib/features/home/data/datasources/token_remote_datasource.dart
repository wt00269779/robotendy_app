import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:robo_app/features/home/data/models/token_model.dart';
import 'package:robo_app/features/home/domain/entities/token.dart';
import 'package:http/http.dart' as http;

abstract class TokenRemoteDataSource {
  Future<Token> accessUser(String username, String password,String provider,String providerKey,String displayName);
  Future<Token> getNewToken(String refreshToken);
  Future<Map<String,dynamic>> registerUser(String username,String password);
}

class TokenRemoteDataSourceImpl implements TokenRemoteDataSource {
   final http.Client client;

  TokenRemoteDataSourceImpl({@required this.client});
  
  @override
  Future<Token> accessUser(String username, String password,String provider,String providerKey,String displayName) async {
    var url = 'https://robotendy.com/token';
    Map<String, dynamic> data = {
      'grant_type': 'password',
      'username': username,
      'password': password,
      'client_id': 'FlutterApp',
      'client_secret': 'roboAppInno',
      'provider' : provider,
      'providerKey' : providerKey,
      'displayName' : displayName,
    };

    String encodedBody = data.keys.map((key) => "$key=${data[key]}").join("&");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: encodedBody,
    );
    TokenModel token = TokenModel.fromJson(json.decode(response.body));

    return token;
  }

  @override
  Future<Token> getNewToken(String refreshToken) async {
    var url = 'https://robotendy.com/token';
    Map<String, dynamic> data = {
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken,
      'client_id': 'FlutterApp',
      'client_secret': 'roboAppInno'
    };

    String encodedBody = data.keys.map((key) => "$key=${data[key]}").join("&");

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: encodedBody,
    );
    TokenModel token = TokenModel.fromJson(json.decode(response.body));

    return token;
  }

  @override
  Future<Map<String,dynamic>> registerUser(String username, String password) async {
    var url = 'https://robotendy.com/api/Accounts/Register';
    Map<String, dynamic> data = {
      'userName': username,
      'password': password,
      'confirmPassword': password,
    };

    String encodedBody = data.keys.map((key) => "$key=${data[key]}").join("&");

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: encodedBody,
    );
    Map<String,dynamic> map = json.decode(response.body);
    return map;
  }
}
