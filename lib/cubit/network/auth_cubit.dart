import 'dart:convert';

import 'package:blogonomy/cubit/locator_services.dart';
import 'package:blogonomy/cubit/network/app_auth.dart';
import 'package:blogonomy/cubit/network/auth_state.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  //final SubscriptionRepository subscriptionRepository;

  final FlutterAppAuth appAuth = sl<FlutterAppAuth>();
  final FlutterSecureStorage secureStorage = sl<FlutterSecureStorage>();
  final SharedPreferences sharedPreferences = sl<SharedPreferences>();

  final String accessTokenKey = 'access_token';
  final String refreshTokenKey = 'refresh_token';
  final String accessTokenExpirationDateTimeKey =
      'access_token_expiration_date_time';
  final String idTokenKey = 'id_token';

  AuthCubit() : super(EmptyState());

  Future<void> check() async {
    //   if (state is InProcessState) return;

    final currentState = state;

    if (currentState is LoginedState) {
      return;
    }

    //   emit(InProcessState());

    final storedRefreshToken = await secureStorage.read(key: refreshTokenKey);
    final storedAccessToken = await secureStorage.read(key: accessTokenKey);
    if (storedRefreshToken == null) {
      emit(LogoutedState());
      return;
    }
    if (storedAccessToken == null) {
      refresh();
      return;
    }
    AppAuth.accessToken = storedAccessToken;
    emit(LoginedState());
  }

  Future<void> refresh() async {
    try {
      final storedRefreshToken = await secureStorage.read(key: refreshTokenKey);
      final TokenResponse? result = await appAuth
          .token(TokenRequest(AppAuth.clientId, AppAuth.redirectUrl,
              refreshToken: storedRefreshToken,
              discoveryUrl: AppAuth.discoveryUrl,
              //issuer: AppAuth.issuer,
              scopes: AppAuth.scopes));

      await saveTokens(result!.accessToken, result.refreshToken, result.idToken,
          result.accessTokenExpirationDateTime);

      final idToken = _parseIdToken(result.idToken!);
      final profile = await _getUserDetails(result.accessToken!);

      final userName = idToken['name'];
      //picture = profile['picture'];
    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      logOut();
    }
  }

  Future<void> logOut() async {
    //  emit(InProcessState());
    print("Logout");
    await secureStorage.delete(key: refreshTokenKey);
    await secureStorage.delete(key: accessTokenKey);
    await sharedPreferences.remove(accessTokenExpirationDateTimeKey);
    await sharedPreferences.remove(idTokenKey);
    AppAuth.accessToken = null;

    emit(LogoutedState());
    print("Logout ended");
  }

  Future<void> signIn() async {
    //  if (state is InProcessState) return;

    final currentState = state;

    if (currentState is LoginedState) {}

    //emit(InProcessState());
    print("result");
    print(
      AppAuth.clientId,
    );
    print(
      AppAuth.redirectUrl,
    );
    final AuthorizationTokenResponse? result =
        await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        AppAuth.clientId,
        AppAuth.redirectUrl,
        //clientSecret: AppAuth.clientSecret,
        serviceConfiguration: AppAuth.serviceConfiguration,
        scopes: AppAuth.scopes,
        //preferEphemeralSession: preferEphemeralSession,
      ),
    );

    // this code block demonstrates passing in values for the prompt parameter. in this case it prompts the user login even if they have already signed in. the list of supported values depends on the identity provider
    // final AuthorizationTokenResponse result = await _appAuth.authorizeAndExchangeCode(
    //   AuthorizationTokenRequest(_clientId, _redirectUrl,
    //       serviceConfiguration: _serviceConfiguration,
    //       scopes: _scopes,
    //       promptValues: ['login']),
    // );
    print("result = $result");
    if (result == null) {
      emit(ErrorState("undefined"));
    } else {
      await saveTokens(result.accessToken, result.refreshToken, result.idToken,
          result.accessTokenExpirationDateTime);
      print("accessToken = ${result.accessToken}");
    }

    emit(LoginedState());
  }

  Map<String, dynamic> _parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Future<Map<String, dynamic>> _getUserDetails(String accessToken) async {
    final url = 'https://${AppAuth.issuer}/userinfo';
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user details');
    }
  }

  Future<void> saveTokens(String? accessToken, String? refreshToken,
      String? idToken, DateTime? accessTokenExpirationDateTime) async {
    try {
      await secureStorage.write(key: refreshTokenKey, value: refreshToken);
      await secureStorage.write(key: accessTokenKey, value: accessToken);
      AppAuth.accessToken = accessToken;
    } catch (error, ee) {
      print(error);
      print(ee);
    }

    try {
      await sharedPreferences.setString(accessTokenExpirationDateTimeKey,
          accessTokenExpirationDateTime.toString());
      await sharedPreferences.setString(idTokenKey, idToken!);
    } catch (error, ee) {
      print(error);
      print(ee);
    }
  }

  Future<void> GetCategoryUser() async {
    final response = await http.post(
        Uri.parse(
            "https://service-blogonomy.maksatlabs.ru/api/Category/GetCategoryUser"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    print(response.body);
  }
}
