import 'dart:async';

import 'package:blogonomy/cubit/page_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';

class Transition extends StatefulWidget {
  const Transition({Key? key}) : super(key: key);

  @override
  _TransitionState createState() => _TransitionState();
}

class _TransitionState extends State<Transition> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool _isBusy = false;
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  String? _codeVerifier;
  String? _authorizationCode;
  String? _refreshToken;
  String? _accessToken;
  final TextEditingController _authorizationCodeTextController =
      TextEditingController();
  final TextEditingController _accessTokenTextController =
      TextEditingController();
  final TextEditingController _accessTokenExpirationTextController =
      TextEditingController();

  final TextEditingController _idTokenTextController = TextEditingController();
  final TextEditingController _refreshTokenTextController =
      TextEditingController();
  String _userInfo = '';

  //Для получения списка идентификаторов клиентов перейти по ссылке https://demo.identityserver.io
  final String _clientId = 'interactive.public';
  final String _redirectUrl = 'authorization:/oauthredirect'; // перенаправление
  final String _issuer = 'https://demo.identityserver.io'; // эмитент
  final String _discoveryUrl = // открытие
      'https://demo.identityserver.io/.well-known/openid-configuration';
  final List<String> _scopes = <String>[
    'openid',
    'profile',
    'email',
    'offline_access',
    'api'
  ];

  final _serviceConfiguration = const AuthorizationServiceConfiguration(
    authorizationEndpoint: 'https://demo.identityserver.io/connect/authorize',
    tokenEndpoint: 'https://demo.identityserver.io/connect/token',
    endSessionEndpoint: 'https://demo.identityserver.io/connect/endsession',
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: PageView(
          controller: _pageController,
          children: <Widget>[
            Scaffold(
              body: SafeArea(
                child: ListView(
                  children: [
                    const SizedBox(height: 32.0),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Авторизация',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF394759)),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Введите свой e-mail',
                          hintStyle: TextStyle(
                            fontFamily: 'Roboto-Regular.ttf',
                            fontSize: 15.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFA7B8C0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFC2D1D9), width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFC2D1D9), width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                        ),
                      ),
                    ),
                    const SizedBox(height: 33.0),
                    Container(
                      height: 52.0,
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_pageController.hasClients) {
                            _pageController.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: const Text(
                          'Далее',
                          style: TextStyle(
                            fontFamily: 'Roboto-Bold.ttf',
                            fontSize: 15.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF8D9BAC))),
                      ),
                    ),
                    const SizedBox(height: 40.0),
                  ],
                ),
              ),
            ),
            ////////////
            Scaffold(
              body: SafeArea(
                child: ListView(
                  children: [
                    const SizedBox(height: 32.0),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Подтвердите e-mail',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF394759)),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Введите код с почты',
                          hintStyle: TextStyle(
                            fontFamily: 'Roboto-Regular.ttf',
                            fontSize: 15.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFA7B8C0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFC2D1D9), width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFC2D1D9), width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                        ),
                      ),
                    ),
                    const SizedBox(height: 33.0),
                    Container(
                      height: 52.0,
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Отправить код',
                              style: TextStyle(
                                fontFamily: 'Roboto-Bold.ttf',
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF8D9BAC),
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFFFFFFFF))),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  2,
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: const Text(
                              'Далее',
                              style: TextStyle(
                                fontFamily: 'Roboto-Bold.ttf',
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF8D9BAC))),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40.0),
                  ],
                ),
              ),
            ),

            /////////
            /////////
            Scaffold(
              body: SafeArea(
                child: ListView(
                  children: [
                    const SizedBox(height: 32.0),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Пароль',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF394759)),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Придумайте пароль',
                          hintStyle: TextStyle(
                            fontFamily: 'Roboto-Regular.ttf',
                            fontSize: 15.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFA7B8C0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFC2D1D9), width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFC2D1D9), width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Повторите пароль',
                          hintStyle: TextStyle(
                            fontFamily: 'Roboto-Regular.ttf',
                            fontSize: 15.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFA7B8C0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFC2D1D9), width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFC2D1D9), width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                        ),
                      ),
                    ),
                    const SizedBox(height: 33.0),
                    Container(
                      height: 52.0,
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_pageController.hasClients) {
                            _pageController.animateToPage(
                              3,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: const Text(
                          'Далее',
                          style: TextStyle(
                            fontFamily: 'Roboto-Bold.ttf',
                            fontSize: 15.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF8D9BAC))),
                      ),
                    ),
                    const SizedBox(height: 40.0),
                  ],
                ),
              ),
            ),
            ///////////////
            ///////////
            Scaffold(
              body: SafeArea(
                child: ListView(
                  children: [
                    const SizedBox(height: 32.0),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Вход',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF394759)),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Введите свой пароль',
                          hintStyle: TextStyle(
                            fontFamily: 'Roboto-Regular.ttf',
                            fontSize: 15.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFA7B8C0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFC2D1D9), width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFC2D1D9), width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                        ),
                      ),
                    ),
                    const SizedBox(height: 33.0),
                    Container(
                      height: 52.0,
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          _signInWithAutoCodeExchange();
                        },
                        child: const Text(
                          'Войти',
                          style: TextStyle(
                            fontFamily: 'Roboto-Bold.ttf',
                            fontSize: 15.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF8D9BAC))),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Напомнить пароль',
                        style: TextStyle(
                          fontFamily: 'Roboto-Bold.ttf',
                          fontSize: 15.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF8D9BAC),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    try {
      _setBusyState();
      final TokenResponse? result = await _appAuth.token(TokenRequest(
          _clientId, _redirectUrl,
          refreshToken: _refreshToken,
          discoveryUrl: _discoveryUrl,
          scopes: _scopes));
      _processTokenResponse(result);
      await _testApi(result);
    } catch (_) {
      _clearBusyState();
    }
  }

  Future<void> _exchangeCode() async {
    try {
      _setBusyState();
      final TokenResponse? result = await _appAuth.token(TokenRequest(
          _clientId, _redirectUrl,
          authorizationCode: _authorizationCode,
          discoveryUrl: _discoveryUrl,
          codeVerifier: _codeVerifier,
          scopes: _scopes));
      _processTokenResponse(result);
      await _testApi(result);
    } catch (_) {
      _clearBusyState();
    }
  }

  Future<void> _signInWithNoCodeExchange() async {
    try {
      _setBusyState();
      //использовать конечную точку обнаружения, чтобы найти конфигурацию
      final AuthorizationResponse? result = await _appAuth.authorize(
        AuthorizationRequest(_clientId, _redirectUrl,
            discoveryUrl: _discoveryUrl, scopes: _scopes, loginHint: 'bob'),
      );

      // or just use the issuer
      // var result = await _appAuth.authorize(
      //   AuthorizationRequest(
      //     _clientId,
      //     _redirectUrl,
      //     issuer: _issuer,
      //     scopes: _scopes,
      //   ),
      // );
      if (result != null) {
        _processAuthResponse(result);
      }
    } catch (_) {
      _clearBusyState();
    }
  }

  Future<void> _signInWithAutoCodeExchange(
      {bool preferEphemeralSession = false}) async {
    try {
      _setBusyState();

      final result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _clientId,
          _redirectUrl,
          serviceConfiguration: _serviceConfiguration,
          scopes: _scopes,
          preferEphemeralSession: preferEphemeralSession,
        ),
      );

      // этот блок кода демонстрирует передачу значений для параметра приглашения. в этом случае он запрашивает у пользователя вход в систему, даже если у него есть уже зарегистрировался. список поддерживаемых значений зависит от поставщика удостоверений
      // final AuthorizationTokenResponse? result =
      //     await _appAuth.authorizeAndExchangeCode(
      //   AuthorizationTokenRequest(_clientId, _redirectUrl,
      //       serviceConfiguration: _serviceConfiguration,
      //       scopes: _scopes,
      //       promptValues: ['login']),
      // );

      if (result != null) {
        _processAuthTokenResponse(result);
        await _testApi(result);

        // Вот здесь ставим блок
        BlocProvider.of<AuthCubit>(context).onLogin();
      }
    } catch (_) {
      _clearBusyState();
    }
  }

  void _clearBusyState() {
    setState(() {
      _isBusy = false;
    });
  }

  void _setBusyState() {
    setState(() {
      _isBusy = true;
    });
  }

  void _processAuthTokenResponse(AuthorizationTokenResponse response) {
    setState(() {
      _accessToken = _accessTokenTextController.text = response.accessToken!;
      _idTokenTextController.text = response.idToken!;
      _refreshToken = _refreshTokenTextController.text = response.refreshToken!;
      _accessTokenExpirationTextController.text =
          response.accessTokenExpirationDateTime!.toIso8601String();
    });
  }

  void _processAuthResponse(AuthorizationResponse response) {
    setState(() {
      // сохранить верификатор кода так, как он должен использоваться при обмене токена
      _codeVerifier = response.codeVerifier;
      _authorizationCode =
          _authorizationCodeTextController.text = response.authorizationCode!;
      _isBusy = false;
    });
  }

  void _processTokenResponse(TokenResponse? response) {
    setState(() {
      _accessToken = _accessTokenTextController.text = response!.accessToken!;
      _idTokenTextController.text = response.idToken!;
      _refreshToken = _refreshTokenTextController.text = response.refreshToken!;
      _accessTokenExpirationTextController.text =
          response.accessTokenExpirationDateTime!.toIso8601String();
    });
  }

  Future<void> _testApi(TokenResponse? response) async {
    final http.Response httpResponse = await http.get(
        Uri.parse('https://demo.identityserver.io/api/test'),
        headers: <String, String>{'Authorization': 'Bearer $_accessToken'});
    setState(() {
      _userInfo = httpResponse.statusCode == 200 ? httpResponse.body : '';
      _isBusy = false;
    });
  }
}
