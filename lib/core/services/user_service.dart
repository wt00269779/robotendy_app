import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:robo_app/core/error/failures.dart';
import 'package:robo_app/core/services/local_storage_service.dart';
import 'package:robo_app/core/services/util.dart';
import 'package:robo_app/features/home/domain/entities/token.dart';
import 'package:robo_app/features/home/domain/usecases/account/access_user.dart';

import 'secure_storage_service.dart';

class UserService {
  final SecureStorageServeice secureStorageServeice;
  final AccessUser accessUser;

  UserService({
    @required this.secureStorageServeice,
    @required this.accessUser,
  });

  Future<Either<Failure, Token>> authenticate({
    @required String username,
    @required String password,
    @required String provider,
    @required String displayName,
    @required String providerKey, 
  }) async {
    final failOrData =
        await accessUser(Params(username: username, password: password,provider: provider,providerKey: providerKey,displayName: displayName));
    return failOrData.fold(
      (failure) => Left(failure),
      (token) => Right(token),
    );
  }

  Future<void> deleteToken() async {
    await secureStorageServeice.deleteSecureDataAll();
    return;
  }

  Future<void> persistToken(Token token) async {
    await secureStorageServeice.writeSecureData("expires", token.expires);
    await secureStorageServeice.writeSecureData("accessToken", token.accessToken);
    await secureStorageServeice.writeSecureData("refreshToken", token.refreshToken);
    return;
  }

  //Future<Either<Failure, bool>> hasToken() async {
  Future<bool> hasToken() async {
  
    var token = await getToken();
    if (token != null) {
      print(Util.covertGwtToDateTime(token.expires));
      if ((Util.covertGwtToDateTime(token.expires)).compareTo(DateTime.now()) < 1) {

      }
      return true;
    }

    return false;
  }

  Future<bool> firstStartApp() async {
    if (LocalStorageService.getString("firstAppStart") == '') {
      return false;
    }
    return true;
  }

  Future<Token> getToken() async {
    var date = await secureStorageServeice.readSecureData("expires");
    if(date != null){
      print("DATAAAAAA : " + date);
      var accessToken = await secureStorageServeice.readSecureData("accessToken");
      var refreshToken = await secureStorageServeice.readSecureData("refreshToken");
      return new Token(accessToken: accessToken, refreshToken: refreshToken, expires: date);
    }
    return null;

  } 
}
