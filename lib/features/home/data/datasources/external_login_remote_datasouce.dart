import 'dart:convert';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:robo_app/core/error/exception.dart';

abstract class ExternalLoginRemoteDataSource {
  Future<Map<String,String>> getDataFacebook();
  Future<Map<String,String>> getDataGoogle();
}

class ExternalLoginRemoteDataSourceImpl implements ExternalLoginRemoteDataSource {
  @override
  Future<Map<String, String>> getDataFacebook() async {
    final FacebookLogin facebookSignIn = new FacebookLogin();
      final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v9.0/me?fields=id,name,email&access_token=${token}');
        final profile = json.decode(graphResponse.body);
        print(profile.toString());
        
        return {
          "providerKey" : profile["id"],
          "email" : profile["email"],
          "displayName" : profile["name"]
        };
        break;
  
      case FacebookLoginStatus.cancelledByUser:
        throw ServerException();
        break;
      case FacebookLoginStatus.error:
        throw ServerException();
        break;
    }
    throw ServerException();

  }

  @override
  Future<Map<String, String>> getDataGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: "180825543405-phodu5mqjijj99vg2934i2v6geev4urc.apps.googleusercontent.com"
      );
      await googleSignIn.signIn();
      var account = googleSignIn.currentUser;
      return {
        "providerKey" : account.id,
        "email" : account.email,
        "displayName" : account.displayName
      };
      
    }catch (Exception) {
      throw ServerException();
    }
    

  }

}