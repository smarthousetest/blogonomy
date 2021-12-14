import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthState { auth, nextCollections }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.auth);

  void onLogin(/* Сюда передать токены, которые надо сохранить */) {
    // Тут сохрани токены в SharedPreferences.
    emit(AuthState.nextCollections);
  }

  void onLogout() {
    // Тут удали всё из SharedPreferences.
    emit(AuthState.auth);
  }
}