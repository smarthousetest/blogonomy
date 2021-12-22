import 'package:blogonomy/Repository/card_repositoriesCateg.dart';
import 'package:blogonomy/cubit/bottom_navigation_bar.dart';
import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
final cardRepository = CardRepository();
final blogersRepository = BlogersRepository();
<<<<<<< HEAD
final filterRepository = FilterRepository();
=======
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf

Future<void> init() async {
  sl.registerFactory(() => SlidingUpCubit());
  sl.registerFactory(() => SlidingUpCubit2());
<<<<<<< HEAD
  sl.registerFactory(() => SlidingUpCubit3());
  sl.registerFactory(() => SlidingUpCubit4());
  sl.registerFactory(() => CardCubit(cardRepository));
  sl.registerFactory(() => BlogersCubit(blogersRepository));
  sl.registerFactory(() => FilterCubit(filterRepository));
=======
  sl.registerFactory(() => CardCubit(cardRepository));
  sl.registerFactory(() => BlogersCubit(blogersRepository));
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
  sl.registerFactory(() => BottomNavigationControllerSelect());
}
