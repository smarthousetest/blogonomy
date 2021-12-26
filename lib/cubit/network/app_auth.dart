import 'package:flutter_appauth/flutter_appauth.dart';

class AppAuth {
  bool _isBusy = false;
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  static const String clientId = "mvc";
  static const String redirectUrl = "com.blogonomy.mobile:/auth";
  static const String issuer = 'https://passport-blogonomy.maksatlabs.ru';
  static const String discoveryUrl =
      'https://passport-blogonomy.maksatlabs.ru/.well-known/openid-configuration';

  static const List<String> scopes = <String>[
    'openid',
    //'profile',
    //  'email',
    'offline_access',
    'api1'
  ];
  static String? accessToken;
//  static String? refreshToken;
  static String? userInfo;
  static String? userName;
//  static String? idToken;
//  static DateTime? accessTokenExpirationDateTime;

  static AuthorizationServiceConfiguration serviceConfiguration =
      // ignore: prefer_const_constructors
      AuthorizationServiceConfiguration(
    authorizationEndpoint:
        'https://passport-blogonomy.maksatlabs.ru/Account/Login',
    tokenEndpoint:
        'https://passport-blogonomy.maksatlabs.ru/Account/Login/token',
  );
}
