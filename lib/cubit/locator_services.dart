import 'package:blogonomy/Repository/card_repositoriesCateg.dart';
import 'package:blogonomy/cubit/bottom_navigation_bar.dart';
import 'package:blogonomy/cubit/network/admin_cubit.dart';
import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
final cardRepository = CardRepository();
final blogersRepository = BlogersRepository();
final filterRepository = FilterRepository();
final oneBlogerRepository = OneBlogerRepository();

Future<void> init() async {
  sl.registerFactory(() => SlidingUpCubit());
  sl.registerFactory(() => SlidingUpCubit2());
  sl.registerFactory(() => SlidingUpCubit3());
  sl.registerFactory(() => SlidingUpCubit4());
  sl.registerFactory(() => CardCubit(cardRepository));
  sl.registerFactory(() => BlogersCubit(blogersRepository));
  sl.registerFactory(() => FilterCubit(filterRepository));
  sl.registerFactory(() => OneBlogerCubit(oneBlogerRepository));
  sl.registerFactory(() => BottomNavigationControllerSelect());
  sl.registerFactory(() => AdminCubit());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  final FlutterAppAuth appAuth = FlutterAppAuth();
  sl.registerLazySingleton(() => appAuth);

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  sl.registerLazySingleton(() => secureStorage);
}
